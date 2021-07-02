library(pheatmap)
library(RColorBrewer)

aa <- read.csv("amino-acids.csv", header=T)
names(aa)[names(aa)=="ï..module_name"]<-"module_name"
row.names(aa) <- aa$module_name
aa <- aa[-1]

res <- read.csv("resistance-and-other.csv", header=T)
names(res)[names(res)=="ï..module_name"]<-"module_name"
row.names(res) <- res$module_name
res <- res[-1]

carb <- read.csv("carbs-and-lipids.csv", header=T)
names(carb)[names(carb)=="ï..module_name"]<-"module_name"
row.names(carb) <- carb$module_name
carb <- carb[-1]

vitamin <- read.csv("cofactors-and-vitamins.csv", header=T)
names(vitamin)[names(vitamin)=="ï..module_name"]<-"module_name"
row.names(vitamin) <- vitamin$module_name
vitamin <- vitamin[-1]

breakslist = seq(0, 1, by = 0.1)

pheatmap(carb, border_color = 'white', fontsize_row = 8, fontsize_col = 15, cellheight = 8, cellwidth = 30, 
         breaks = breakslist,
         color = colorRampPalette(brewer.pal(n = 7, name = "Blues"))(length(breakslist)))
         
pheatmap(aa, border_color = 'white', fontsize_row = 8, fontsize_col = 15, cellheight = 8, cellwidth = 30, 
         breaks = breakslist,
         color = colorRampPalette(brewer.pal(n = 7, name = "Blues"))(length(breakslist)))

pheatmap(vitamin, border_color = 'white', fontsize_row = 8, fontsize_col = 15, cellheight = 8, cellwidth = 30, 
         breaks = breakslist,
         color = colorRampPalette(brewer.pal(n = 7, name = "Blues"))(length(breakslist)))

pheatmap(res, border_color = 'white', fontsize_row = 8, fontsize_col = 15, cellheight = 8, cellwidth = 30, 
         breaks = breakslist,
         color = colorRampPalette(brewer.pal(n = 7, name = "Blues"))(length(breakslist)))