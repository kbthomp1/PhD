#!/bin/bash

for i in `seq 1 10`; do
  c="Chapter-$i\ (LASDA40051738's\ conflicted\ copy\ 2017-02-27).tex"
  cp "$c" "Chapter-${i}.tex"
  #"../Chapter-${i}/Chapter-${i}.tex"
done
