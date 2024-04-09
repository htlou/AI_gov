options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
# install.packages("webshot2")
library(wordcloud2) 
library(webshot)
library(htmlwidgets)
library(webshot2)
# webshot2::install_chrome()
# webshot::install_phantomjs()


 
# have a look to the example dataset
# head(demoFreq)
# df <- data.frame(
#   words = c("汽车", "加工", "激光", "数据", "发动机", "存储介质", "电机", "传感器", "焊接", "夹具", "智能", "充电", "控制系统", "驱动", "连接结构", "高精度", "电动汽车", "座椅", "制动器", "自动化", "安全", "模具", "电子", "电路", "车载"),
#   freqs = c(94, 38, 38, 35, 29, 25, 21, 20, 20, 20, 19, 17, 15, 15, 15, 14, 12, 12, 12, 12, 11, 11, 11, 11, 11),
#   stringsAsFactors = FALSE  # 避免将字符串转换成因子
# )
df <- read.csv("../Graph_drawing/wordcloud.csv", stringsAsFactors = FALSE)
my_graph <- wordcloud2(df, size = 1.5)
saveWidget(my_graph, "tmp.html", selfcontained = FALSE)

# 使用增大的视图端口和zoom参数
webshot2::webshot("tmp.html", "../assets/wordcloud.pdf", delay = 5, vwidth = 1080, vheight = 1920, zoom = 4)