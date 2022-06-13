
## function to round and extend HR/CIs if too short
round_hr = function(x)
{
  x = as.character(round(x,2))
  if (nchar(x) == 1)  x = paste0(x, ".00")
  if (nchar(x) == 3)  x = paste0(x, "0")
  return(x)
}

## load tidyverse package
library(tidyverse)

## load results file containing associations between iron/ferritin polygenic scores and several outcomes
dat = read_tsv("_data_iron_pgs.txt")

## filter results to just the outcome and explosure you want to plot
##    -- here I subset by 3 things (outcome, exposure, and sex) -- you might not need to do any
## rename columns using "mutate" 
##    -- the "est" column is your central estimate (usually OR or HR)
##    -- the "label" column is whatever your y-axis is (outcome, subgroup, etc)
## subset to just those columns
dat2 = dat %>% 
  filter(outcome=="Haemochromatosis", X=="iron21hunt_nohfe_grs_20", sex=="Males") %>% 
  mutate(label=geno, est=or1, lower=lci1, upper=uci1) %>% 
  select(label, est, lower, upper)

## by default the order of the rows is the original order in the file
## to arrange by estimate (highest to lowest) uncomment these lines:
dat2 = dat2 %>% arrange(est)
dat2$label = factor(dat2$label, levels = dat2$label[1:length(dat2$label)])

## create variable to store background colour info so we can alternate between white and grey
dat2$colour = "white"
dat2$colour[1:(floor(nrow(dat2)/2)*2)] = rep(c("white", "gray90"), floor(nrow(dat2)/2))

## create variable with combined est and cis
dat2$est_combined = ""
for (ii in 1:nrow(dat2))  dat2$est_combined[ii] = paste0(round_hr(dat2$est[ii]), " (", round_hr(dat2$lower[ii]), " to ", round_hr(dat2$upper[ii]), ")")

## identify lines where CIs will go beyond axis limits
##     worth having slightly beyond the round number so that axis labels drawn correctly
x_minimum = 0.899
x_maximum = 2.01
x_maximum_labels = x_maximum + 1.5   ## modify if you can't see the estimates properly
dat2$lower_lim = dat2$upper_lim = NA
dat2$lower_lim[ dat2$lower<x_minimum ] = x_minimum
dat2$upper_lim[ dat2$upper>x_maximum ] = x_maximum
dat2$lower[ dat2$lower<x_minimum ] = x_minimum
dat2$upper[ dat2$upper>x_maximum ] = x_maximum

## create an object to "store" the plot information
p = ggplot(data=dat2, aes(x=est, y=label, xmin=lower, xmax=upper)) +
  geom_hline(aes(yintercept = label, colour = colour), size = 7) + 
  scale_colour_identity() +
  geom_pointrange() +
  geom_vline(xintercept=1, lty=2) + 
  scale_x_continuous(trans='log', 
                     breaks=c(0.9,1,1.5,2),    ## modify to change how the x axis values is labelled 
                     expand=c(0,0)) +
  coord_cartesian(xlim=c(x_minimum, x_maximum_labels)) + 
  geom_segment(data = dat2, aes(x=lower_lim, xend=lower_lim, y=label, yend=label), size = 0.8,
               arrow = arrow(length = unit(0.3, "cm"))) +
  geom_segment(data = dat2, aes(x=upper_lim, xend=upper_lim+0.00001, y=label, yend=label), size = 0.8,
               arrow = arrow(length = unit(0.3, "cm"))) +
  labs(title="Iron PGS and haemochromatosis", 
       x='Hazard Ratio [95% Confidence Intervals]',
       y='') +
  theme_classic() +
  geom_text(aes(x=x_maximum, label=est_combined), hjust = 0, nudge_x = 0.05)

## display plot
p

## save 
ggsave('simple_forest_with_axis_limits_and_grid_colours_and_estimates_ggplot2.jpg', p, width=16, height=8, units='cm', dpi=500)













