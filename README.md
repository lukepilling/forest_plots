# forest_plots
Different ways to create forest plots in R. In all examples the user will need to look and modify the axis limits/breaks to suit the estimates they are plotting.

Examples using data from our 2022 paper on iron polygenic score associations with haemochromatosis outcomes

> Pilling LC, Atkins JL, Melzer D (2022) Genetic modifiers of penetrance to liver endpoints in HFE hemochromatosis: associations in a large community cohort. Hepatology. https://doi.org/10.1002/hep.32575

## Example using `ggplot2`

[Link to syntax](https://github.com/lukepilling/forest_plots/blob/main/simple_forest_ggplot2.R). Example output:

<img src="https://github.com/lukepilling/forest_plots/blob/main/simple_forest_ggplot2.jpg?raw=true" width="700" />

## Example using `ggplot2` - with grid line colours

Same as above but with 3 differences:
- Alternating coloured horizontal lines added (white and grey)
- Ordered by effect size rather than custom (as appears in file)
- Different "classic" theme to include axis lines and no reference lines 

[Link to syntax](https://github.com/lukepilling/forest_plots/blob/main/simple_forest_with_grid_colours_ggplot2.R). Example output:

<img src="https://github.com/lukepilling/forest_plots/blob/main/simple_forest_with_grid_colours_ggplot2.jpg?raw=true" width="700" />

## Example using `ggplot2` - with grid line colours - limit axes & add arrows

As above, with one difference:
- Axes can be limited if wide CIs are not desired. Arrows are added to show CIs go beyond limits

[Link to syntax](https://github.com/lukepilling/forest_plots/blob/main/simple_forest_with_grid_colours_axis_limits_ggplot2.R). Example output:

<img src="https://github.com/lukepilling/forest_plots/blob/main/simple_forest_with_grid_colours_axis_limits_ggplot2.jpg?raw=true" width="700" />

