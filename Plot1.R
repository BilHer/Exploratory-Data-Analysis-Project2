##Verificamos si existe la variable NEI, si no la creamos asignandole la trama de datos
if(!exists("NEI")){
  NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
}
##Verificamos si existe la variable SCC, si no la creamos asignandole la trama de datos
if(!exists("SCC")){
  SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
}
#Agregamos la suma total de emisiones por año
Addtotal <- aggregate(Emissions ~ year, NEI, sum)
##Creamos el Plot
png('plot1.png', bg = "transparent")
barplot(height = Addtotal$Emissions, names.arg = Addtotal$year, xlab = "YEARS", 
        ylab = expression('TOTAL PM'[2.5]* ' Emission'),
        col = c("red", "green", "brown", "yellow"),
        main = expression('TOTAL PM'[2.5]* ' Emissions at various years'))
dev.off()