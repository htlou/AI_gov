options(repos = c(CRAN = "https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
# install.packages("jiebaR")
# install.packages("jsonlite")
library(jsonlite)
library(jiebaR)

cutter <- worker(bylines = TRUE)


json_data <- fromJSON("../Graph_drawing/patent.json")
print(str(json_data))
# total_word_freq <- table()
# for(item in json_data$专利名称) {
#     # print(item)
#     # print(item$专利名称)
#     words <- cutter[item]
#     word_freq <- table(words)
#     # print(word_freq)
#     total_word_freq <- total_word_freq + word_freq
# }
# print(total_word_freq)
# 初始化一个空的数据框来存储词和相应的频率
total_word_freq <- data.frame(words = character(), freqs = integer(), stringsAsFactors = FALSE)

# 假设你有一个循环来处理文本并分词
for(item in json_data$专利名称) {
  if(!is.na(item) && nzchar(item)) {
    words <- cutter[item]
    if(length(words) > 0) {
      word_freq <- table(words)
      # 遍历当前词频，更新总词频数据框
      for(word in names(word_freq)) {
        if(word %in% total_word_freq$words) {
          # 如果词已存在，更新频率
          total_word_freq[total_word_freq$words == word, "freqs"] <- total_word_freq[total_word_freq$words == word, "freqs"] + word_freq[[word]]
        } else {
          # 如果词不存在，添加新行
          total_word_freq <- rbind(total_word_freq, data.frame(words = word, freqs = word_freq[[word]], stringsAsFactors = FALSE))
        }
      }
    }
  }
}
# 按词频(freqs)降序排序total_word_freq数据框
sorted_word_freq <- total_word_freq[order(-total_word_freq$freqs), ]

# 输出排序后的前100项
head_df <- head(sorted_word_freq, n = 300)
write.csv(head_df, "../Graph_drawing/wordcloud.csv", row.names = FALSE)
# save(head_df, file = "文件路径.RData")