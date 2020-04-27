library(rvest)
x <- getwd()

setwd(x)

mojaTabela <- read.table(file="tabela.csv", sep=";", dec=",")

mojaTabela$data <- as.character(mojaTabela$data)
mojaTabela$kursEuro <- as.character(mojaTabela$kursEuro)
mojaTabela$kursUsd <- as.character(mojaTabela$kursUsd)
mojaTabela$kursGbp <- as.character(mojaTabela$kursGbp)
mojaTabela$kursFranka <- as.character(mojaTabela$kursFranka)



data <- c(Sys.time())
data <- as.character(data)
data <- c(mojaTabela$data, data)

url <- 'https://kursy-na-zywo.mybank.pl/'
webpage <- read_html(url)
kursEuro_html <- html_nodes(webpage,'#EURPLN_f')
kursEuro <- c(html_text(kursEuro_html))
kursEuro <- c(mojaTabela$kursEuro, kursEuro)

kursUsd_html <- html_nodes(webpage,'#USDPLN_f')
kursUsd <- c(html_text(kursUsd_html))
kursUsd <- c(mojaTabela$kursUsd, kursUsd)

kursGbp_html <- html_nodes(webpage,'#GBPPLN_f')
kursGbp <- c(html_text(kursGbp_html))
kursGbp <- c(mojaTabela$kursGbp, kursGbp)

kursFranka_html <- html_nodes(webpage,'#CHFPLN_f')
kursFranka <- c(html_text(kursFranka_html))
kursFranka <- c(mojaTabela$kursFranka, kursFranka)

tabela_walut <- data.frame(data, kursEuro, kursUsd, kursGbp, kursFranka)

write.table(tabela_walut, file="tabela.csv", quote=TRUE, sep=";",
            eol="\n", dec=",")

