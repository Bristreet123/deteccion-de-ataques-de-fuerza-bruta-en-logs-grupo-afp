library('dplyr')
data.log <- read.csv("data.csv", header = TRUE)

#data.log$start_time <- as.POSIXct(data.log$start_time, origin = "1970-01-01")

#2/3 de data random para Training
aux <- data.log[data.log$asn == "1e2eb", ]
sample.a <- sample_n(aux,size = (2/3) *nrow(aux))
aux <- data.log[data.log$asn != "1e2eb", ]
sample.b<- sample_n(aux,size = (2/3) * nrow(aux))
log.training<- bind_rows(sample.a,sample.b)


#ordenamos por ip fuente y por tiempo 

log.training <- log.training[order(prueba$source_ip, prueba$start_time),]


#INTENTO DE CALCULAR LA DIFERENCIA DE TIEMPO ENTRE LAS FILAS
#reconoce start_time como posixt y al usar la funcion diff
#no funciona

dts <- as.POSIXct(log.training$start_time, origin = "1970-01-01")
diff(dts)






