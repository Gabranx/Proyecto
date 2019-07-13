rm(list= ls())
library(rvest)
paginaAntártica <-"https://www.antartica.cl/antartica/index.jsp"
paginaANTRead<- read_html(paginaAntártica)
nodesDelHTML<-html_nodes(paginaANTRead,".txtTitulosRutaSeccionLibros")
html_attr(nodesDelHTML,"href")
sacar<-html_attr(nodesDelHTML,"href")



for (i in sacar){
  print(i)
  lecturalibro<-read_html(paste("https://www.antartica.cl","/antartica/servlet/LibroServlet?action=fichaLibro&id_libro=237004",sep = ""))
  titulo<- html_text(html_nodes(lecturalibro,".txtTitulosRutaSeccionLibros"))
  print (titulo)
}

#extraccuin del contenido en la clase thumb under
