library('dplyr')
#setwd("./Asignacion_2")
data <- read.csv("data.csv", header = TRUE)

data.log <- data
#data.log$start_time <- as.POSIXct(data.log$start_time, origin = "1970-01-01")

#2/3 de data random para Training
aux <- data.log[data.log$asn == "1e2eb", ]
sample.a <- sample_n(aux,size = (2/3) *nrow(aux))
aux <- data.log[data.log$asn != "1e2eb",] 
sample.b<- sample_n(aux,size = (2/3) * nrow(aux))
log.training<- bind_rows(sample.a,sample.b)


#ordenamos por ip fuente y por tiempo 

log.training <- log.training[order(log.training$source_ip, -log.training$start_time),]



#aquí dividimos el dataset entre los source_ip y luego 
#calculamos la columna intertime para luego discretizar y usar
#reglas de asociacion


#tratar de separar la data
a<- unique(data.log$source_ip)
a[order(a)]
length(a)




#probando con sample de 10 (ejemplo de como crear intertime)
training.sample <- sample_n(log.training,size = 10)
training.sample <- training.sample[order(training.sample$source_ip, 
                                         -training.sample$start_time),]

dts <- as.POSIXlt(training.sample$start_time, origin = "1970-01-01")
dts <- dts[order(dts)]
#diferencia en minutos
dif <- diff.POSIXt(dts)
dif <- c(0,dif)
training.sample$intertime <- dif








