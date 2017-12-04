# First one calculated by hand
# Puzzle number is 361527
# sqrt(361527) is 601.2711
# side length is 601, so 361527 is 25 above the middle
# 26 + 300 (half of a side) is 326


# Second
steps <- 100000

vals <- c(1, 1, 2, 4, 5, 10, 11, 23, 25)

size = 31

mat <- matrix(0, nrow = size, ncol = size)

mid = (size-1)/2

# fill initial values
mat[[mid, mid]] = 1
mat[[mid, mid+1]] = 1
mat[[mid-1, mid+1]] = 2
mat[[mid-1, mid]] = 4
mat[[mid-1, mid-1]] = 5
mat[[mid, mid-1]] = 10
mat[[mid+1, mid-1]] = 11
mat[[mid+1, mid]] = 23
mat[[mid+1, mid+1]] = 25
mat[[mid+1, mid+2]] = 26


# set direction
dir <- c("u", "l", "d", "r")

getNextCDir <- function(cDir) {
	if (cDir == 4) {
		return(1)
	}
	return(cDir + 1)
}

cDir = 1

# set initial position
posX = mid
posY = mid+2

# loop until the number is greater than the puzzle
# keep track of position
for (i in 10:100) {
	direc = dir[[cDir]]

	print(direc)

	mat[[posX, posY]] <- sum(
			mat[[posX+1, posY]],
			mat[[posX+1, posY+1]],
			mat[[posX, posY+1]],
			mat[[posX-1, posY+1]],
			mat[[posX-1, posY]],
			mat[[posX-1, posY-1]],
			mat[[posX, posY-1]],
			mat[[posX+1, posY-1]]
			)

	if (mat[[posX, posY]] > 361527) {
		print("Done")
		print(mat[[posX, posY]])
		break
	}

	if (direc == "u") {
		if (mat[[posX, posY-1]] == 0) {
			cDir <- getNextCDir(cDir)
		} else {
			posX <- posX - 1
		}
	}

	if (direc == "l") {
		if (mat[[posX+1, posY]] == 0) {
			cDir <- getNextCDir(cDir)
		} else {
			posY <- posY -1
		}
	}

	if (direc == "d") {
		if (mat[[posX, posY+1]] == 0) {
			cDir <- getNextCDir(cDir)
		} else {
			posX <- posX + 1
		}
	}

	if (direc == "r") {
		if (mat[[posX-1, posY]] == 0) {
			cDir <- getNextCDir(cDir)
		} else {
			posY <- posY + 1
		}
	}

}

print(mat)