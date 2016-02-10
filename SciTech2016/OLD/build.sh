#!/bin/bash -x

pdflatex abstract.tex || (echo "Error in creating pdf... exiting." ; exit 1)

open abstract.pdf
