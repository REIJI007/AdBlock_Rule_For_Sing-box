<div align="center">

# AdBlock Rule For Sing-box

**适用于 Sing-box 的广告域名拦截规则集**

[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-GPL%203.0)
[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-CC-BY-NC-SA%204.0)
[![Last Commit](https://img.shields.io/badge/last%20commit-today-brightgreen)]
[![Stars](https://img.shields.io/github/stars/REIJI007/AdBlock_Rule_For_Sing-box)]
[![Issues](https://img.shields.io/github/issues/REIJI007/AdBlock_Rule_For_Sing-box)]

</div>

**链接**

---

<table>
  <thead>
    <tr>
      <th>格式</th>
      <th>订阅链接</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><b>JSON</b></td>
      <td>
        <a href="https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.json">GitHub原始链接</a> ·
        <a href="https://cdn.jsdelivr.net/gh/REIJI007/AdBlock_Rule_For_Sing-box@main/adblock_reject.json">jsDelivr加速链接</a> ·
        <a href="https://cdn.statically.io/gh/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.json">Statically加速链接</a>
      </td>
    </tr>
    <tr>
      <td><b>SRS</b></td>
      <td>
        <a href="https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.srs">GitHub原始链接</a> ·
        <a href="https://cdn.jsdelivr.net/gh/REIJI007/AdBlock_Rule_For_Sing-box@main/adblock_reject.srs">jsDelivr加速链接</a> ·
        <a href="https://cdn.statically.io/gh/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.srs">Statically加速链接</a>
      </td>
    </tr>
    <tr>
      <td><b>拦截域名</b></td>
      <td>
        <a href="https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject_domain.txt">GitHub原始链接</a> ·
        <a href="https://cdn.jsdelivr.net/gh/REIJI007/AdBlock_Rule_For_Sing-box@main/adblock_reject_domain.txt">jsDelivr加速链接</a> ·
        <a href="https://cdn.statically.io/gh/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject_domain.txt">Statically加速链接</a>
      </td>
    </tr>
  </tbody>
</table>

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
