<div align="center">

# AdBlock Rule For Sing-box

**适用于 Sing-box 的广告域名拦截规则集**

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-GPL%203.0)
[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-CC-BY-NC-SA%204.0)
[![Last Commit](https://img.shields.io/badge/last%20commit-today-brightgreen)]
[![Stars](https://img.shields.io/github/stars/REIJI007/AdBlock_Rule_For_Sing-box)]
[![Issues](https://img.shields.io/github/issues/REIJI007/AdBlock_Rule_For_Sing-box)]

</div>

## 📥 订阅链接

选择所需的规则格式，点击链接即可获取对应的订阅文件。

| 格式 | 订阅文件 | GitHub 原始订阅 |
| :---: | :--- | :---: |
| **JSON** | `adblock_reject.json` | [获取订阅 ↗](https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.json) |
| **SRS** | `adblock_reject.srs` | [获取订阅 ↗](https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.srs) |
| **域名列表** | `adblock_reject_domain.txt` | [获取订阅 ↗](https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject_domain.txt) |

**配置**

---

```json
{
  "dns": {
    "rules": [
      {
        "rule_set": ["adblock"],
        "action": "reject"
      }
    ]
  },
  "route": {
    "rule_set": [
      {
        "tag": "adblock",
        "type": "remote",
        "format": "source",
        "url": "https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.json",
        "update_interval": "1h"
      }
    ],
    "rules": [
      {
        "rule_set": ["adblock"],
        "action": "reject"
      }
    ]
  }
}
```
