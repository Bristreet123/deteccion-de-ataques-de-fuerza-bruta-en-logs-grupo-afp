DetectarAtq <-function(entrada){
  library('dplyr')
  library('arules')
  #data <- read.csv(entrada, header = TRUE)
  data.log <- entrada
  data.log$start_time <- as.POSIXct(data.log$start_time, origin = "1970-01-01")
  data.log <- data.log[order(data.log$start_time), ]
  intertime <- diff.POSIXt(data.log$start_time)
  intertime <- c(0,intertime)
  data.log$intertime <- intertime
  
  
  data.log[["intertime"]] <- ordered(cut(data.log[["intertime"]],
                                         c(-Inf,0,median(data.log$intertime[data.log$intertime > 0]),Inf),
                                         labels = c("none","low", "high")))
  log.t <- data.log[c(1,2,11)]
  
  trans <- as(log.t, "transactions")
  rules <- apriori(trans,parameter = list(support = 0.05, confidence = 0.7))
  rules.intertimeNone <- subset(rules, subset = rhs %in% "intertime=none" & lift > 1)
  resultado <- inspect(head(sort(rules.intertimeNone, by = "confidence"), n = 3))
  #result <- max(resultado[5])
  
}
