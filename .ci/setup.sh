# failure is a natural part of life
set -e

# If language: r,
# install these testing packages we need
if [[ "$TASK" == "rpkg" ]];
then

    export R_LIBS=${HOME}/Rlib
    export R_LINUX_VERSION="4.0.3-1.1804.0"
    export R_APT_REPO="bionic-cran40/"

    mkdir -p ${R_LIBS}

    # `devscripts` is required for 'checkbashisms' (https://github.com/r-lib/actions/issues/111)
    if [[ $OS_NAME == "linux" ]]; then
        sudo apt-get update
        sudo apt-get install \
            --no-install-recommends \
            -y \
            --allow-downgrades \
                libcurl4-openssl-dev \
                curl \
                devscripts \
                || exit -1
    fi

    Rscript -e "install.packages(c('assertthat', 'covr', 'data.table', 'futile.logger', 'httr', 'jsonlite', 'knitr', 'lintr', 'purrr', 'rmarkdown', 'stringr', 'testthat', 'uuid'), repos = 'http://cran.rstudio.com', lib = '${R_LIBS}')"
    cp test-data/* r-pkg/inst/testdata/
fi
