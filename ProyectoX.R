rm(list= ls())
library(rvest)
paginaAntártica <-"https://www.antartica.cl/antartica/index.jsp"
paginaANTRead<- read_html(paginaAntártica)
nodesDelHTML<-html_nodes(paginaANTRead,".txtTitulosRutaSeccionLibros")

html_attr(nodesDelHTML,"href")
sacar<-html_attr(nodesDelHTML,"href")



for (i in sacar){
  url <- paste("https://www.antartica.cl",i,sep = "")
  lecturalibro<-read_html(url)
  titulo<- html_text(html_nodes(lecturalibro,".txtTitulosRutaSeccionLibros"))
  titulo<- gsub("\r","",titulo)
  titulo<- gsub("\n","",titulo)
  precio<- html_text(html_nodes(lecturalibro,".precioAhoraFicha"))
  internet<-html_text(html_nodes(lecturalibro,".precioAntes"))
  splitespacio<- strsplit(internet," ")[[1]]
  precio<-splitespacio
  print (titulo)
  print(precio)
}

#extraccuin del contenido en la clase thumb under
