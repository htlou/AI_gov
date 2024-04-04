## Note

This directory contains all files used for patent data process
Since we have make too many data preprocessing files, it may be better to arrange according to the purpose

## Methods


> **csv_to_json.py** : general python file for csv to json

> **get_clean_patent.py** : filter the patent json data for necessary items, *e.g.*, 专利号，专利名称，专利类型，申请日，公开日，授权日，专利代理机构，专利法律状态，申请人类型，主申请人名称，主申请人地址，主申请人地址国家。累计被引用量，主分类号，专利分类号，专利分类号数量
## Hints

The json data may be too long, you can check the data by jq command

```
jq '.[0:3]' patent_2016.json
```

> This command will print the first three items of patent_2016.json


## Example Patent Data
```
  {
    "专利号": "CN103411796B",
    "专利名称": "一种减压蒸馏连续操作间歇取样装置",
    "递交申请专利局": "CN",
    "专利类型": "发明授权",
    "申请日": "2013-08-29",
    "公开日": "2013-11-27",
    "授权日": "2015-09-16",
    "权力要求数": 3,
    "专利存续最后年份": 2013,
    "专利代理机构": "西安永生专利代理有限责任公司",
    "专利法律状态": "实质审查的生效",
    "申请人类型": null,
    "主申请人名称": null,
    "主申请人地址": null,
    "主申请人地址国家": null,
    "主申请人邮编": null,
    "其他申请人名称": null,
    "其他申请人地址": null,
    "其他申请人地址国家": null,
    "发明人": null,
    "发明人数量": null,
    "PCT申请日期": null,
    "PCT公布日期": null,
    "PCT外国授权国家": null,
    "PCT外国授权国家数量": null,
    "简单同族专利数量": null,
    "是否第三方专利triadpatent": null,
    "简单同族专利被引数量中国": null,
    "简单同族专利被引数量美国": null,
    "简单同族专利被引数量日本": null,
    "简单同族专利被引数量韩国": null,
    "简单同族专利被引数量欧专局": null,
    "前引总数": null,
    "前引专利号": null,
    "科学关联度ScienceLinkageSL": null,
    "技术生命周期technologycycletimeTCT": null,
    "公开公告日后第1年内后引数": null,
    "公开公告日后第2年内后引数": null,
    "公开公告日后第3年内后引数": null,
    "公开公告日后第4年内后引数": null,
    "公开公告日后第5年内后引数": null,
    "累计被引用量": null,
    "主分类号": null,
    "专利分类号": null,
    "专利分类号数量": null,
    "公开后第1年转让次数": null,
    "公开后第2年转让次数": null,
    "公开后第3年转让次数": null,
    "公开后第4年转让次数": null,
    "公开后第5年转让次数": null,
    "累积专利转让次数": null,
    "公开后第1年许可次数": null,
    "公开后第2年许可次数": null,
    "公开后第3年许可次数": null,
    "公开后第4年许可次数": null,
    "公开后第5年许可次数": null,
    "累积专利许可次数": null,
    "专利是否质押": null,
    "WIPO行业分类代码": null,
    "WIPO行业分类名称": null,
    "国民经济行业分类代码": null,
    "国民经济行业分类名称": null
  },
```