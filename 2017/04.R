getLines <- function(filename, delimiter=" ") {
	dat <- file(filename);
	lines <- readLines(dat)
	close(dat)
	return(strsplit(lines, delimiter))
}

sortString <- function(j) {
	return(paste(sort(unlist(strsplit(j, ""))), collapse = ""))
}

first <- function(row) {
	return(length(row) == length(unique(row)))
}

prepare <- function(lst) {
	return(unlist(lapply(lst, sortString)))
}

second <- function(row) {
	els <- prepare(row)
	return(length(els) == length(unique(els)))
}

dat <- getLines("04.txt")

print(length(which(unlist(lapply(dat, first)))))
print(length(which(unlist(lapply(dat, second)))))