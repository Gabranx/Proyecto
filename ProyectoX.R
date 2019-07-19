rm(list= ls())
library(rvest)
#Se crea una variable la cual será asignada por una página web
paginaAntártica <-"https://www.antartica.cl/antartica/index.jsp"
#Se crea otra variable la cual leera la página seleccionada
paginaANTRead<- read_html(paginaAntártica)
#Se gesta ota variable la cual permita obtener la información que queremos extraer
nodesDelHTML<-html_nodes(paginaANTRead,".txtTitulosRutaSeccionLibros")
sacar<-html_attr(nodesDelHTML,"href")
#Se crea una variable que tendrá un data frame vacío que luego del for guardará la información obtenida
todosLibros<-data.frame()
#Se crea un for que recorra la pagina seleccionando los elementos que nos permitan trabajar a futuro
for (i in sacar){
  url <- paste("https://www.antartica.cl",i,sep = "")
  lecturalibro<-read_html(url)
  titulo<- html_text(html_nodes(lecturalibro,".txtTitulosRutaSeccionLibros"))
  hojas<- html_text((html_nodes(lecturalibro,".txt")))
  #Se limpian los datos de la variable 
  hojaslibro<- hojas[4]
  hojaslibro<- gsub("páginas"," ",hojaslibro)
  hojaslibro<- gsub(" ","",hojaslibro)
  hojaslibro<- as.numeric(hojaslibro)
  print(hojaslibro)
  tituloLibro <- titulo[1]
  autoresLibro <- titulo[2]
  editorial <- titulo[3]
  titulo<- gsub("\r","",titulo)
  titulo<- gsub("\n","",titulo)
  titulo<-gsub("                                                    ","",titulo)
  #Se crea una varibale precio que alojará los precios encontrados
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
  #Se crea otra variable que permitirá almacenar los datos obtenidos en una tabla ¿.
  libro<-data.frame(precioNormal=normal,precioInternet=precio,nombreLibro=tituloLibro,autor=autoresLibro,cantidadhojas=hojaslibro,editorialLibro=editorial)
  todosLibros<-rbind(libro,todosLibros)
  #Se almacenda la tabla obtenida en una tabla excel
  write.csv2(todosLibros, file="Tabla de precios y libros.csv")
}
#Se extraen los datos de la primera , segunda y quinta columna para luego ser comparados porcentualmente
normalprice<- todosLibros[ , 1]
internetprice<- todosLibros[ , 2]
cantidadhojas<- todosLibros[ , 5]
#Se crea un for con el fin de obtener la variacion porcentual entre los precios en tienda vs los precios de internet
for (m in 1:length(normalprice)){
  x<- (1-(internetprice/normalprice))*100
  z<- summary(x)
}
g<- summary(cantidadhojas)
datosmaxminHojas<- g
datos.maxmin.LibrosVendidos<-z
print(datos.maxmin.LibrosVendidos)
print(datosmaxminHojas)
#Se crea un gráfico de barra para observar el comportamiento de los precios en tienda, precios online y cantidad de hojas
graficopreciotienda<-hist( x= normalprice,main = "Histograma de precios",xlab = "Precios en tienda",ylab = "Frecuencia",col="blue")
graficoprecioonline<-hist(x= internetprice,main = "Histograma de precios",xlab = "Precios Online",ylab= "Frecuencia", col = "green")
graficocantidadhojas<- hist(x=cantidadhojas,main= "Histograma de hojas",xlab= "Cantidad de hojas",ylab = "Frecuencia", col ="blue")
