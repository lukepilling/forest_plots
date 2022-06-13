
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

## identify lines where CIs will go beyond axis limits
##     worth having slightly beyond the round number so that axis labels drawn correctly
x_minimum = 0.899
x_maximum = 2.01
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
                     breaks=c(0.9,1,1.5,2),
                     expand=c(0,0)) +
  coord_cartesian(xlim=c(x_minimum, x_maximum)) + 
  geom_segment(data = dat2, aes(x=lower_lim, xend=lower_lim, y=label, yend=label), size = 0.8,
               arrow = arrow(length = unit(0.3, "cm"))) +
  geom_segment(data = dat2, aes(x=upper_lim, xend=upper_lim+0.00001, y=label, yend=label), size = 0.8,
               arrow = arrow(length = unit(0.3, "cm"))) +
  labs(title="Iron PGS and haemochromatosis", 
       x='Hazard Ratio [95% Confidence Intervals]',
       y='') +
  theme_classic()

## display plot
p

## save 
ggsave('simple_forest_with_grid_colours_axis_limits_ggplot2.jpg', p, width=14, height=8, units='cm', dpi=500)













