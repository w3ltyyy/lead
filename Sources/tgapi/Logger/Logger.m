#import <Foundation/Foundation.h>
#import "Logger.h"
#include <zlib.h>

// Declaration for LSBundleProxy
@interface LSBundleProxy : NSObject
@property (nonatomic, assign, readonly) NSDictionary *entitlements;
@property (nonatomic, assign, readonly) NSDictionary *groupContainerURLs;
+ (instancetype)bundleProxyForCurrentProcess;
@end

// Static queue for logging
static dispatch_queue_t logQueue;

// Static function to fetch App Group info
static NSDictionary *getAppGroup() {
    static NSDictionary *cachedGroup = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        LSBundleProxy *bundleProxy = [LSBundleProxy bundleProxyForCurrentProcess];
        NSDictionary *entitlements = bundleProxy.entitlements;

        if (entitlements) {
            NSArray *appGroups = entitlements[@"com.apple.security.application-groups"];
            if (appGroups && appGroups.count > 0) {
                NSString *appGroupName = appGroups.firstObject;
                NSURL *appGroupURL = bundleProxy.groupContainerURLs[appGroupName];
                NSString *appGroupPath = appGroupURL.path;

                if (appGroupName && appGroupPath) {
                    cachedGroup = @{
                        @"name": appGroupName,
                        @"path": appGroupPath
                    };
                } else {
                    cachedGroup = nil;
                }
            }
        }
    });

    return cachedGroup;
}

// Static function to get the log file path
static NSString *logFilePath() {
    static NSString *path = nil;
    static dispatch_once_t token;

    dispatch_once(&token, ^{
        NSDictionary *appGroup = getAppGroup();
        NSFileManager *fileManager = [NSFileManager defaultManager];

        if (appGroup) {
            NSString *bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
            NSString *chocoWhoreDir = [appGroup[@"path"] stringByAppendingPathComponent:@"group.choco.whore"];
            NSString *logFileName = [NSString stringWithFormat:@"%@.txt", bundleIdentifier];
            path = [chocoWhoreDir stringByAppendingPathComponent:logFileName];

            // Ensure the directory exists
            if (![fileManager fileExistsAtPath:chocoWhoreDir]) {
                NSError *error = nil;
                [fileManager createDirectoryAtPath:chocoWhoreDir
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:&error];
                if (error) {
                    NSLog(@"Failed to create directory %@: %@", chocoWhoreDir, error.localizedDescription);
                }
            }

            // Ensure the file exists
            if (![fileManager fileExistsAtPath:path]) {
                [fileManager createFileAtPath:path contents:nil attributes:nil];
            }
        } else {
            // Fallback to the Documents directory
            path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/chocoLogs.txt"];

            // Ensure the file exists
            if (![fileManager fileExistsAtPath:path]) {
                [fileManager createFileAtPath:path contents:nil attributes:nil];
            }
        }
    });

    return path;
}

// Static logging function
void customLog(NSString *format, ...) {
	static dispatch_once_t token;
	dispatch_once(&token, ^{
		logQueue = dispatch_queue_create("com.choco.whore", DISPATCH_QUEUE_SERIAL);
	});
	
	va_list args;
	va_start(args, format);
	NSString *formattedMessage = [[NSString alloc] initWithFormat:format arguments:args];
	va_end(args);

    // Also log to NSLog so it appears in Console.app
    NSLog(@"%@", formattedMessage);
		
    dispatch_async(logQueue, ^{
        // Format the log message
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate:currentDate];

        NSString *logMessage = [NSString stringWithFormat:@"%@ - %@\n", dateString, formattedMessage];

        // Write the log message to the file
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:logFilePath()];
        if (fileHandle) {
            [fileHandle seekToEndOfFile];
            [fileHandle writeData:[logMessage dataUsingEncoding:NSUTF8StringEncoding]];
            [fileHandle closeFile];
        }
    });
}

void customLog2(NSString *format, ...) {
    static dispatch_queue_t queue;
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        queue = dispatch_queue_create("com.lead.debuglog", DISPATCH_QUEUE_SERIAL);
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm:ss"];
    });

    va_list args;
    va_start(args, format);
    NSString *formattedMessage = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    NSDate *currentDate = [NSDate date];

    // Called from layout and network hooks — never touch the disk on the caller's thread.
    dispatch_async(queue, ^{
        NSString *logMessage = [NSString stringWithFormat:@"%@ %@\n", [dateFormatter stringFromDate:currentDate], formattedMessage];
        NSData *logData = [logMessage dataUsingEncoding:NSUTF8StringEncoding];

        // Always write to Documents — works on non-jb sideload without app group
        NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/lead_debug.txt"];
        NSFileManager *fm = [NSFileManager defaultManager];
        unsigned long long size = [[fm attributesOfItemAtPath:path error:nil] fileSize];
        // Keep the debug log bounded; start over once it passes 1 MB.
        if (![fm fileExistsAtPath:path] || size > 1024 * 1024) {
            [fm createFileAtPath:path contents:nil attributes:nil];
        }
        NSFileHandle *fh = [NSFileHandle fileHandleForWritingAtPath:path];
        if (fh) {
            [fh seekToEndOfFile];
            [fh writeData:logData];
            [fh closeFile];
        }
    });
}

NSData *decompressGzip(const void *input, size_t inputLen) {
    if (!input || inputLen < 2) return nil;

    z_stream strm;
    memset(&strm, 0, sizeof(strm));
    strm.next_in  = (Bytef *)input;
    strm.avail_in = (uInt)inputLen;

    if (inflateInit2(&strm, 47) != Z_OK) return nil;

    NSMutableData *result = [NSMutableData dataWithCapacity:inputLen * 4];
    uint8_t buf[65536];
    int ret;
    do {
        strm.next_out  = buf;
        strm.avail_out = sizeof(buf);
        ret = inflate(&strm, Z_NO_FLUSH);
        if (ret < 0 && ret != Z_BUF_ERROR) { inflateEnd(&strm); return nil; }
        NSUInteger produced = sizeof(buf) - strm.avail_out;
        if (produced > 0) [result appendBytes:buf length:produced];
        if (ret == Z_BUF_ERROR && produced == 0) break;
        // Keep going while inflate filled the whole buffer: it may still hold output
        // after consuming all input. Stopping on avail_in == 0 alone truncated
        // payloads larger than 64 KB.
    } while (ret != Z_STREAM_END && (strm.avail_in > 0 || strm.avail_out == 0));

    inflateEnd(&strm);
    // A partial stream must never be handed back as a valid TL payload.
    if (ret != Z_STREAM_END) return nil;
    return (result.length > 0) ? result : nil;
}
