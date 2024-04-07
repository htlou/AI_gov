import pandas as pd
import json
from pathlib import Path

df = pd.read_csv('/data/hantao/cars/output_filtered.csv')

output_path = Path('/data/hantao/cars/output_filtered.json')

# 企业名称,英文名称,统一社会信用代码,企业类型,经营状态,成立日期,核准日期,法定代表人,注册资本,实缴资本,参保人数,公司规模,经营范围,注册地址,营业期限,纳税人识别号,工商注册号,组织机构代码,纳税人资质,曾用名,所属省份,所属城市,所属区县,网站链接,所属行业,一级行业分类,二级行业分类,三级行业分类,登记机关
result = []
for index, row in df.iterrows():
    # print(line)
    new_dict = {
        'name': row['企业名称'], # 企业名称
        'type': row['企业类型'], # 企业类型
        'date': row['成立日期'], # 成立日期
        'size': row['公司规模'], # 公司规模
        'range': row['经营范围'], # 经营范围
        'location': row['注册地址'], # 注册地址
        'province': row['所属省份'],
        'city': row['所属城市'],
        'county': row['所属区县'],
        'belong': row['所属行业'],
        'belong1': row['一级行业分类'],
        'belong2': row['二级行业分类'],
        'belong3': row['三级行业分类'],
    }
    # 将新的字典添加到结果列表中
    result.append(new_dict)

# df_result = pd.DataFrame(result)
with output_path.open(mode='w', encoding='utf-8') as f:
    json.dump(result, f, ensure_ascii=False, indent=4)