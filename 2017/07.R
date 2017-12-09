getLines <- function(filename, delimiter=" ") {
	dat <- file(filename);
	lines <- readLines(dat)
	close(dat)
	return(strsplit(lines, delimiter))
}

lines <- getLines("07.txt", "->")

programs <- NULL
children <- NULL


childrenPerProgram <- NULL
weightPerProgram <- NULL

for (i in 1:length(lines)) {
	cp = lines[[i]]
	parts = unlist(strsplit(cp[[1]], " "))

	pName = parts[[1]]
	pWeight = toint(gsub("[()]", "", parts[[2]]))

	# has children
	if (length(cp) > 1) {
		chs <- trimws(cp[[2]])
		chs <- unlist(strsplit(chs, ", "))
		children <- c(children, chs)
	}

	programs <- c(programs, pName)
	childrenPerProgram[[pName]] = chs
	weightPerProgram[[pName]] = pWeight
	chs <- NULL
}

programs <- sort(programs)
children <- sort(children)

root <- NULL

for (i in 1:10000) {
	if (programs[[i]] != children[[i]]) {
		root <- programs[[i]]
		break
	}
}

weightPP <- function(child) {
	weight <- weightPerProgram[[child]]
	if (length(childrenPerProgram[[child]]) > 0) {
		for (i in childrenPerProgram[[child]]) {
			weight <- weight + weightPP(i)
		}
	}
	return(weight)
}

# manually check which one is wrong by going through the children

for (i in childrenPerProgram[["boropxd"]]) {
	print(i)
	print(weightPerProgram[[i]])
	print(weightPP(i))
}

#print(weightPP("qjvtm"))






