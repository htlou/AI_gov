# Basic Information

./data_process contains data preprocessing files by hantao and boyuan

## Hints

The json data may be too long, you can check the data by jq command

```
jq '.[0:3]' patent_2016.json
```

> This command will print the first three items of patent_2016.json
