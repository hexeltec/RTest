library("rvest")
library("utf8", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("stringr", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("chinese.misc", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library("xml2")

# Extract
theURL <- "https://www.ctgoodjobs.hk/ngo/ngo_list.asp?cp="

ngo_info <- c()
for (i in 1:3) {
  thisURL <- str_c(theURL, '', i)
  thisURL <- paste0(theURL,as.character(i))
  fullhtml <- read_html(thisURL, encoding = "big5")
  fullhtml %>% iconv(to = "utf-8", from = "big5")
  # fullhtml %>% html_nodes('li') %>% html_nodes('h3') %>% html_nodes('a') %>% html_attr('href')
  org_info_sessions <- html_nodes(fullhtml, '.organization-info')
  name_cht <- org_info_sessions %>% html_nodes('.company-name01') %>% html_text() %>% `Encoding<-`("UTF-8")
  name_eng <- org_info_sessions %>% html_nodes('.company-name02') %>% html_text()
  details <- org_info_sessions %>% html_nodes('.company-details') %>% html_table()
  ngo_info <- data.frame(name_cht, name_eng)
}

head(ngo_info)
#head(details)
#head(ngo_info)

