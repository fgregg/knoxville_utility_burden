.PHONY: all
all : reports/analysis.pdf

.PHONY: install/R
install/R: ## Install R dependencies (usually only required once) 
	Rscript install.R

reports/%.pdf: reports/%.Rmd  ## Make reports/%.pdf for reports/%.Rmd
	processors/knit.sh $< $@