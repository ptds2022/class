# Lecture 5: control structure
# In-class exercise (10 minutes)
# 1. Load a dataset using `data(ToothGrowth)`. Create 
# two vectors of tooth lengths corresponding to
# `OJ` and `VC` factors respectively. Compute the
# mean of each vector.
data('ToothGrowth')
indices_oj <- ToothGrowth$supp == "OJ"
x_oj <- ToothGrowth$len[indices_oj]
x_vc <- ToothGrowth$len[!indices_oj]
mean(x_oj)
mean(x_vc)

# 2. Create a bootstrap distribution for each vector
# using $B=10,000$ and a for loop. Checkout
# the `sample` function for sampling at random with replacement.
B <- 1e4
boot_oj <- boot_vc <- rep(NA_real_, B)
n_oj <- length(x_oj)
n_vc <- length(x_vc)
# bootstrap
for(b in seq_len(B)){
  # Orange Juice
  set.seed(b)
  x_star <- x_oj[sample(x = n_oj, size = n_oj, replace = TRUE)]
  boot_oj[b] <- mean(x_star)
  
  # ascorbic acid
  set.seed(b)
  x_star <- x_vc[sample(x = n_vc, size = n_vc, replace = TRUE)]
  boot_vc[b] <- mean(x_star)
  
  print(b)
}

# 3. Using `ggplot2`, make a graph of the bootstrap
# distributions by plotting two histograms on the same plot. 
require(ggplot2)
df <- data.frame(vitamine = rep(c("OJ","VC"),each=B), 
                 bootstrap = c(boot_oj, boot_vc))
p <- ggplot(df, aes(x=bootstrap)) + 
  geom_histogram(data = subset(df, vitamine == "OJ"), 
                 fill = "red", alpha = 0.5) +
  geom_histogram(data = subset(df, vitamine == "VC"), 
                 fill = "green", alpha = 0.5)
p

distribution_df <- data.frame(OJ = boot_oj, VC = boot_vc)
ggplot(distribution_df) +
  geom_histogram(aes(x=VC), fill='green', alpha = 0.5) +
  geom_histogram(aes(x=OJ), fill='red', alpha = 0.5) +
  ggtitle("Bootstrap sampling: Distribution of means") +
  ylab("Density") +
  xlab("Mean values")
