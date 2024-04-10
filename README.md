# Basic Information

> ./data_process: 数据处理及分析代码

> ./visualization: 可视化分析文件

> ./annotation: 标注标准及文件
- open-source_annotator.py: 本地模型标注脚本，使用vllm并行加速
- GPT-4的调用参考htlou/gpt4_eval，我们使用了这个库的fork
- system_prompt.py: 我们标注时的prompt

> ./assets: 数据分析可视化

> ./knowledge_graph__plot: 知识图谱绘制部分结果及相关源码，更多细节将在课上展示

## Hints

The json data may be too long, you can check the data by jq command

```
jq '.[0:3]' patent_2016.json
```

> This command will print the first three items of patent_2016.json
