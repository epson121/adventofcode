file <- read.table("04.txt", header=FALSE);

#first
minRow <- apply(file, 1, FUN=min)
maxRow <- apply(file, 1, FUN=max)
print(sum(maxRow-minRow))

#second
sumRows <- function(els) {
	sum <- 0
	for (i in 1:nrow(els)) {
		found = 0
		for (j in 1:length(els[i,]-1)) {
			el <- els[i,j]
			for(k in (j+1):length(els[i,])) {
				if (els[i,k] %% el == 0) {
					found = 1
					sum = sum + (els[i,k]/el)
					break;
				}
			}
			if (found==1) {
				break
			}
		}
	}

	return(sum)
}

els <- t(apply(file, 1, sort))
print(sumRows(els))