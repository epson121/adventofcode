getLines <- function(filename, delimiter=" ") {
	dat <- file(filename);
	lines <- readLines(dat)
	close(dat)
	return(strsplit(lines, delimiter))
}

list <- getLines("08.txt")

max <- 0
variables <- new.env(hash = TRUE)

for (row in list) {

	if (is.null(variables[[row[5]]])) {
		variables[[row[5]]] <- 0
	}

	if (is.null(variables[[row[1]]])) {
		variables[[row[1]]] <- 0
	}



	row[[5]] = ifelse(is.null(variables[[row[5]]]), 0, variables[[row[5]]])


	expr <- paste(row[5:7], collapse=" ")
	isValid <- eval(parse(text=expr))

	if (isValid) {
		if (row[[2]] == "inc") {
			variables[[row[1]]] <-
				variables[[row[1]]] + strtoi(row[3])
		} else {
			variables[[row[1]]] <-
				variables[[row[1]]] - strtoi(row[3])
		}
	}

	if (variables[[row[1]]] > max) {
		max <- variables[[row[1]]]
	}

}

print(ls.str(variables))

print(max)
