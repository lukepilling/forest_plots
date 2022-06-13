# forest_plots
Different ways to create forest plots in R

Examples using data from our 2022 paper on iron polygenic score associations with haemochromatosis outcomes

> Pilling LC, Atkins JL, Melzer D (2022) Genetic modifiers of penetrance to liver endpoints in HFE hemochromatosis: associations in a large community cohort. Hepatology. https://doi.org/10.1002/hep.32575

## Simple example using `ggplot2`

[Link to syntax](https://github.com/lukepilling/forest_plots/blob/main/simple_forest_ggplot2.R). Example output:

<img src="https://github.com/lukepilling/forest_plots/blob/main/simple_forest_ggplot2.jpg?raw=true" width="700" />

## Simple example using `ggplot2` with grid line colours

Same as above but with 3 differences:
- Alternating coloured horizontal lines added (white and grey)
- Ordered by effect size rather than custom (as appears in file)
- Different "classic" theme to include axis lines and no reference lines 

[Link to syntax](https://github.com/lukepilling/forest_plots/blob/main/simple_forest_with_grid_colours_ggplot2.R). Example output:

<img src="https://github.com/lukepilling/forest_plots/blob/main/simple_forest_with_grid_colours_ggplot2.jpg?raw=true" width="700" />

