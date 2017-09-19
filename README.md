# STAT545 Homework 1
*An improper introduction to Esten Nicolai Wøien (or with an o if you perfer)*

I'm a Norwegian visiting student, studying statistics for a year at UBC. I'm in a physics and mathematics program, but specialize in computational learning theory as it is a nice combination of

+ **Math**
    - Optimization
    - Convergence of methods
+ **Computer science**
    - Implementation
    - Method complexity
+ **Statistics**
    - Classification
    - Regression
    - Simulation

On non-school related interests, I love to hike, run, ski (cross-contry, alpine, telemark, randonee, anything), orienteering, and so fourth. I.e. all fun outdoor activities. 


### How I changed the documents in the repo

1. Initialized the repo with a README
2. Changed the README on github
3. All other changed were done locally inside RStudio

Concerning the process with R Markdown and github, I've uploaded some R Markdown Testing in both [md](R_Markdown_testing.md) and [Rmd](R_markdown_testing.Rmd). I had some trouble supressing the output when loading libraries. I expected 
````
```{r, results='hide'}
code
```
````
to supress the output, but figured that I needed
````
```{r, message=FALSE, warning=FALSE}
code
```
````
It is really nice to have the option to differentiate between results, messages, warnings and errors though.

