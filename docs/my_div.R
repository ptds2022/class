my_div <- function (numerator, denominator) {
  # verify that both arguments are numeric (double or integer)
  if(any(!is.numeric(numerator), !is.numeric(denominator))){
    stop("`numerator` and `denominator` must be numeric")
  }
  
  # verify length match
  if(length(numerator) != length(denominator)){ #<<
    stop("`numerator` and `denominator` must have the same length")
  }
  # verify dimension match
  if(length(dim(numerator)) != length(dim(denominator))){ #<<
    stop("`numerator` and `denominator` must have the same dimensions")
  }
  if(any(dim(numerator) != dim(denominator))){ #<<
    stop("`numerator` and `denominator` must have the same dimensions")
  }
  
  div <- numerator / denominator
  return(div)
}
