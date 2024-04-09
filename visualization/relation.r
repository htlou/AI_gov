options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
# update.packages()
# install.packages(c("systemfonts", "RcppEigen"))
# install.packages("ggraph")
# install.packages("igraph")
# install.packages("tidyverse")
# install.packages("viridis")
library(wordcloud2) 
library(packcircles)
library(ggplot2)
library(extrafont)
library(showtext)
library(ggraph)
library(igraph)
library(tidyverse)
library(viridis)

edges <- flare$edges
vertices <- flare$vertices
print(edges)
print(vertices)

font_import()
loadfonts(device = "postscript")
showtext_auto(enable = TRUE)

# 创建大类数据框
big_categories <- data.frame(
  birds = c("汽车销售", "电气设备生产", "汽车维修", "汽车服务", "研发与设计", "辅助系统生产", "车身制造", "发动机制造", "汽车底盘生产"),
  values = c(84645, 12529, 36398, 36398, 10281, 2602, 993, 1496, 734)
)

# 创建小类数据框
small_categories <- data.frame(
  birds = c("汽车配件销售", "电控系统生产", "汽车销售", "汽车检测", "汽车服务", "蓄电池生产", "电线生产", "汽车维修", 
            "健康环保装置生产", "内外装饰及附件生产", "其他用电装置生产", "电动机生产", "传感器生产", "控制器生产", "工艺研发制造", 
            "设计", "专用技术研发与设计", "汽车测试", "汽车零配件销售", "汽车安保系统生产", "汽车安全装置生产", "多媒体装置生产", 
            "复合材料生产", "模具生产", "智能装置生产", "发动机配件生产", "电控单元生产", "电池生产", "车轮生产", "空调与冰箱生产", 
            "汽车产业人员培训", "车窗生产", "车门生产", "车身壳体生产", "座椅生产", "车厢生产", "曲柄连杆机构生产", "配气机构生产", 
            "润滑系统生产", "冷却系统生产", "燃料供给系统生产", "点火系统生产", "启动系统生产", "传动系统生产", "行驶系统生产", 
            "转向系统生产", "制动系统生产", "车架生产", "发电机生产", "车灯生产", "仪表盘生产"),
  values = c(63409, 6297, 30813, 12475, 12475, 4999, 5436, 28140, 425, 1562, 4738, 1891, 3870, 3277, 8382, 8382, 5828, 3236, 263, 1515, 
             551, 893, 596, 3866, 1935, 1009, 3488, 62, 755, 1452, 2236, 1274, 423, 414, 402, 376, 234, 232, 748, 252, 281, 236, 237, 
             570, 441, 445, 474, 453, 1577, 1846, 874)
)

# 合并大类和小类数据框
df <- rbind(big_categories, small_categories)

df$packing <- circleProgressiveLayout(df$values, sizetype='area')

df.gg <- circleLayoutVertices(df$packing, npoints=50)



p <- ggplot() + 
  geom_polygon(data = df.gg, aes(x, y, group = id, fill=id), alpha = 0.6)+
  scale_fill_viridis_c()+
  geom_text(data = df, aes(x=packing$x, y=packing$y, label = birds), size=3, color="black") +
  theme_void() + 
  theme(legend.position="none", plot.margin=unit(c(0,0,0,0),"cm") ) + 
  coord_equal()

# p <- ggplot(data, aes(x = Category, y = Parent, size = Size, color = Type)) +
#   geom_point(alpha = 0.6) +
#   theme_minimal() +
#   scale_size(range = c(3, 12)) +
#   labs(title = "汽车行业相关类别的气泡图", x = "类别", y = "父类别", size = "数目") +
#   theme(axis.text.x = element_text(family = "PingFang SC",angle = 90, hjust = 1)) +
#   guides(color = guide_legend(title = "类型"))

ggsave("../assets/bubble.pdf", plot = p, width = 10, height = 8)