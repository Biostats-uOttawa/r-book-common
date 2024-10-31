#!/bin/bash


if [[ $# -eq 0 ]]; then
read -p "Do you want to render? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
render=--render
else render=--no-render
fi
else
if [ $1 != "--no-render" ]  || [ $1 != "--render" ]; then
  echo "argument not recognized"
  exit 1
else
render=$1
fi
fi


cwd=`pwd`
echo "render and publish english"
cd $cwd/Rway
bash utils/_render-publish.sh $render


echo "render and publish english"
cd $cwd/enfR
bash utils/_render-publish.sh $render





