#!/bin/bash

rm -rf dist

for talk in $(ls slides);
do
  mkdir -p dist/$talk
  cp -r slides/$talk/dist/* dist/$talk
done