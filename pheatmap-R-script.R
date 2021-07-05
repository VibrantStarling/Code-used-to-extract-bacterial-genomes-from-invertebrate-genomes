library(pheatmap)
library(RColorBrewer)

breakslist = seq(0, 1, by = 0.1)

pheatmap(metabolicdata, border_color = 'white', fontsize_row = 8, fontsize_col = 15, cellheight = 8, cellwidth = 30, 
         breaks = breakslist,
         color = colorRampPalette(brewer.pal(n = 7, name = "Blues"))(length(breakslist)))
         
