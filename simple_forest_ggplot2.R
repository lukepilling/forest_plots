
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
#dat2 = dat2 %>% arrange(est)
#dat2$label = factor(dat2$label, levels = dat2$label[1:length(dat2$label)])

## we create an object to "store" the plot information
p = ggplot(data=dat2, aes(x=est, y=label, xmin=lower, xmax=upper)) +
  geom_pointrange() +
  geom_vline(xintercept=1, lty=2) + 
  scale_x_continuous(trans='log', 
                     breaks=c(0.8,1,1.5,2,3)) +
  coord_cartesian(xlim=c(0.8, 3)) + 
  labs(title="Iron PGS and haemochromatosis", 
       x='Hazard Ratio [95% Confidence Intervals]',
       y='') +
  theme_minimal()

p

## lots of others themes to consider e.g.
##    theme_grey() ## ggplot2 default
##    see https://ggplot2.tidyverse.org/reference/ggtheme.html for more

## save last figure
ggsave('simple_forest_ggplot2.jpg', p, width=14, height=8, units='cm', dpi=500)






