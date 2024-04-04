# general python file for csv to json

import pandas as pd
import glob
import os
import json
from tqdm import tqdm

# 设置你的目录路径
directory_path = '/mntmodels/boyuan/learnspace/AI_gov/raw_data/research_data/发明专利数据2015-2020'

# 获取目录下所有的CSV文件
csv_files = glob.glob(os.path.join(directory_path, '*.csv'))

for csv_file in tqdm(csv_files):
    # 读取CSV文件
    df = pd.read_csv(csv_file)
    
    # 转换为JSON格式的字符串，注意这里不直接写入文件
    json_str = df.to_json(orient='records', lines=False)
    
    # 解析JSON字符串为Python对象，以便使用json模块进行处理
    data = json.loads(json_str)
    
    # 构建JSON文件名（假设你想保持原始文件名，但以.json扩展名保存）
    json_filename = os.path.splitext(os.path.basename(csv_file))[0] + '.json'
    output_directory = os.path.join(directory_path,'data_json/')
    os.makedirs(output_directory,exist_ok=True)
    json_path = os.path.join(output_directory, json_filename)
    
    # 保存到文件，使用json.dump，并设置ensure_ascii=False以保持非ASCII字符
    with open(json_path, 'w', encoding='utf-8') as json_file:
        json.dump(data, json_file, ensure_ascii=False, indent=4)
        
print(f'Csv files in directory {directory_path} have been converted into json files!!')
