log <- read.csv("ds_1_with_fields.csv", header = TRUE)
log2 <- log
log2$start_time <- as.POSIXct(log2$start_time, origin = "1970-01-01")

#asn1e2eb <- log2[ log2$asn == "1e2eb", all()]
#asn1e2eb <- subset(log2,asn=='1e2eb')
asn1e2eb <- log2[ log2$asn == "1e2eb", ]



#Unskilled = URG
#Attackers = ACK
#Pester = PSH
#Real = RST
#Security = SYN
#Folks = FIN

#U, URG- Urgent- Data is sent out of band. 
#A, ACK- (Acknowledge) The receiver will send an ACK that equals the senders sequence number plus the Len, or amount of data, at the TCP layer.
#P, PSH- Push forces data delivery without waiting for buffers to fill. This is used for interactive traffic. The data will also be delivered to the application on the receiving end with out buffering.
#R, RST- Reset is an instantaneous abort in both directions (abnormal session disconnection).
#S, SYN- Synchronize is used during session setup to agree on initial sequence numbers. Sequence numbers are random.
#F, FIN- Finish is used during a graceful session close to show that the sender has no more data to send.


#SYN, and FIN flags count as 1 byte. The ACK can also be thought of as the sequence number of the next octet the receiver expects to receive.