getLines <- function(filename, delimiter=" ") {
	dat <- file(filename);
	lines <- readLines(dat)
	close(dat)
	return(strsplit(lines, delimiter))
}

getScore <- function(line) {
	level <- 0
	sum <- 0
	skipNext <- FALSE
	chars <- unlist(strsplit(line, ""))
	garbageChars <- 0
	inGarbage <- FALSE
	for (i in 1:length(chars)) {
		char <- chars[[i]]

		if (skipNext) {
			skipNext = FALSE
			next
		}

		if (char == "{" && !inGarbage) {
			level <- level + 1
			sum <- sum + level
		}

		if (char == "}" && !inGarbage) {
			level <- level - 1
		}

		if (char == "<") {
			if (!inGarbage) {
				skip <- TRUE
			}
			inGarbage <- TRUE
		}

		if (char == "!" && inGarbage) {
			skipNext <- TRUE
		}

		if (inGarbage && !skipNext && !skip) {
			#print(char)
			garbageChars <- garbageChars + 1
		}

		if (char == ">") {
			inGarbage <- FALSE
			garbageChars <- garbageChars - 1
		}

		skip <- FALSE
	}
	print(garbageChars)
	return(sum)
}

clearGarbage <- function(line) {
	#a <- gregexpr("<.*?((!!)+[^!]|([.*^!]))>", line, perl=TRUE)
	#a <- gregexpr("<.*?>", line, perl=TRUE)
	#print(regmatches(line, a))
	#return(line)
}

lines <- getLines("09.txt")

#not
#12267
#12268

print(unlist(lapply(lines, getScore)))