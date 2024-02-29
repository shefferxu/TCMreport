# RMD文件生成
library(rmarkdown)

# 获取当前目录下所有的 RMD 文件
rmd_files <- list.files(pattern = "\\.Rmd$", full.names = TRUE)

# 循环遍历文件
for (file in rmd_files) {
  if (grepl("-", file)) {  # 检查文件名是否包含 "-"
    render(file,output_format = "word_document")  # 渲染文件
  }
}