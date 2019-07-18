rm(list= ls())
library(rvest)
paginaAntártica <-"https://www.antartica.cl/antartica/index.jsp"
paginaANTRead<- read_html(paginaAntártica)
nodesDelHTML<-html_nodes(paginaANTRead,".txtTitulosRutaSeccionLibros")
sacar<-html_attr(nodesDelHTML,"href")

tablaIndexAntartica<-html_nodes(paginaANTRead,"table")
tablaIndexAntarticaSub1 <- html_nodes(tablaIndexAntartica,".txtBtoneraNov")
linksTablaIz <- html_attr(tablaIndexAntarticaSub1,"href")
tablaTmp <- html_table(tablaIndexAntarticaSub1, fill = TRUE)#Arroja error 
variable<- 
comicsLibro<-data.frame()
for (x in linksTablaIz){
  if(variable =! "/antartica/ayuda/privacidad.jsp" && variable =! "/antartica/ayuda/privacidad.jsp")
  link <- paste("https://www.antartica.cl",x,sep = "")
  lecturabook <-read_html(link)
  Titulo<- html_text(html_nodes(lecturabook,".txtTitulosRutaSeccionLibros"))
  print(Titulo)
}

if(variable =! "/antartica/ayuda/privacidad.jsp" && variable =! "/antartica/ayuda/privacidad.jsp")

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
  plot(x = normal, y = precio) # Gráfico de dispersión
  hist(normal) # Histograma
}

#extraccuin del contenido en la clase thumb under
