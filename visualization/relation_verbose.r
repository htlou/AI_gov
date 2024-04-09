options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
# update.packages()
# install.packages(c("systemfonts", "RcppEigen"))
# install.packages("ggraph")
# install.packages("igraph")
# install.packages("tidyverse")
# install.packages("viridis")
library(ggraph)
library(igraph)
library(tidyverse)
library(viridis)
library(dplyr)
library(showtext)
library(RColorBrewer)
font_add_google("Noto Sans SC", "noto")
showtext_auto()

# edges <- flare$edges
# vertices <- flare$vertices
# print(edges)
# print(vertices)
edges_df <- read.csv("../Graph_drawing/divide.csv", stringsAsFactors = FALSE)
edges_df <- edges_df[, c("Big", "Small")]
names(edges_df) <- c("from", "to")
print(edges_df)
df <- lapply(edges_df, function(x) if(is.character(x)) trimws(x) else x)

# graph_obj <- graph_from_data_frame(edges_df, directed=TRUE)
# print(graph_obj)
vertices_df <- read.csv("../Graph_drawing/num.csv", stringsAsFactors = FALSE)
vertices_df$size <- runif(nrow(vertices_df))
print(vertices_df$name)

# edges_df_filtered <- edges_df %>%
#   filter(from %in% vertices_df$name & to %in% vertices_df$name)

# print("汽车销售" %in% vertices_df$name)  # 应返回TRUE
# print("汽车配件销售" %in% vertices_df$name)

# print(edges_df_filtered)
# Rebuild the graph object
# edges_vertices <- unique(c(edges_df$from, edges_df$to))

# # 创建顶点数据框中所有唯一顶点的向量
# vertices_names <- unique(vertices_df$name)

# # 找出在边缘列表中但不在顶点列表中的顶点
# missing_vertices <- setdiff(edges_vertices, vertices_names)

# # 打印缺失的顶点
# print(missing_vertices)

mygraph <- graph_from_data_frame(df, vertices=vertices_df, directed = TRUE)
print(mygraph)
# left
p <- ggraph(mygraph, layout = 'circlepack', weight=size ) + 
  geom_node_circle(aes(fill = depth), color = NA) +
  geom_node_label(aes(label=name, filter=leaf, size=size), label.size = NA, label.padding = unit(0.1, "lines")) +
  theme_void() + 
  theme(legend.position="none", text = element_text(family = "noto", size = 14)) + 
  scale_fill_gradient(low = "#FFFDD7", high = "#DC6B19") +
  scale_size(range = c(3, 12))  # 这里调整size的范围以适应圆圈大小
  # scale_fill_gradient2(low = "red", mid = "white", high = "blue")
  # scale_fill_brewer(palette="Pastel1")
  # scale_fill_manual(values=c("##66CCFF", "##FFFAB7", "##FFD1E3"))
  # scale_fill_viridis()
# p <- ggraph(mygraph, layout = 'circlepack', weight=size ) + 
#   geom_node_circle(aes(fill = depth)) +
#   geom_node_label( aes(label=name, filter=leaf, size=size)) +
#   theme_void() + 
#   theme(legend.position="FALSE", text = element_text(family = "noto")) + 
#   scale_fill_viridis()

ggsave("../assets/relation_verbose_label.png", p, width=12, height=10, dpi=400)
# p <- ggraph(mygraph, layout = 'circlepack', weight = V(mygraph)$size) + 
#   geom_node_circle(aes(fill = depth)) +
#   geom_node_text(aes(label = type, filter = leaf), size = 3) +  # 移除 fill=depth, size=size 在这里可能不适用
#   theme_void() + 
#   theme(legend.position = "none") + 
#   scale_fill_viridis()

# # 保存图形
# ggsave("../assets/relation_verbose.png", p, width = 10, height = 10, dpi = 300)