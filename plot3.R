##Verificamos si existe la variable NEI, si no la creamos asignandole la trama de datos
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}
##Verificamos si existe la variable SCC, si no la creamos asignandole la trama de datos
if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}
##Subconjunto de datos NEI para subsetBalt
subsetBalt <- NEI[NEI$fips == "24510", ]
#Agregamos la suma total de emisiones para subsetNEI
Addtotal <- aggregate(Emissions ~ year, subsetBalt, sum)
#Llamamos a la libreria
library(ggplot2)
#Creamos el plot
png("plot3.png", bg = "transparent")
plot3 <- ggplot(subsetBalt, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat = "identity") + theme_bw() + guides(fill = FALSE) +
  facet_grid(. ~ type, scales = "fixed", space = "fixed") + 
  labs(x = "YEAR", y = expression("TOTAL PM"[2.5]* " Emission (t)")) + 
  labs(title = expression("PM"[2.5]* " Emissions, Baltimore City 1999-2008 by source type"))
print(plot3)
dev.off()