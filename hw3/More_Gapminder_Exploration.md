More Gapminder Exploration
================

``` r
library(gapminder)
library(tidyverse)
source('code/Weighted Quantile.R')
```

Task 1
------

*Report the absolute and/or relative abundance of countries with low life expectancy over time by continent: Compute some measure of worldwide life expectancy – you decide – a mean or median or some other quantile or perhaps your current age. Then determine how many countries on each continent have a life expectancy less than this benchmark, for each year.*

Let's calculate the life 10% percentile life expectancy for the world. To do this, we cannot simly use R's quantile function, as we need weighted quantiles

problem 1: computes the quantile for the first year, and uses that year as the quantile for all years

<https://stackoverflow.com/questions/10220510/summary-statistics-by-two-or-more-factor-variables>

First of all, lets manipulate the data, and add a field for the 10th percentile for life expectation. As the population of each country varies a lot, the percentile is weighted with the population. Click [here](code/Weighted_Quantile.md) to see how the weighted quantiles are computed. This is a bit technical, but we define the 10th percentile life expectancy as the following,

*The 10th percentile life expectancy **q**, is such that 10 percent of the continent's population lives in a country with a lower or equal life expectancy than **q**, and 90 percent of the continent's population lives in a country with a higher or equal life expectancy than **q**. *

``` r
gapminder.without.Oceania <- gapminder %>% 
  filter(continent != 'Oceania') %>% # Filter out Oceania as we don't have 
  droplevels()                       # enough observations for computing quantiles
```

    ## Warning: package 'bindrcpp' was built under R version 3.2.5

``` r
# Group by year, such that we can compute the worlds 10th percentile life expectation for each year
dat.world <- gapminder.without.Oceania %>%
  group_by(year) %>% 
  mutate(lifeExp.10 = weighted.quantile(lifeExp, weight=as.numeric(pop), probs=0.1))

dat <- gapminder.without.Oceania %>% 
  group_by(continent, year)      %>% # We want to compute the 10th percentile life exp for each continent and each year
  mutate(lifeExp.10 = weighted.quantile(lifeExp, weight=as.numeric(pop), probs=0.1)) %>% 
  ungroup() %>%                      # Add the world's 10th percentile life expectancy
  add_row(continent='World', year=dat.world$year, lifeExp.10=dat.world$lifeExp.10)
```

``` r
dat %>% 
  with(tapply(lifeExp.10, list(continent, year), mean)) %>% 
  knitr::kable()
```

|          |    1952|    1957|    1962|    1967|    1972|    1977|    1982|    1987|    1992|    1997|    2002|    2007|
|----------|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
| Africa   |  32.978|  34.906|  36.936|  38.487|  40.328|  41.842|  42.955|  44.555|  44.284|  43.795|  43.753|  43.487|
| Americas |  41.912|  44.142|  46.954|  50.016|  53.738|  56.029|  56.604|  60.782|  63.373|  66.322|  68.565|  69.819|
| Asia     |  37.373|  39.918|  42.518|  45.415|  45.252|  46.923|  50.957|  53.914|  56.018|  59.412|  60.308|  62.698|
| Europe   |  61.050|  64.770|  67.130|  68.500|  69.760|  70.450|  70.960|  71.520|  72.178|  73.244|  74.670|  75.563|
| World    |  37.373|  39.348|  40.870|  43.453|  44.600|  46.775|  49.113|  50.821|  51.604|  51.455|  50.525|  51.542|

<https://stackoverflow.com/questions/13396662/get-list-of-colors-used-in-a-ggplot2-plot>

``` r
library(scales) # methods for plot scaling
```

    ## Warning: package 'scales' was built under R version 3.2.5

    ## 
    ## Attaching package: 'scales'

    ## The following object is masked from 'package:purrr':
    ## 
    ##     discard

    ## The following object is masked from 'package:readr':
    ## 
    ##     col_factor

``` r
dat %>% 
  ggplot(aes(x=year, color=continent)) + 
  geom_line(aes(y=lifeExp,group=country),alpha=0.1) + 
  geom_line(aes(y=lifeExp.10), size=1) + 
  scale_color_manual(values=c(scales::hue_pal()(5)[1:4], '#000000')) + # Gets ggplot's hue palette, and addes a black color to the palette, then colors the line with the new palette
  labs(title='10th Percentile Life Expectancy', x='Year', y='Life Expectancy')
```

![](More_Gapminder_Exploration_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

Two observations. First, notice that after 1987, the 10th percentile life expectancy in Africa drops. This does not follow the rest of the world's trend, but can be explained by the outbreak of HIV and Aids. In addition, ovserve that almost all countries lower than the world's 10th percentile life expectation are African.

<https://stackoverflow.com/questions/6999144/how-do-you-create-a-bar-plot-for-two-variables-mirrored-across-the-x-axis-in-r> <https://stackoverflow.com/questions/13734368/ggplot2-and-a-stacked-bar-chart-with-negative-values>

``` r
dat %>% 
  group_by(year,continent) %>% 
  mutate(pop = pop/sum(as.numeric(pop))) %>% 
  group_by(year) %>% 
  mutate(pop.over  = pop*(lifeExp>=lifeExp.10[continent=='World']),
         pop.under = pop*(lifeExp< lifeExp.10[continent=='World'])) %>% 
  filter(continent != 'World') %>% 
  group_by(year,continent) %>%
  summarize(pop.under = sum(pop.under), pop.over = sum(pop.over)) %>% 
  
  ggplot(aes(x=factor(year))) +
  geom_bar(aes(y=pop.under, group=continent, fill=continent), stat='identity', position='stack')
```

![](More_Gapminder_Exploration_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

``` r
dat %>% 
  group_by(year,continent) %>% 
  mutate(pop = pop/sum(as.numeric(pop))) %>% 
  group_by(year) %>% 
  mutate(pop.over  = pop*(lifeExp>=lifeExp.10[continent=='World']),
         pop.under = pop*(lifeExp< lifeExp.10[continent=='World'])) %>% 
  filter(continent != 'World')
```

    ## # A tibble: 1,680 x 9
    ## # Groups:   year [12]
    ##        country continent  year lifeExp         pop gdpPercap lifeExp.10
    ##         <fctr>    <fctr> <int>   <dbl>       <dbl>     <dbl>      <dbl>
    ##  1 Afghanistan      Asia  1952  28.801 0.006038118  779.4453     37.373
    ##  2 Afghanistan      Asia  1957  30.332 0.005913136  820.8530     39.918
    ##  3 Afghanistan      Asia  1962  31.997 0.006052430  853.1007     42.518
    ##  4 Afghanistan      Asia  1967  34.020 0.006054568  836.1971     45.415
    ##  5 Afghanistan      Asia  1972  36.088 0.006080720  739.9811     45.252
    ##  6 Afghanistan      Asia  1977  38.438 0.006240422  786.1134     46.923
    ##  7 Afghanistan      Asia  1982  39.854 0.004935305  978.0114     50.957
    ##  8 Afghanistan      Asia  1987  40.822 0.004829986  852.3959     53.914
    ##  9 Afghanistan      Asia  1992  41.674 0.005207916  649.3414     56.018
    ## 10 Afghanistan      Asia  1997  41.763 0.006569772  635.3414     59.412
    ## # ... with 1,670 more rows, and 2 more variables: pop.over <dbl>,
    ## #   pop.under <dbl>

``` r
gapminder %>% 
  mutate(lifeExpChange = lifeExp - lag(lifeExp,1),
         didDecrease = pop*(lifeExpChange<0)) %>% 
  filter(year != min(year)) %>% 
  group_by(continent, year) %>% 
  summarize(s=sum(didDecrease)) %>% 
  ggplot(aes(x=year+2.5, y=s+0.0*(s==0), fill=continent)) + 
  geom_histogram(stat='identity', position='stack') +
  scale_x_continuous(breaks=seq(1952,2007,5))
```

    ## Warning: Ignoring unknown parameters: binwidth, bins, pad

![](More_Gapminder_Exploration_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-7-1.png)

``` r
gapminder %>% 
  mutate(lifeExpChange = lifeExp - lag(lifeExp,1),
         didDecrease = lifeExpChange<0) %>% 
  filter(year != min(year)) %>% 
  group_by(continent, year) %>% 
  summarize(s=sum(didDecrease)) %>% 
  ggplot(aes(x=year, y=s+0.0*(s==0), fill=continent)) + 
  geom_histogram(stat='identity', position='stack')
```

    ## Warning: Ignoring unknown parameters: binwidth, bins, pad

![](More_Gapminder_Exploration_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-8-1.png)

``` r
gapminder %>% 
  mutate(popChange = (pop - lag(pop,1))/pop) %>% 
  filter(year != min(year)) %>% 
  group_by(continent, year) %>% 
  ggplot(aes(x=year, y=popChange, color=continent)) + 
  geom_point(alpha=0.3, aes(size=pop)) + 
  geom_smooth(se=FALSE, aes(group=continent))
```

    ## `geom_smooth()` using method = 'loess'

![](More_Gapminder_Exploration_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)
