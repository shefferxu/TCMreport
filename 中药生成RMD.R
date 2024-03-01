# setwd("E:/deltawork/TCM data/数据分析结果/2019虹桥 康桥 万仕城/以医院姓名、手机号姓名和姓名为唯一性识别号")
# data_frame_names <- list.files(pattern = "*.csv")       # Get all file names
# data_frame_names <- data_frame_names[-5]          
mypath<-dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(mypath)
options(encoding ="UTF-8")
# 读取指定的 Rmd 文件
rmd_file <- "template.Rmd"


library("readxl")
# TCM2019 <- NULL
# options( java.parameters = "-Xmx5000m")
# library(xlsx)
Metal <- c("铝","镉","铬","铅")
TCM <- c("黄芪","金银花","鸡内金")
for (metal in Metal) {
  for (herb in TCM) {
    currRmd <- "template.Rmd"
    newRmd <- paste(metal, "-", herb, ".Rmd", sep = "")
    file.copy(currRmd, newRmd, overwrite = TRUE) 
    
    content <- readLines(newRmd)
    # 找到第三个 newpage 的位置
    newpage_indices <- grep("newpage", content)
    third_newpage_index <- newpage_indices[3]
    # 在第三个 newpage 之后添加 r child 新模块
    # 在第三个 newpage 之后添加 r child 新模块
    new_content <- c(content[1:third_newpage_index],
                     paste0("\n```{r child = '", herb, "介绍.Rmd'}\n"),
                     "```",
                     paste0("\n```{r child = '", metal, "的危害表征.Rmd'}\n"),
                     "```",
                     content[(third_newpage_index + 1):length(content)])
    
    
    # 寻找包含特定内容的行
    abstract_lines  <- grep("经过风险评估得到以下结论", new_content)
    # 判断metal的类型并在特定位置添加描述
    if (metal == "铝") {
      # 描述铝的风险评估结论
      description <- "&emsp;&emsp;铝是人体非必需微量元素，摄入过多会引起生殖毒性、神经毒性等。2011年6月，在JECFA的第74次大会上，委员会依据每日每公斤体重 30mg 的未观察到不良作用水平（NOAEL），并利用 100 倍的安全系数,将铝的 PTWI 修订为每周每公斤体重 2mg。"
    } else if (metal == "镉") {
      description <- "&emsp;&emsp;镉是一种有毒重金属，长期摄入会对肾脏、骨骼、肝脏等器官产生损害。根据WHO的标准，人体每周摄入镉的安全量为每公斤体重每周7微克。"
    } else if (metal == "铬") {
      description <- "&emsp;&emsp;铬是人体所需的微量元素，但六价铬具有较强的毒性，对皮肤、呼吸道和消化道有刺激作用。根据WHO的标准，铬的可容许摄入量为每公斤体重每周 25 微克。"
    } else if (metal == "铅") {
      description <- "&emsp;&emsp;铅是一种有毒重金属，长期摄入会导致神经系统和肾脏等器官受损。根据WHO的标准，铅的可容许摄入量为每公斤体重每周 25 微克。"
    }
    # 在每个位置添加描述(倒着跑)
    for (abstract_line in rev(abstract_lines)) {
      new_content <- c(new_content[1:(abstract_line-1)],
                       description,
                       new_content[abstract_line:length(new_content)])
    }
    # 将修改后的内容写回文件
    writeLines(new_content, newRmd)
    
    
    # # 渲染RMD文件并导出Word文件
    # srcfile <- newRmd
    # outdoc <- paste(metal, "-", herb, ".docx", sep = "")
    # rmarkdown::render(input = srcfile, output_format = "word_document", output_file = outdoc)
  }
}

options(encoding ="native.enc")
# connect database
# library(RMySQL)
# conn <- dbConnect(MySQL(),user="root",
#                   password="5mayday",
#                   host="localhost",
#                   dbname="ctm",DBMSencoding="UTF8")
# dbSendQuery(conn, "SET NAMES GBK")  
# # data clean of tcm name
# t <- which(stringr::str_detect(kq2019$CMN,"薏苡仁"))
# kq2019[t,]$CMN<-"薏苡仁"
# t <- which(stringr::str_detect(kq2019$CMN,"酸枣仁"))
# kq2019[t,]$CMN<-"酸枣仁"
# t <- which(stringr::str_detect(kq2019$CMN,"白术"))
# kq2019[t,]$CMN<-"白术"
# t <- which(stringr::str_detect(kq2019$CMN,"三七"))
# kq2019[t,]$CMN<-"三七"
# t <- which(stringr::str_detect(kq2019$CMN,"丹参"))
# kq2019[t,]$CMN<-"丹参" 
# t <- which(stringr::str_detect(kq2019$CMN,"人参"))
# kq2019[t,]$CMN<-"人参"
# t <- which(stringr::str_detect(kq2019$CMN,"枸杞"))
# kq2019[t,]$CMN<-"枸杞"
# t <- which(stringr::str_detect(kq2019$CMN,"金银花"))
# kq2019[t,]$CMN<-"金银花"
# t <- which(stringr::str_detect(kq2019$CMN,"麦冬"))
# kq2019[t,]$CMN<-"麦冬"
# t <- which(stringr::str_detect(kq2019$CMN,"党参"))
# kq2019[t,]$CMN<-"党参"
# t <- which(stringr::str_detect(kq2019$CMN,"延胡索"))
# kq2019[t,]$CMN<-"延胡索"
# t <- which(stringr::str_detect(kq2019$CMN,"山药"))
# kq2019[t,]$CMN<-"山药"
# t <- which(stringr::str_detect(kq2019$CMN,"黄芩"))
# kq2019[t,]$CMN<-"黄芩"
# t <- which(stringr::str_detect(kq2019$CMN,"铁皮石斛"))
# kq2019[t,]$CMN<-"铁皮石斛"
# t <- which(stringr::str_detect(kq2019$CMN,"土鳖虫"))
# kq2019[t,]$CMN<-"土鳖虫"
# t <- which(stringr::str_detect(kq2019$CMN,"菊花"))
# kq2019[t,]$CMN<-"菊花"
# t <- which(stringr::str_detect(kq2019$CMN,"黄芪"))
# kq2019[t,]$CMN<-"黄芪rite.table (kq2019, file ="", sep ="", row.names =TRUE, col.names =TRUE, quote =TRUE)
# import into MySQL Database
# kq2019[, 'Name']  = iconv(kq2019[, 'Name'], from = 'gbk', to = 'utf-8')
# kq2019[, 'CMN']  = iconv(kq2019[, 'CMN'], from = 'gbk', to = 'utf-8')
# dbWriteTable(conn,"kq2019",kq2019,append=TRUE,fileEncoding = "utf8")
# dbDisconnect(conn)
# 
# kq2019test <- head(kq2019)
# dbSendQuery(conn, 'SET NAMES utf8')
# kq2019test[, 'Name']  = iconv(kq2019test[, 'Name'], from = 'gbk', to = 'utf-8')
# kq2019test[, 'CMN']  = iconv(kq2019test[, 'CMN'], from = 'gbk', to = 'utf-8')
# data output

