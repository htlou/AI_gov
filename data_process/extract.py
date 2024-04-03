import pandas as pd

df = pd.read_csv('info.csv')

output_path = 'output_more.csv'

# keyword = '汽车'
keywords = ["汽车", "机动车", "客车", "货车"]  # 要搜索的关键词列表
regex_pattern = '|'.join(keywords)

# matching_rows = df[df.apply(lambda row: row.astype(str).str.contains(keyword, case=False).any(), axis=1)]
matching_rows = df[df.apply(lambda row: row.astype(str).str.contains(regex_pattern, case=False, regex=True).any(), axis=1)]
matching_rows.to_csv(output_path, index=False)