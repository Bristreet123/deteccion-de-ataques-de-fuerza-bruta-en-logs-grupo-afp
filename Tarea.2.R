library('dplyr')
library('arules')
#install.packages('dplyr')
#install.packages('arules')
data <- read.csv("data.csv", header = TRUE)

#data.log <- data

ind <- sample(1:nrow(data),10)
data.log <- data[ind,]


data.log$start_time <- as.POSIXct(data.log$start_time, origin = "1970-01-01")

#2/3 de data random para Training
aux <- data.log[data.log$asn == "1e2eb", ]
sample.a <- sample_n(aux,size = (2/3) *nrow(aux))
aux <- data.log[data.log$asn != "1e2eb",] 
sample.b<- sample_n(aux,size = (2/3) * nrow(aux))
log.training<- rbind(sample.a,sample.b)



#ordenamos por ip fuente y por tiempo 

log.training <- log.training[order(log.training$start_time), ]


#calcular columna intertime
intertime <- diff.POSIXt(log.training$start_time) #diferencia entre tiempos de filas en mins
intertime <- c(0,intertime) 
log.training$intertime <- intertime

#Q: con que valores discretizamos los valores hallados de "intertime"
#R: Con la mediana porque es un valor confiable que no es tan afectado por outliers


log.training[["intertime"]] <- ordered(cut(log.training[["intertime"]],
                                           c(-Inf,median(log.training$intertime[log.training$intertime > 0]),Inf),
                                       labels = c("low", "high")))
log.training[["num_bytes"]] <- ordered(cut(log.training[["num_bytes"]],
                             c(-Inf,0,median(log.training$num_bytes[log.training$num_bytes > 0]),Inf),
                                           labels = c("none","low", "high")))


log.t<-log.training[-c(3,4,5,6,9,10)]
log.t <- log.training[c(1,2,10,11)]
trans <- as(log.t, "transactions")
trans


summary(trans)

#columnas : elementos que est?n en esa "cesta" , ips , productos,atributos,etc..
#filas : representan transacciones , individuos , compras , etc..

itemFrequencyPlot(trans, support = 0.1, cex.names=0.8)

rules <- apriori(trans,parameter = list(support = 0.05, confidence = 0.6))
summary(rules)


rules.intertimeNone <- subset(rules, subset = rhs %in% "intertime=low" & lift > 1.2)

resultado <- inspect(head(sort(rules.intertimeNone, by = "confidence"), n = 3))

if (class(resultado) == "NULL") {
  result <- 0
} else {
  result <- max(resultado$confianza)
}


#result
