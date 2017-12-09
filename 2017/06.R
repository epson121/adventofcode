getLines <- function(filename, delimiter=" ") {
	dat <- file(filename);
	lines <- readLines(dat)
	close(dat)
	return(strsplit(lines, delimiter))
}

maxIndex <- function(list) {

	max <- which(list==max(list))
	return(max[[1]])
}

toint <- function(list) {
	return(unlist(lapply(list, strtoi)))
}

getStateFingerprint <- function(list) {
	return(paste(unlist(list), collapse=","))
}

exists <- function(vector, el) {
	return(el %in% vector)
}

nextIdx <- function(index, length) {
	return(ifelse(index+1 > length, 1, index+1))
}

reallocate <- function(list, index, length) {
	val = list[[index]]
	list[index] = 0
	nextIdx = nextIdx(index, length)
	for (i in 1:val) {
		list[[nextIdx]] = list[[nextIdx]] + 1
		nextIdx = nextIdx(nextIdx, length)
	}
	return(list)
}

lines <- getLines("06.txt", "\t")

lines <- toint(lines)
initial <- maxIndex(unlist(lines))
states <- c(getStateFingerprint(lines))

step = 1
length <- length(lines)

seen <- NULL
seenAt <- NULL

for (i in 1:10000) {
	maxIdx = maxIndex(lines)
	newState <- reallocate(lines, maxIdx, length)
	fingerprint <- getStateFingerprint(newState)

	if (!is.null(seen) && fingerprint == seen) {
		print(step - seenAt)
		break
	}

	if (exists(states, fingerprint) && is.null(seen)) {
		seen <- fingerprint
		seenAt <- step
	}

	step <- step + 1
	states <- c(states, fingerprint)
	lines <- newState
}

