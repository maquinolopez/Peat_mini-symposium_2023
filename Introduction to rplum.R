###############################
# Author:
# Marco A. Aquino-López
# Code:
# Introduction to rplum
#
###############################

# Clearing the R environment
rm(list=ls())

# Installing required packages
# If 'devtools' is not already installed, uncomment the next line and install it
# install.packages('devtools')

# Using devtools, install the rplum package from GitHub
devtools::install_github("Maarten14C/rplum")
# or
install.packages('rplum')

# Load the rplum package
library(rplum)

# Run the default rplum core (Created by Dr. Nicole Sandersons)
# Pay attention to where your 'Plum_runs' will be located
# This folder will store the data for your chronologies
Plum()

# Now, let's rerun Plum with BCAD parameter set to TRUE
# Note: Plum will need confirmation for the number of sections
Plum(BCAD = T)

# You can also run cores with supported 210Pb proxy data
# Let's use the 'Sim01' core for this example
Plum('Sim01')
# Note: This example containes maasuremnets for both 
# 210Pb and 226Ra. 

#Let's run an example which containes only 210Pb data
Plum('Sim01')
# Note: Plum ask you about which values to use for 
# supported estimation. The values provided are a first guess,
# please look at the plot and see if this makes sense.
#
# Note2: This estimation is running using linear regression
# so it needs at least 3 samples to run. Your data may reach 
# background in its last second to last samples.
# Be vigilant about how many samples to use!!!


# Let's see what happens when we run a core with different priors
# We'll use the 'HP1C' core with an accumulation mean of 50 and a memory mean of 0.9
Plum("HP1C",acc.mean = 50,mem.mean = .9)

# Excercise, run this example or your own data with different priors
# which prior is best? 
# how do you know?
# what information you need to make a good estimate?

# To simulate a clean start, we'll clear the R environment again
rm(list=ls())

# Now we'll run the 'HP1C' core with 210Pb and other dating measurements
Plum("HP1C",otherdates = 'HP1C_C',run=FALSE)

# Let's plot the age-depth relationship
agedepth()

# Lets create some ghost-plots for visualizing  
# accumulation rate with uncertainty

# And calculate accumulation rates at specific depths and ages
# Note: depth is in cm, age is in years before present (BP)
accrate_d10 <- accrate.depth(d = 10)
accrate_d25 <- accrate.depth(d = 25,cmyr = TRUE)
accrate_a300 <- accrate.age(age=300)
acc_rate_10 <- accrate.age(age = -10,cmyr = TRUE)

# To better understand our results, let's examine the statistics of these accumulation rates
# and visualize them with histograms and density plots
# (repeat these steps for other accumulation rate variables as desired)
head(accrate_d10)
mean(accrate_d10)
var(accrate_d10)
summary(accrate_d10)
plot(density(accrate_d10), main='Accumulation Rate at depth 10 cm', xlab='yr/cm', ylab='')
hist(accrate_d10, breaks = 100)

# You can also plot accumulation rates for the whole model
# by depth
accrate.depth.ghost(cmyr = T, acc.lim = c(0,1.5))
accrate.depth.ghost(acc.lim = c(0,5), d.lim = c(0,10))

# or by age
accrate.age.ghost(acc.lim = c(0,40))
accrate.age.ghost(cmyr = TRUE, age.lim = c(-20,50), acc.lim = c(0,.28))

# Congratulations! You've completed an introduction to rplum.
