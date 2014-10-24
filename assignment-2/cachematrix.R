## makeCacheMatrix
# 
#  Cached matrix structure constructor. 
#
#  It offers a cache to store a matrix and its inverse, together with an API to set and get values. 
#
# Input:
#  x - matrix to be stored
#
# Returns:
#  a list with cached structure together with functions that comprise an API to manipulate the matrix and its cached values
#  
# API Methods:
#  set - set a new value for the stored matrix and clear up the cache
#  get - get the latest stored value for the matrix
#  setInv - stores the inverse of the matrix 
#  getInv - returns the latest inverse for the matrix if it wasn't updated.
#

makeCacheMatrix <- function(x = matrix()) {
	inv <- NULL
	set <- function(y) {
		x <<- y
		inv <<- NULL  # clean up inverse when a new value is set to 'x'
	}
	get <- function() x
	setInv <- function(i) inv <<- i  
	getInv <- function() inv

	list(set = set, get = get, setinv = setInv, getinv = getInv)
}

## cacheSolve
# 
#  Computes inverse of matrix in a cached structure.
#
#  Input:
#   x - matrix cached structure
#
#  Returns:
#   inverse of the matrix - obtained with 'solve' function if not calculated before, otherwise the cached value is returned.
#

cacheSolve <- function(x, ...) {
	inv <- x$getinv()  # check existing inverse
	if (!is.null(inv)) { 
		message("Cached matrix")
		return (inv)
	}
    # if inverse is not cached, recalculate it
	ret <- solve(x$get(), ...)
	x$setinv(ret)
	ret
}

## Test Code
#  
# testSolve() 
#
# Should create a 100x100 matrix and its inverse and set structures MA and IA
# in the global environment, containing the matrix and its inverse respectively
#

testSolve <- function(d = 100) {
  MA<<-makeCacheMatrix(matrix(rnorm(d*d),nrow=d,ncol=d))
  IA<<-cacheSolve(MA)
}
