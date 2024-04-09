# Basic Information

> ./data_process: 数据处理及分析代码

> ./visualization: 可视化分析文件

> ./annotation: 标注标准及文件

> ./assets: 数据分析可视化

> ./knowledge_graph__plot: 知识图谱绘制结果及相关源码

## Hints

The json data may be too long, you can check the data by jq command

```
jq '.[0:3]' patent_2016.json
```

> This command will print the first three items of patent_2016.json
