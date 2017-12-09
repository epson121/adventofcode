getLines <- function(filename, delimiter=" ") {
	dat <- file(filename);
	lines <- readLines(dat)
	close(dat)
	return(lines)
}


lines <- getLines("05.txt")
lines <- unlist(lapply(lines, strtoi))

perform <- function(position, array, steps) {
	length <- length(array)
	move = array[[position]]
	nextPosition = position + move

	if (nextPosition > length) {
		return(steps)
	}

	array[[position]] = array[[position]] + 1

	return(perform(nextPosition, array, steps+1))
}

position = 1
steps = 1
length = length(lines)

for (i in 1:1000000000) {
	move = lines[[position]]
	nextPosition = position + move

	if (nextPosition > length) {
		return(steps)
	}

	if (move >= 3) {
		lines[[position]] = lines[[position]] - 1
	} else {
		lines[[position]] = lines[[position]] + 1
	}

	position = nextPosition
	steps = steps + 1
}

print(steps)