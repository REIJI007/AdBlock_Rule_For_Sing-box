package main

import (
	"bufio"
	"os"
	"strings"
	"log"
	"github.com/sagernet/sing-box/common/geosite"
)

// geosite.Item 类型的结构体
type Item struct {
	Type  geosite.RuleType
	Value string
}

// 1. 读取域名列表文件
func readDomainList(filename string) ([]string, error) {
	file, err := os.Open(filename)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var domains []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		// 跳过空行和注释
		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}
		domains = append(domains, line)
	}
	if err := scanner.Err(); err != nil {
		return nil, err
	}
	return domains, nil
}

// 2. 分类处理域名
func classifyDomains(domainList []string) map[string][]Item {
	domainMap := make(map[string][]Item)

	for _, domain := range domainList {
		var item Item
		if strings.HasPrefix(domain, ".*") && strings.HasSuffix(domain, ".*") {
			// 正则匹配
			item = Item{
				Type:  geosite.RuleTypeDomainRegex,
				Value: domain,
			}
		} else if strings.Contains(domain, "keyword") {
			// 关键字匹配
			item = Item{
				Type:  geosite.RuleTypeDomainKeyword,
				Value: domain,
			}
		} else {
			// 普通域名
			item = Item{
				Type:  geosite.RuleTypeDomain,
				Value: domain,
			}
		}
		// 把这个域名放到广告类别下
		domainMap["adblock"] = append(domainMap["adblock"], item)
	}

	return domainMap
}

// 3. 去重与过滤
func uniqueDomains(domainMap map[string][]Item) map[string][]Item {
	for code, items := range domainMap {
		uniqueItems := make(map[Item]bool)
		for _, item := range items {
			uniqueItems[item] = true
		}
		newList := make([]Item, 0, len(uniqueItems))
		for item := range uniqueItems {
			newList = append(newList, item)
		}
		domainMap[code] = newList
	}
	return domainMap
}

// 4. 写入二进制 .db 文件
func writeGeositeDB(output string, domainMap map[string][]Item) error {
	outputFile, err := os.Create(output)
	if err != nil {
		return err
	}
	defer outputFile.Close()

	writer := bufio.NewWriter(outputFile)
	for code, items := range domainMap {
		writer.WriteString("[" + code + "]\n")
		for _, item := range items {
			writer.WriteString(item.Type.String() + " " + item.Value + "\n")
		}
	}
	return writer.Flush()
}

func main() {
	// 1. 读取位于 GitHub 仓库根目录的 adblock.txt 文件
	domainList, err := readDomainList("./adblock.txt")
	if err != nil {
		log.Fatal("Error reading domain list: ", err)
	}

	// 2. 分类域名
	domainMap := classifyDomains(domainList)

	// 3. 去重与过滤
	domainMap = uniqueDomains(domainMap)

	// 4. 生成 adblock.db 文件
	err = writeGeositeDB("adblock.db", domainMap)
	if err != nil {
		log.Fatal("Error writing adblock.db: ", err)
	}

	log.Println("adblock.db generated successfully!")
}
