import os
import json

bundle_path = "/Users/matvey/Documents/lead/TGExtra-main/Lead.bundle"
lprojs = [d for d in os.listdir(bundle_path) if d.endswith(".lproj")]

out = "NSDictionary *GetAllTranslations(NSString *code) {\n"

for lproj in lprojs:
    code = lproj.replace(".lproj", "")
    strings_path = os.path.join(bundle_path, lproj, "Localizable.strings")
    if not os.path.exists(strings_path): continue
    
    out += f'    if ([code isEqualToString:@"{code}"]) {{\n'
    out += f'        return @{{\n'
    
    with open(strings_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("/*") or line.startswith("//"): continue
            if "=" in line:
                key, val = line.split("=", 1)
                key = key.strip().strip('"')
                val = val.strip().strip('";')
                # Escape quotes
                val = val.replace('"', '\\"')
                out += f'            @"{key}": @"{val}",\n'
                
    out += f'        }};\n'
    out += f'    }}\n'

out += "    return nil;\n}\n"

with open("/Users/matvey/Documents/lead/TGExtra-main/Sources/tgapi/UI/EmbeddedLangs.h", "w", encoding='utf-8') as f:
    f.write(out)
