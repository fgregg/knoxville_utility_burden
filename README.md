# Utility Burden in Knoxville
[This report provides estimates of the proportion of Knoxville households that
are utility burdened, broken by race and housing
tenure](https://bunkum.us/knoxville_utility_burden/analysis.pdf). We use the 2019 1-year American Community Survey 
Public Use Microdata Sample.

# Requirements

* R package dependencies
    - OS X: `brew install pandoc`
    - Ubuntu: `sudo apt install libx11-dev libglu1-mesa-dev`  
* R (for R projects)
    - OS X: `brew install r`
    - Ubuntu: `sudo apt install r-base littler`
* R libraries
    - `make install/R`

# Project Organization

    ├── Makefile           <- Makefile with commands like `make all`
    ├── README.md          <- The top-level README for contributors using this project.
    ├── reports            <- R Markdown (.rmd) files and associated outputs.
    └── install.R          <- Install R dependencies

# To build report
```bash
> make all
```
