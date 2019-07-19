rm(list= ls())
library(rvest)

paginaAntártica <-"https://www.antartica.cl/antartica/index.jsp"
paginaANTRead<- read_html(paginaAntártica)
nodesDelHTML<-html_nodes(paginaANTRead,".txtTitulosRutaSeccionLibros")
sacar<-html_attr(nodesDelHTML,"href")

tablaIndexAntartica<-html_nodes(paginaANTRead,"table")
linksTablaIz <- html_attr(tablaIndexAntarticaSub1,"href")
tablaTmp <- html_table(tablaIndexAntartica, fill = TRUE)

  


todosLibros<-data.frame()
for (i in sacar){
  url <- paste("https://www.antartica.cl",i,sep = "")
  lecturalibro<-read_html(url)
  titulo<- html_text(html_nodes(lecturalibro,".txtTitulosRutaSeccionLibros"))
  tituloLibro <- titulo[1]
  autoresLibro <- titulo[2]
  editorial <- titulo[3]
  titulo<- gsub("\r","",titulo)
  titulo<- gsub("\n","",titulo)
  titulo<-gsub("                                                    ","",titulo)
  precio<- html_text(html_nodes(lecturalibro,".precioAhoraFicha"))
  normal<-html_text(html_nodes(lecturalibro,".precioAntes"))
  normal<-gsub("Normal \\$","",normal)
  normal<-gsub("[.]","",normal)
  normal<-as.numeric(normal)
  precio<- gsub("Internet \\$","",precio)
  precio<-gsub("[.]","",precio)
  precio<-as.numeric(precio)
  print (titulo)
  print(precio)
  print(normal)
  libro<-data.frame(precioNormal=normal,precioInternet=precio,nombreLibro=tituloLibro,autor=autoresLibro,editorialLibro=editorial)
  todosLibros<-rbind(libro,todosLibros)
  write.csv2(todosLibros, file="Tabla de precios y libros.csv")
}
#Se extraen los datos de la primera y segunda columna para luego ser comparados porcentualmente
normalprice<- todosLibros[ , 1]
internetprice<- todosLibros[ , 2]
#Se crea un for con el fin de obtener la variacion porcentual entre los precios en tienda vs los precios de internet
for (m in 1:length(normalprice)){
  x<- (1-(internetprice/normalprice))*100
  z<- summary(x)
}
datos.maxmin.LibrosVendidos<-z
print(datos.maxmin.LibrosVendidos)
#Se crea un gráfico de barra para observar el comportamiento de los precios en tienda
graficopreciotienda<-hist( x= normalprice,main = "Histograma de precios",xlab = "Precios en tienda",ylab = "Frecuencia",col="blue")
png("graficopreciotienda.png")
graficoprecioonline<-hist(x= internetprice,main = "Histograma de precios",xlab = "Precios Online",ylab= "Frecuencia", col = "green")
