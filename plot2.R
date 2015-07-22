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
##Creamos el Plot
png('plot2.png', bg = "transparent")
barplot(height = Addtotal$Emissions, names.arg = Addtotal$year, 
        xlab = "YEARS", ylab = expression('TOTAL PM'[2.5]* ' Emission'),
        col = c("blue", "red", "green", "black"),
        main = expression('TOTAL PM'[2.5]* ' Emissions from all Baltimore City sources'))
dev.off()