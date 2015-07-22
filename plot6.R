##Verificamos si existe la variable NEI, si no la creamos asignandole la trama de datos
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}
##Verificamos si existe la variable SCC, si no la creamos asignandole la trama de datos
if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}
#Reunir el subconjunto de los datos NEI que corresponde a los vehículos
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles, ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]
#Subconjunto de datos NEI  de los vehículos de cada ciudad.
laNEI <- vehiclesNEI[vehiclesNEI$fips == "06037", ]
laNEI$city <- "Los Angeles County"
baNEI <- vehiclesNEI[vehiclesNEI$fips == "24510",]
baNEI$city <- "Baltimore City"
#Se combinar los dos subconjuntos de datos de las ciudades en una trama de datos.
labaNEI <- rbind(laNEI, baNEI)
#Se llama a la libreria ggplot2
library(ggplot2)
#Creamos el plot
png("plot6.png", bg = "transparent")
plot6 <- ggplot(labaNEI, aes(x = factor(year), y = Emissions, fill = city)) +
  geom_bar(aes(fill = year), stat = "identity") +
  facet_grid(scales = "free", space = "free", .~city) +
  guides(fill = FALSE) + theme_bw() +
  labs(x = "YEAR", y = expression("TOTAL PM"[2.5]* " Emission (Kg-t)")) + 
  labs(title = expression("PM"[2.5]* " Motor vehicle source Emissions in Baltimore & LA, 1999-2008"))
print(plot6)
dev.off()