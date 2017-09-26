Gapminder Exploration
================

### Introduction

We are going to explore the gapminder data set included with R.

### Table of content

-   [1 Data Set Basics](#data-set-basics)
-   [1.1 Installation](#installation)
-   [1 Data Visualization](#data-visualization)

1 Data Set Basics
-----------------

#### 1.1 Installation

The gapminder data set is a package in itself, and should therefore be included in the workspace the normal way, i.e.

``` r
library(gapminder)
library(tidyverse)
```

As you might noticed, we also included the tidyverse package. In general, tidyverse is a very useful package and is useful in almost all circumstances. In addition, we need ggplot from the tidyverse later in this exploration, so we might as well include it immediately.

#### 1.2 Data Types

To get an understanding of the gapminder dataset it's important to know what data types the dataset exists of.

``` r
str(gapminder)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    1704 obs. of  6 variables:
    ##  $ country  : Factor w/ 142 levels "Afghanistan",..: 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ continent: Factor w/ 5 levels "Africa","Americas",..: 3 3 3 3 3 3 3 3 3 3 ...
    ##  $ year     : int  1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 ...
    ##  $ lifeExp  : num  28.8 30.3 32 34 36.1 ...
    ##  $ pop      : int  8425333 9240934 10267083 11537966 13079460 14880372 12881816 13867957 16317921 22227415 ...
    ##  $ gdpPercap: num  779 821 853 836 740 ...

As one can see, the gapminder data set can be seen as both a tibble and a data frame. I've understood that a tibble class is a "polished" version of the data frame class. Feel free to let me know if otherwise. The data set has 1704 observations of 6 variables. The variables are as follows,

| Variable name | Data type |
|---------------|-----------|
| country       | Factor    |
| continent     | Factor    |
| year          | int       |
| lifeExp       | num       |
| pop           | int       |
| gdpPercap     | num       |

Note that in R, num is equivalent to double in other languages. There are a lot of ways to disect this data, but I feel that str() gives me what I want. Other ways are

``` r
class(gapminder)
```

    ## [1] "tbl_df"     "tbl"        "data.frame"

``` r
summary(gapminder)
```

    ##         country        continent        year         lifeExp     
    ##  Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60  
    ##  Albania    :  12   Americas:300   1st Qu.:1966   1st Qu.:48.20  
    ##  Algeria    :  12   Asia    :396   Median :1980   Median :60.71  
    ##  Angola     :  12   Europe  :360   Mean   :1980   Mean   :59.47  
    ##  Argentina  :  12   Oceania : 24   3rd Qu.:1993   3rd Qu.:70.85  
    ##  Australia  :  12                  Max.   :2007   Max.   :82.60  
    ##  (Other)    :1632                                                
    ##       pop              gdpPercap       
    ##  Min.   :6.001e+04   Min.   :   241.2  
    ##  1st Qu.:2.794e+06   1st Qu.:  1202.1  
    ##  Median :7.024e+06   Median :  3531.8  
    ##  Mean   :2.960e+07   Mean   :  7215.3  
    ##  3rd Qu.:1.959e+07   3rd Qu.:  9325.5  
    ##  Max.   :1.319e+09   Max.   :113523.1  
    ## 

``` r
head(gapminder,n=1)
```

    ## # A tibble: 1 x 6
    ##       country continent  year lifeExp     pop gdpPercap
    ##        <fctr>    <fctr> <int>   <dbl>   <int>     <dbl>
    ## 1 Afghanistan      Asia  1952  28.801 8425333  779.4453

It seems like there are 12 observations from each contry, ranging from 1952 to 2007. Can this be confirmed?

``` r
number.of.observations.per.country <- table(gapminder$country)
var(number.of.observations.per.country)
```

    ## [1] 0

``` r
table(gapminder$year)
```

    ## 
    ## 1952 1957 1962 1967 1972 1977 1982 1987 1992 1997 2002 2007 
    ##  142  142  142  142  142  142  142  142  142  142  142  142

We have already seen that there is 12 observations from at least one coutry. Therefore, when the variance of the number of observations per country is zero, this means that all countries have 12 observations. Further, the last command line shows that each year, there are consistently 142 observations.

2 Data Visualization
--------------------

Lets analyse how the life expectancy has changed over the years. An estimation of the distribution of the life expectancy for a given decade is plotted below.

``` r
p3 <- gapminder %>% 
  mutate(decade = floor(year/10)*10) %>% 
  ggplot(aes(x=lifeExp))
```

    ## Warning: package 'bindrcpp' was built under R version 3.2.5

``` r
p3 + geom_density(aes(fill=factor(decade),color=factor(decade)),alpha=0.1) + xlim(20,90) + ylim(0,0.045)
```

![](Gapminder_Exploration_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

``` r
p2 <- gapminder %>% 
  group_by(year) %>%
  mutate(q.1 = quantile(lifeExp,0.1),
         q.5 = quantile(lifeExp,0.5),
         q.9 = quantile(lifeExp,0.9)) %>% 
  ggplot(aes(x=year))

p2 + 
  geom_ribbon(aes(ymin=q.1, ymax=q.9),fill='black',alpha=0.2) +
  geom_line(aes(y=q.5),size=0.5,color='red')
```

![](Gapminder_Exploration_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

``` r
p4 <- gapminder %>% 
  group_by(continent) %>% 
  ggplot(aes(x=year, y=pop))

#p4 + geom_histogram(position='fill')
```
