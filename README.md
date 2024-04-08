# Basic Information

> ./data_process: contains data preprocessing files
> ./visualization: files for plotting knowledge graph and data analysis
> ./annotation: standards and annotation files
> ./assets: fancy visualization

## Hints

The json data may be too long, you can check the data by jq command

```
jq '.[0:3]' patent_2016.json
```

> This command will print the first three items of patent_2016.json
