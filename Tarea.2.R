log <- read.csv("data.csv", header = TRUE)
log2 <- log
log2$start_time <- as.POSIXct(log2$start_time, origin = "1970-01-01")
log <- log2[-8]


library('dplyr')
#sample_n is in library dplyr
p <- log2[1,]
asn1e2eb <- log2[log2$asn == "1e2eb", ]

b <- sample_n(asn1e2eb,size = (2/3) *nrow(asn1e2eb))
aux <- log2[log2$asn != "1e2eb", ]
a<- sample_n(aux,size = (2/3) * nrow(aux))
training<- bind_rows(a,b)



