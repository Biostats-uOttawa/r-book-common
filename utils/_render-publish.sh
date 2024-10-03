#!/bin/bash

  echo Rendering

  quarto render

if [ $? -ne 0 ]; then
  echo "render command failed"
  exit 1
else
  echo fixing links

  Rscript utils/fix-links.r
  
  echo publishing

  quarto publish --no-prompt --no-render --no-browser gh-pages
fi




