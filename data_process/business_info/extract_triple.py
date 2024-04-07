import json
from pathlib import Path
import re

Big = [
    "研发与设计",
    "整车组装",
    "辅助系统生产",
    "车身制造",
    "发动机制造",
    "汽车底盘生产",
    "电气设备生产",
    "汽车销售",
    "汽车维修与服务"
]

Small = [
    "整车组装",
    "制造工艺研发与设计",
    "专用技术研发与设计",
    "汽车产业人员培训",
    "汽车安保系统生产",
    "汽车安全装置生产",
    "多媒体装置生产",
    "复合材料生产",
    "健康环保装置生产",
    "模具生产",
    "汽车测试",
    "智能装置生产",
    "车窗生产",
    "车门生产",
    "车身壳体生产",
    "内外装饰及附件生产",
    "座椅生产",
    "车厢生产",
    "曲柄连杆机构生产",
    "配气机构生产",
    "润滑系统生产",
    "冷却系统生产",
    "燃料供给系统生产",
    "点火系统生产",
    "启动系统生产",
    "电动机生产",
    "发动机配件生产",
    "传动系统生产",
    "行驶系统生产",
    "转向系统生产",
    "制动系统生产",
    "车架生产",
    "车轮生产",
    "蓄电池生产",
    "发电机生产",
    "电控单元生产",
    "传感器生产",
    "控制器生产",
    "车灯生产",
    "电控系统生产",
    "空调与冰箱生产",
    "电线生产",
    "仪表盘生产",
    "其他用电装置生产",
    "汽车销售",
    "汽车配件生产",
    "汽车维修",
    "汽车检测与服务",
    "汽车配件销售",
    "电池生产",
    "汽车零配件销售",
]

input_file = Path("/data/hantao/cars/output_filtered.tmp_re_output.json").expanduser().absolute()
output_file = Path("/data/hantao/cars/output_extracted_new.json").expanduser().absolute()

with input_file.open(mode='rt', encoding='utf-8') as f:
    raw_inputs = json.load(f)

pattern = r'\[\[(.*?)\]\]:\s*(.*?)\n\n'

final = []
for raw_input in raw_inputs:
    info = raw_input["output"]
    matches = re.finditer(pattern, info)
    categories = {"Big": [], "Small": [], "Extra": []}  # 确保始终有这三项
    for category_group in matches:
        category_name = category_group.group(1)  # 类别名称
        items_str = category_group.group(2)  # 对应的所有项的字符串
        items = re.findall(r'{{(.*?)}}', items_str)  # 提取具体项
        if category_name == "大类":
            categories["Big"] = [item for item in items if item in Big]
            categories["Extra"].extend([item for item in items if item not in Big])
        elif category_name == "子类别":
            categories["Small"] = [item for item in items if item in Small]
            categories["Extra"].extend([item for item in items if item not in Small])
        else:
            categories["Extra"].extend(items)
    
    categories["Extra"] = list(set(categories["Extra"]))
    if categories["Big"]!=[] or categories["Small"]!=[] or categories["Extra"]!=[]:
        raw_input["output_extracted"] = categories
        final.append(raw_input)

def split_actions(item):
    # 先定义一系列可能的动作
    actions = ["生产", "销售", "维修", "设计", "制造", "测试", "检测", "服务", "培训"]
    pattern = '|'.join(actions)

    # 尝试找到客体，它通常在字符串的开始
    object_match = re.search(f'^(.*?)({pattern})', item)
    if object_match:
        shared_object = object_match.group(1).strip()  # 共享的客体，例如“汽车”
    else:
        shared_object = ""  # 如果没有匹配到，可能没有明确的客体

    # 找到所有动作词的位置
    matches = list(re.finditer(pattern, item))
    results = []

    for match in matches:
        action = match.group(0)  # 动作词
        # 确定动作词之后直至下一个动作词之前的部分作为客体（如果有）
        start, end = match.end(), matches[matches.index(match) + 1].start() if matches.index(match) + 1 < len(matches) else None
        specific_object = item[start:end].strip('与和') if end else item[start:].strip('与和')
        # 如果这个动作没有明确的客体，则使用共享的客体
        object_to_use = specific_object if specific_object else shared_object
        results.append({"action": action, "object": object_to_use})

    return results

final_new = []
# 假设final已经包含了解析好的分类数据
for entry in final:
    output_extracted = entry.get("output_extracted", {})
    for category in ["Big", "Small", "Extra"]:
        new_category_items = []
        for item in output_extracted.get(category, []):
            # 使用新的分割函数
            action_object_pairs = split_actions(item)
            new_category_items.extend(action_object_pairs)
        output_extracted[category] = new_category_items
    entry["output_extracted"] = output_extracted
    final_new.append(entry)



with output_file.open(mode='w', encoding='utf-8') as f:
    json.dump(final_new, f, indent=4, ensure_ascii=False)
