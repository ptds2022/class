# 1. Create a `summary` function for the class `pixel`. 
# Verify the dispatch before and after implementing the summary function.
summary.pixel <- function(x, ...){
  cat("This is a method for objects of class 'pixel'\n")
}

# 2. Describe the difference between `t.test()` and `t.data.frame()`. 
# What happens if you run the following code and why?
x <- structure(1:10, class = "test")
str(x)
x
t(x)
t.test <- function(x, ...){
  cat("This is a method for objects of class 'test'\n")
}
t(x)
t.test(x)
stats::t.test(x)

# 3. Read the documentation for `UseMethod()` and explain why the following code 
# returns the results that it does.
g <- function(x) {
  x <- 10
  y <- 10
  UseMethod("g")
}
g.default <- function(x) c(x = x, y = y)

x <- 1
y <- 1
g(y)
sloop::s3_dispatch(g(y))

# 4. What do you expect this code to return? What does it actually return and why?
generic2 <- function(x) UseMethod("generic2")
generic2.a1 <- function(x) "a1"
generic2.a2 <- function(x) "a2"
generic2.b <- function(x) {
  class(x) <- "a1"
  NextMethod()
}

x <- structure(list(), class = c("b", "a2"))
generic2(x)

sloop::s3_dispatch(generic2(x))


generic2.b <- function(x) {
  browser() # for inspecting
  class(x) <- "a1"
  NextMethod()
}
generic2(structure(list(), class = c("b", "a2")))
