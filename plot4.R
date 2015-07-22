##Verificamos si existe la variable NEI, si no la creamos asignandole la trama de datos
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}
##Verificamos si existe la variable SCC, si no la creamos asignandole la trama de datos
if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}
#Subconjuto de datos relacionados con combustion de carbon en NEI
combusRelaci <- grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
carboRelaci <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE) 
combusCarbon <- (combusRelaci & carboRelaci)
combustionSCC <- SCC[combusCarbon, ]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC, ]
#Llamamos a la libreria
library(ggplot2)
#Creamos el plot
png("plot4.png",bg = "transparent")
plot4 <- ggplot(combustionNEI, aes(factor(year), Emissions/10^5)) +
  geom_bar(stat = "identity", fill = "orange", width = 0.5) +
  theme_bw() +  guides(fill = FALSE) +
  labs(x = "YEAR", y = expression("TOTAL PM"[2.5]* " Emission (10^5 t)")) + 
  labs(title = expression("PM"[2.5]* " Coal combustion source Emissions across US 1999-2008"))
print(plot4)
dev.off()