#!/bin/bash

if [[ $# -eq 0 ]]; then
read -p "Do you want to render? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
render=true
else render=--no-render
fi
else
if [ $1 != "--no-render" ]; then
  echo "argument not recognized"
  exit 1
else
render=$1
fi
fi

if [ $render != "--no-render" ]; then
  echo Rendering
  quarto render
if [ $? -ne 0 ]; then
  echo "render command failed"
  exit 1
fi
fi

  echo fixing links

  Rscript utils/fix-links.r
  
  echo publishing

  quarto publish --no-prompt --no-render --no-browser gh-pages





