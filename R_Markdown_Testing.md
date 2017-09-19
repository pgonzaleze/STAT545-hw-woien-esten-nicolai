HM 01 Gapminder Exploration,
================

*Basic care and feeding of data in R*

Relevant Packages
-----------------

We will now load some from the gapminder and tidyverse packages. This is easily done by the following functions.

``` r
library("gapminder")
library("tidyverse")
```

Analyzing Data
--------------

Now that the Gapminder data is loaded, we can analyze the data in several ways.

### Printing Data

The data frame can be printed in many ways. By just typing the name of the data frame, R calls the objects default printing call. The information we obtain can be different depening on the object. For basic data frames like Gapminder, it prints the first few rows of data.

``` r
gapminder
```

    ## # A tibble: 1,704 x 6
    ##        country continent  year lifeExp      pop gdpPercap
    ##         <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
    ##  1 Afghanistan      Asia  1952  28.801  8425333  779.4453
    ##  2 Afghanistan      Asia  1957  30.332  9240934  820.8530
    ##  3 Afghanistan      Asia  1962  31.997 10267083  853.1007
    ##  4 Afghanistan      Asia  1967  34.020 11537966  836.1971
    ##  5 Afghanistan      Asia  1972  36.088 13079460  739.9811
    ##  6 Afghanistan      Asia  1977  38.438 14880372  786.1134
    ##  7 Afghanistan      Asia  1982  39.854 12881816  978.0114
    ##  8 Afghanistan      Asia  1987  40.822 13867957  852.3959
    ##  9 Afghanistan      Asia  1992  41.674 16317921  649.3414
    ## 10 Afghanistan      Asia  1997  41.763 22227415  635.3414
    ## # ... with 1,694 more rows

The first few rows of data can also be printed by calling the head() function. Here you can speficy what number of rows you want to be printed.

``` r
head(gapminder, n = 3)
```

    ## # A tibble: 3 x 6
    ##       country continent  year lifeExp      pop gdpPercap
    ##        <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
    ## 1 Afghanistan      Asia  1952  28.801  8425333  779.4453
    ## 2 Afghanistan      Asia  1957  30.332  9240934  820.8530
    ## 3 Afghanistan      Asia  1962  31.997 10267083  853.1007

Similarly, the last few rows can be printed with the tail() function.

``` r
tail(gapminder, n = 5)
```

    ## # A tibble: 5 x 6
    ##    country continent  year lifeExp      pop gdpPercap
    ##     <fctr>    <fctr> <int>   <dbl>    <int>     <dbl>
    ## 1 Zimbabwe    Africa  1987  62.351  9216418  706.1573
    ## 2 Zimbabwe    Africa  1992  60.377 10704340  693.4208
    ## 3 Zimbabwe    Africa  1997  46.809 11404948  792.4500
    ## 4 Zimbabwe    Africa  2002  39.989 11926563  672.0386
    ## 5 Zimbabwe    Africa  2007  43.487 12311143  469.7093

If you want som general information about the data frame, you can use the summary() function. Again, this produces a different output depending on the objects. For example, for a regression object, it prints the regression coefficient together with measures of significance for the model. For data frames, it prints information about what kind of data the data frame includes, and how much data there are.

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

### Plotting Data

There are a ton of ways to plot the data. You can scatter the data, of plot histograms, box plots and so fourth. Below, we have scattered the GDP per capita (on log scale) vs life expectancy, and made a box plot of year vs life expectancy.

``` r
plot(lifeExp ~ log10(gdpPercap), gapminder, ylab = 'Life expectancy', xlab = 'log10( GPD per capita )')
```

![](R_Markdown_Testing_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)

``` r
boxplot(lifeExp ~ year, gapminder, ylab = 'Life expectancy', xlab = 'Year')
```

![](R_Markdown_Testing_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-2.png)
