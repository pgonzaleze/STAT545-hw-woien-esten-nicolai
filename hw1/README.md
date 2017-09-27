# STAT545 Homework 1
### How I changed the documents in the repo

1. Initialized the repo with a README
2. Changed the README on github
3. All other changed were done locally inside RStudio
    - After doing the changes I wanted, the procedure were as follows:
        a. commit
        b. pull
        c. push
    - As I were the only one doing the commits, there were no conflicts

Concerning the process with R Markdown and github, I've uploaded some R Markdown Testing in both [md](hw01_gapminder.md) and [Rmd](hw01_gapminder.Rmd) formats. I had some trouble supressing the output when loading libraries. I expected 
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

