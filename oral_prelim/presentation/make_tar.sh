#!/bin/bash -xe

tar_dir="Kyle_Thompson_Oral_Prelim"

rm -rf ${tar_dir} presentation.tar
mkdir -p ${tar_dir}

cp -a presentation.pdf movies ${tar_dir}

tar -czf presentation.tar ${tar_dir}
