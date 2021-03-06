#!/bin/bash
set -e

### Test usage; if incorrect, output correct usage and exit
if [ "$#" -gt 2  -o  "$#" -lt 2 ]; then
    echo "********************************************************************"
    echo "*                        Knitter version 1.0                       *"
    echo "********************************************************************"
    echo -e "The 'knit' script converts rmd files into HTML or PDFs. \n"
    echo -e "usage: knit.sh file.rmd file.{pdf,html} \n"
    echo -e "Spaces in the filename or directory name may cause failure. \n"
    exit 1
fi
# Stem and extension of file
extension1=`echo $1 | cut -f2 -d.`
extension2=`echo $2 | cut -f2 -d.`

### Test if file exist
if [[ ! -r $1 ]]; then
    echo -e "\n File does not exist, or option mispecified \n"
    exit 1
fi

### Test file extension
if [[ $extension1 != Rmd ]]; then
    echo -e "\n Invalid input file, must be a rmd-file \n"
    exit 1
fi

# Create temporary script
# Use user-defined 'TMPDIR' if possible; else, use /tmp
if [[ -n $TMPDIR ]]; then
    pathy=$TMPDIR
else
    pathy=/tmp
fi
# Tempfile for the script
tempscript=`mktemp $pathy/tempscript.XXXXXX` || exit 1

if [[ $extension2 == "pdf" ]]; then
    echo "library(rmarkdown); rmarkdown::render('"${1}"', 'pdf_document')" >> $tempscript
    Rscript $tempscript
fi
if [[ $extension2 == "html" ]]; then
    echo "library(rmarkdown); rmarkdown::render('"${1}"', 'html_document')" >> $tempscript
    Rscript $tempscript
fi