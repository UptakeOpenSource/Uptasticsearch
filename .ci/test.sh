#!/bin/bash

# failure is a natural part of life
set -e

if [[ "$TASK" == "rpkg" ]]; then
  Rscript .ci/lint_r_code.R $(pwd)
  R_PACKAGE_DIR=$(pwd)/r-pkg
  R CMD build ${R_PACKAGE_DIR}
  R CMD check \
    --as-cran \
    *.tar.gz
fi

if [[ "$TASK" == "pypkg" ]]; then
  PY_PACKAGE_DIR=$(pwd)/py-pkg
  pytest \
    --verbose \
    ${PY_PACKAGE_DI}
fi
