# 1. What does the following code return?
x <- 2
f1 <- function(x) {
  function() {
    x + 3
  }
}
f1(1)()

# 2. How would you usually write these codes?
`+`(1, `*`(2, 3))
1 + 2 * 3
`*`(3, `+`(2, 1))
3 * (2 + 1)

# 3. How could you make this function call easier to read?
mean(, TRUE, x = c(seq(10), rep(NA,3)))
mean(c(seq(10), rep(NA,3)), na.rm = TRUE)
     
# 4. Does the following code throw an error when executed? Why or why not?
f2 <- function(a, b) {
  a * 3
}
f2(3, stop("This is an error!"))
f2(stop("This is an error!"), 3)

# 5. Propose an infix function.
# addition two numbers only if positive, otherwise 0
`%+>%` <- function(e1, e2) {
  if(e1>0 && e2>0) {
    e1 + e2
  } else {
    0
  }
}
1 %+>% 2
-1 %+>% 2
