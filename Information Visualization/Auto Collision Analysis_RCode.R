install.packages("plyr",dependencies=TRUE)
library(plyr)

my.dir <- "C:\\Users\\micha\\Documents\\IST 719\\"
CrashData <- read.csv(file=paste0(my.dir, "Allegheny County Crash Data.csv")
                      , header = TRUE
                      , stringsAsFactors = FALSE)
CrashData

CrashData <- CrashData[ ,-c(25:180)]

colnames(CrashData)
str(CrashData)

## Frequency of Collisions by Type
table(CrashData$Collision.Type)
CollType <- table(CrashData$Collision.Type)
CollType <- as.data.frame(CollType)
colnames(CollType) <- c("Collision.Type", "Frequency")
num.colors <- length(CollType$Collision_Type)

barcolors1 <- brewer.pal(n = 10, "PuOr")

Bar1 <- barplot(table(CrashData$Collision.Type), col=barcolors1
                ,xlab = "Collision Type"
                ,ylab = "Collision Frequency"
                ,main = "Number of Collisions by Type"
                ,las = 2, cex.names = 0.75
                ,legend = TRUE, xaxt = "n" 
                ,args.legend = list(x = "topright", bty = "n", cex=0.85))
title(sub="https://data.pa.gov/", adj=1, line=3, font=2, cex = .1)
#################################################################################################

## Crashes per year
YearPlot  <-as.data.frame(table(CrashData$Crash.Year))
colnames (YearPlot) <- c("Crash.Year", "Frequency")

plot(YearPlot$Frequency, type = "b", 
     main = "Crashes by Year", 
     xaxt = "n", pch = 9, lwd = 2,
     col = "lawngreen", bg = "yellow",
     xlab = "Crash Year", ylab = "Crash Frequency")

axis(1, at=1:21, labels = YearPlot$Crash.Year)

title(sub="https://data.pa.gov/", adj=1, line=3, font=2)
#################################################################################################

## Frequency of Collisions by Road Condition
Piedf <- as.data.frame(table(CrashData$Illumination))
colnames(Piedf) <- c("Illumination", "Frequency")
PieColors <- brewer.pal(n = 10, "PiYG")

pie(Piedf$Frequency, 
    labels = Piedf$Illumination, 
    main = "Frequency of Collisions by Illumination",
    angle = 45, cex = .75
    ,col = PieColors)
title(sub="https://data.pa.gov/", adj=1, line=3, font=2, cex = .1)
#################################################################################################

## Bar Plot 2
barcolors2 <- brewer.pal(n = 10, "Set3")
barplot(table(CrashData$Collision.Type, CrashData$Urban...Rural), beside=TRUE, legend=TRUE,
        main="Collision Type by Urban/Rural",
        ylab = "Frequency",
        sub="Frequency of Collision Type by Urban/Rural",
        col = barcolors2,
        axisnames=TRUE, las = 1, cex.names = 1,
        args.legend = list(x = "topleft", bty = "n", cex=0.85))
title(sub="https://data.pa.gov/", adj=1, line=3, font=2, cex = .1)
#################################################################################################

## Bar Plot 3
CollColors <- length(unique(CrashData$Collision.Type))
AddColors <- colorRampPalette(c("navy","red", "darkgreen", "green", "blue", "brown", "yellow"))
BarColors <- AddColors(CollColors)

FinalPlot <- ggplot(CrashData, aes(x=Road.Condition, fill=factor(Collision.Type)))
FinalPlot <- FinalPlot + ggtitle("Collision Type by Road Condition")
FinalPlot <- FinalPlot + geom_bar(position="stack")
FinalPlot <- FinalPlot + scale_fill_manual(name="Collision Types", values= BarColors)
FinalPlot <- FinalPlot + xlab("Road Condition") + ylab("Number of Collisions")
FinalPlot <- FinalPlot + theme(axis.text.x = element_text(angle = 45, hjust = 1))
FinalPlot <- FinalPlot + theme(plot.title = element_text(hjust=0.5))
FinalPlot
title(sub="https://data.pa.gov/", adj=1, line=3, font=2, cex = .1)
