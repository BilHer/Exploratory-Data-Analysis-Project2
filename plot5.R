##Verificamos si existe la variable NEI, si no la creamos asignandole la trama de datos
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}
##Verificamos si existe la variable SCC, si no la creamos asignandole la trama de datos
if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}
#subconjuto de datos NEI correspondientes a vehiculos
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "24510", ]
#Llamamos a la libreria ggplot2
library(ggplot2)
#Creamos el plot
png("plot5.png", bg = "transparent")
plot5 <- ggplot(baltimoreVehiclesNEI, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity", fill = "purple", width = 0.5) +
  theme_bw() + guides(fill = FALSE) +
  labs(x = "YEAR", y = expression("TOTAL PM"[2.5]* " Emission (10^5 t)")) + 
  labs(title = expression("PM"[2.5]* " Motor vehicle source Emissions in Baltimore 1999-2008"))
print(plot5)
dev.off()