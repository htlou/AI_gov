from neo4j import GraphDatabase
import csv

# 连接到 Neo4j 数据库
uri = "neo4j+s://3561541e.databases.neo4j.io"
username = "neo4j"
password = "Jofh8ZFZBAvYaQMCw_HfHEXqUejC1b3c0dQM4rz0eYk"

driver = GraphDatabase.driver(uri, auth=(username, password))

# 加载数据到 Neo4j 数据库
def create_nodes_from_csv(tx, filename, name_index):
    with open(filename, 'r', encoding='utf-8') as file:
        reader = csv.reader(file)
        headers = next(reader)
        for row in reader:
            node_properties = {headers[i]: row[i] for i in range(len(headers))}
            node_name = row[name_index]
            tx.run("CREATE (n:Node {name: $name}) SET n = $props", name=node_name, props=node_properties)
def create_relationships_from_csv(tx, filename):
    with open(filename, 'r', encoding='utf-8') as file:
        reader = csv.reader(file)
        for row in reader:
            # 创建关系
            tx.run("""
                MATCH (start:Node {name: $start_name})
                MATCH (end:Node {name: $end_name})
                CREATE (start)-[:%s]->(end)
            """ % row[2], start_name=row[0], end_name=row[1])

with driver.session() as session:
    session.write_transaction(create_nodes_from_csv, "D:\AISocialtechnique\数据处理\专利数据.csv",1)
    session.write_transaction(create_relationships_from_csv, "relation.csv")


