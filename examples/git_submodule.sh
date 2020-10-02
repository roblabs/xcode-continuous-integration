#!/bin/sh

cd ${PROJECT_DIR}
git submodule sync && git submodule update --init --recursive
wait
