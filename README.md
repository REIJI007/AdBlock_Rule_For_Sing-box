[![GPL 3.0 license](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-GPL%203.0)
[![CC BY-NC-SA 4.0 license](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-CC-BY-NC-SA%204.0)
<!-- 居中的大标题 -->
<h1 align="center" style="font-size: 70px; margin-bottom: 20px;">AdBlock_Rule_For_Sing-box</h1>

<!-- 居中的副标题 -->
<h2 align="center" style="font-size: 30px; margin-bottom: 40px;">适用于Sing-box的广告域名拦截RULE-SET规则集，每20分钟更新一次</h2>

<!-- 徽章（根据需要调整） -->
<p align="center" style="margin-bottom: 40px;">
    <img src="https://img.shields.io/badge/last%20commit-today-brightgreen" alt="last commit" style="margin-right: 10px;">
    <img src="https://img.shields.io/github/forks/REIJI007/AdBlock_Rule_For_Sing-box" alt="forks" style="margin-right: 10px;">
    <img src="https://img.shields.io/github/stars/REIJI007/AdBlock_Rule_For_Sing-box" alt="stars" style="margin-right: 10px;">
    <img src="https://img.shields.io/github/issues/REIJI007/AdBlock_Rule_For_Sing-box" alt="issues" style="margin-right: 10px;">
    <img src="https://img.shields.io/github/license/REIJI007/AdBlock_Rule_For_Sing-box" alt="license" style="margin-right: 10px;">
</p>


**一、从多个广告过滤器中提取拦截域名条目，删除重复项，并将它们转换为兼容Sing-box的json格式和srs二进制格式，其中列表的每行都是被拦截域名，一行仅一条规则。该列表可以用作Sing-box的rule_set.以阻止广告域名， powershell脚本每20分钟自动执行并将生成的文件发布在release中.三个文件的下载地址分别如下，其中adblock_reject_domain.txt是单纯的带引号和逗号的被拦截域名列表
，adblock_reject.json是json格式的域名拦截rule_set规则集，adblock_reject.srs则是由sing-box核心将adblock_reject.json编译转化得来的规则集**
<br>
<br>
<table border="1" style="border-collapse: collapse; width: 100%; font-family: Arial, sans-serif;">
  <tr>
    <td colspan="2" style="background-color: #f2f2f2; font-weight: bold; text-align: center; padding: 10px;">订阅地址</td>
  </tr>
  <tr>
    <td style="padding: 8px;">JSON</td>
    <td style="padding: 8px;">
      <strong><a href="https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.json" style="color: #0066cc;">Github原始链接</a></strong> | 
      <strong><a href="https://cdn.jsdelivr.net/gh/REIJI007/AdBlock_Rule_For_Sing-box@main/adblock_reject.json" style="color: #0066cc;">jsDelivr 加速链接</a></strong>
    </td>
  </tr>
  <tr>
    <td style="padding: 8px;">SRS</td>
    <td style="padding: 8px;">
      <strong><a href="https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.srs" style="color: #0066cc;">Github原始链接</a></strong> | 
      <strong><a href="https://cdn.jsdelivr.net/gh/REIJI007/AdBlock_Rule_For_Sing-box@main/adblock_reject.srs" style="color: #0066cc;">jsDelivr 加速链接</a></strong>
    </td>
  </tr>
  <tr>
    <td style="padding: 8px;">拦截域名</td>
    <td style="padding: 8px;">
      <strong><a href="https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject_domain.txt" style="color: #0066cc;">Github原始链接</a></strong> | 
      <strong><a href="https://cdn.jsdelivr.net/gh/REIJI007/AdBlock_Rule_For_Sing-box@main/adblock_reject_domain.txt" style="color: #0066cc;">jsDelivr 加速链接</a></strong>
    </td>
  </tr>
</table>

<hr>

## 警告:本过滤器订阅有可能破坏某些网站的功能，也有可能封禁某些色情、赌博网站，使用前请斟酌考虑，如有误杀请积极向上游issue反馈，本仓库仅提供去重、筛选、合并功能

<hr>

**二、使用方式：**

   *使用方式：修改sing-box配置中的DNS模块和路由模块，JSON注意去掉注释，"route.rules"和 "route.rule_set"中的 "tag" 值需要保持一致*
<hr>

```conf
{
  "dns": 
  {
    "rules": 
    [
      {
        "rule_set": ["adblock"],            // 	在DNS查询域名阶段使用名为"adblock"的规则集来匹配域名
        "action": "reject"        		//	DNS层动作：拦截命中"adblock"规则集的域名
      }
    ]
  },
  "route": 
  {
    "rule_set": 
    [
      {
        "tag": "adblock",              // 定义名为"adblock"的规则集
        "type": "remote",              // 规则集来源为远程拉取
        "format": "source",            // 规则文件格式为 source
        "url": "https://raw.githubusercontent.com/REIJI007/AdBlock_Rule_For_Sing-box/main/adblock_reject.json",                                                                      
        "update_interval": "1h"        // 自动更新间隔：1 小时
      }
    ],
    "rules": 
    [
      {
        "rule_set": ["adblock"],       // 路由层使用名为"adblock"的规则集
        "action": "reject"             // 路由层动作：拒绝建立连接（注意：旧的 "outbound": "block" 已弃用）
      }
    ]
  }
}

```
<hr>


**三、本仓库引用的广告过滤规则来源请查看```Referencing rule sources.txt```（目前106个来源）。至于是否误杀域名完全取决于这些处于上游的广告过滤器的域名拦截行为，若不满意的话可按照第二条在本地使用powershell脚本进行DIY本地定制化拦截域名列表，亦或可以像本仓库一样DIY定制后部署到github上面，或者fork本仓库自行DIY**


**四、特别鸣谢**

1. [sing-box](https://github.com/SagerNet/sing-box)
2. [Adguard](https://github.com/AdguardTeam/AdGuardFilters)


## LICENSE
- [CC-BY-SA-4.0 License](https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-CC-BY-NC-SA%204.0)
- [GPL-3.0 License](https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE-GPL%203.0)
