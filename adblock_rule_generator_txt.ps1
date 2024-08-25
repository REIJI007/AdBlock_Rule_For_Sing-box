# Title: AdBlock_Rule_For_Sing-box
# Description: 适用于Sing-box的域名拦截列表，每20分钟更新一次，确保即时同步上游减少误杀
# Homepage: https://github.com/REIJI007/AdBlock_Rule_For_Sing-box

# 定义广告过滤器URL列表
$urlList = @(
    # (这里是你的URL列表)
)

# 日志文件路径
$logFilePath = "$PSScriptRoot/adblock_log.txt"

# 创建一个HashSet来存储唯一的规则
$uniqueRules = [System.Collections.Generic.HashSet[string]]::new()

# 创建WebClient对象用于下载URL内容
$webClient = New-Object System.Net.WebClient
$webClient.Encoding = [System.Text.Encoding]::UTF8
$webClient.Proxy = $null

# 定义域名验证函数
function IsValidDomain {
    param (
        [string]$domain
    )

    # 使用正则表达式验证域名
    if ($domain -match '^(?!\-)([a-zA-Z0-9-]{1,63}\.)+[a-zA-Z]{2,}$') {
        return $true
    } else {
        return $false
    }
}

foreach ($url in $urlList) {
    Write-Host "正在处理: $url"
    Add-Content -Path $logFilePath -Value "正在处理: $url"
    try {
        $content = $webClient.DownloadString($url)
        $lines = $content -split "`n"
        foreach ($line in $lines) {
            $line = $line.Trim()
            
            # 忽略空行和注释
            if ([string]::IsNullOrWhiteSpace($line) -or $line.StartsWith("#")) {
                continue
            }

            # 直接忽略以@@开头的规则
            if ($line -match '^@@\|\|') {
                continue
            }
            # 处理形如||example.com^的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^\|\|([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\^$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如||*.example.com^的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^\|\|\*\.([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\^$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如example.com的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如||example.com^$all的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^\|\|([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\^\$all$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如/^[a-z0-9-]+\.example\.com$/的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^/\^[a-z0-9-]+\.([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\$/$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如address=/example.com/0.0.0.0的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^address=/([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})/0\.0\.0\.0$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如/^example\.com$/的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^/\^([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\$/$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如/^([a-z0-9-]+\.)?example\.com$/的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^/\^([a-z0-9-]+\.)?\s*([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\$/$') {
                $domain = $Matches[2]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如address=/example.com/127.0.0.1的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^address=/([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})/127\.0\.0\.1$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如127.0.0.1 example.com的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^127\.0\.0\.1\s+([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 处理形如0.0.0.0 example.com的域名，加上前缀"domain_suffix,"
            elseif ($line -match '^0\.0\.0\.0\s+([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$') {
                $domain = $Matches[1]
                if (IsValidDomain($domain)) {
                    $uniqueRules.Add("domain_suffix,$domain") | Out-Null
                }
            }
            # 忽略其他形如||example.com^$的域名
            elseif ($line -match '^\|\|([a-zA-Z0-9.-]+\.[a-zA-Z]{2,})\^\$') {
                continue
            }
            # 其余不符合上述处理逻辑的条目一律忽略
        }
    }
    catch {
        Write-Host "处理 $url 时出错: $_"
        Add-Content -Path $logFilePath -Value "处理 $url 时出错: $_"
    }
}

# 统计生成的规则条目数量
$ruleCount = $uniqueRules.Count

# 获取当前东八区时间
$timeZoneInfo = [System.TimeZoneInfo]::FindSystemTimeZoneById("China Standard Time")
$localTime = [System.TimeZoneInfo]::ConvertTime([System.DateTime]::UtcNow, $timeZoneInfo)
$generatedTime = $localTime.ToString("yyyy-MM-dd HH:mm:ss")

# 将所有规则连接成一个字符串，并为每个规则添加逗号（最后一条不加）
$formattedRules = $uniqueRules | ForEach-Object { "$_," }

# 仅在规则不为空时，移除最后一条规则的逗号
if ($formattedRules.Count -gt 0) {
    $formattedRules[-1] = $formattedRules[-1].TrimEnd(',')
}

# 创建文本格式的字符串
$textContent = @"
# Title: AdBlock_Rule_For_Sing-box
# Description: 适用于Sing-box的域名拦截列表，每20分钟更新一次，确保即时同步上游减少误杀
# Homepage: https://github.com/REIJI007/AdBlock_Rule_For_Sing-box
# LICENSE1：https://github.com/REIJI007/AdBlock_Rule_For_Sing-box/blob/main/LICENSE
# LICENSE2：https://opensource.org/licenses/MIT
# Total Count: $ruleCount
# Generated Time: $generatedTime
$($formattedRules -join "`n")
"@

# 输出文件路径
$outputPath = "$PSScriptRoot/adblock_rules.txt"

# 保存到文件
$textContent | Out-File -FilePath $outputPath -Encoding UTF8

Write-Host "生成的规则已保存至: $outputPath"
