
reports/%.pdf: reports/%.Rmd  ## Make reports/%.pdf for reports/%.Rmd
	processors/knit.sh $< $@