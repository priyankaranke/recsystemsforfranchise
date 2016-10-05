library("recommenderlab")
library(Matrix)

#Setting row names to be cities and deleting columns
df <- read.csv("Bajaj_df.csv")
df$State <- NULL
df$Area <- NULL
row.names(df) <- df$City
df$City <- NULL

#transposing so that it recommends cities and not franchises
df_t <- t(df)
transposeddf <- as.data.frame(df_t)

df1<-as.matrix(transposeddf) #It doesn't work without this step
df1<-sapply(data.frame(df1),as.numeric) # Convert to numeric (by arbitrarily mapping characters to numbers.)

recobuilder <- as(df1, "realRatingMatrix")
rec <- Recommender(recobuilder, method = "UBCF") #Building a recommender model with User-based CF

# ---Building top-N predictions using recommender model---
pre <- predict(rec, recobuilder[1, ], n = 25)
as(pre, "list")

# ---Building ratings predictor using recommender model---
pre <- predict(rec, recobuilder, type="ratings")
out <- as(pre[1,], "matrix")
readout <- t(out) 
uout2 <- as.data.frame(readout)

