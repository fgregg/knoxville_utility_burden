# Utility Burden in Knoxville
[This report describes racial disparities in utility burdens of Knoxville households](https://bunkum.us/knoxville_utility_burden/analysis.pdf). We use the 2019 1-year American Community Survey 
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
    ├── Dockerfile         <- Dockerfile to setup the environment for building the report
    ├── reports            <- R Markdown (.Rmd) files and associated outputs.
    ├── processors         <- Scripts for transforming R Markdown files to PDFs and other outputs
    └── install.R          <- Install R dependencies

# To build report
```bash
> make all
```
