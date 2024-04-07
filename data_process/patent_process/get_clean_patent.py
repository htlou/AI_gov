# Filtered the patent json data for necessary 

import os
import json
from tqdm import tqdm
from data_process.patent_process.patent_utils import get_output_file_name

# 指定目录路径
input_directory = '/mntmodels/boyuan/learnspace/AI_gov/raw_data/research_data/patent_data_all/data_json'
output_directory = '/mntmodels/boyuan/learnspace/AI_gov/raw_data/research_data/patent_data_all/data_json_filtered'
os.makedirs(output_directory, exist_ok=True)

# 需要提取的键
required_keys = [
    '专利号', '专利名称', '专利类型', '申请日', '公开日', '授权日',
    '专利代理机构', '专利法律状态', '申请人类型', '主申请人名称',
    '主申请人地址', '主申请人地址国家', '累计被引用量', '主分类号',
    '专利分类号', '专利分类号数量','国民经济行业分类代码','国民经济行业分类名称'
]

# 遍历目录中的所有文件
for root, dirs, files in os.walk(input_directory):
    for file in tqdm(files):
        if file.endswith('.json'):
            file_path = os.path.join(root, file)
            with open(file_path, 'r', encoding='utf-8') as json_file:
                data = json.load(json_file)

            output_data = []

            # 处理每个条目（假设每个文件中的顶级元素是一个列表）
            for item in data:
                # 对于列表中的每个字典项，尝试提取所需的键
                try:
                    extracted_entry = {key: item.get(key, None) for key in required_keys}
                    output_data.append(extracted_entry)
                except AttributeError as e:
                    print(f"Error processing file {file}: {e}")
                    # 如果项不是字典，你可以选择如何处理这个错误，比如跳过或退出
                    # sys.exit(1)

            # 构造输出文件的完整路径
            output_file_name = get_output_file_name(file)
            output_file_path = os.path.join(output_directory, output_file_name)
            
            # 将提取的数据保存到新的JSON文件中
            with open(output_file_path, 'w', encoding='utf-8') as output_file:
                json.dump(output_data, output_file, ensure_ascii=False, indent=4)

            print(f"Filtered data have been saved to {output_file_path}")
