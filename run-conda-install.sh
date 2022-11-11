
echo starttime=`date`

targetDIR=`pwd`
echo targetDIR=${targetDIR}

conda create  --yes -p ${targetDIR}
conda install --yes -p ${targetDIR} -c conda-forge \
        "r-arrow" \
        "r-bayesplot" \
        "r-Cairo" \
        "r-EnvStats" \
        "r-flexdashboard" \
        "r-gdalutilities" \
        "r-gdalutils" \
        "r-gdata" \
        "r-gdtools" \
        "r-ggiraph" \
        "r-ggpubr" \
        "r-gifski" \
        "r-jqr" \
        "r-magick" \
        "r-pdftools" \
        "r-pkgdown" \
        "r-R2jags" \
        "r-rgdal" \
        "r-ragg" \
        "r-raster" \
        "r-rastervis" \
        "r-rgl" \
        "r-rjags" \
        "r-rJava" \
        "r-rjson" \
        "r-RMariaDB" \
        "r-RMySQL" \
        "r-rstan" \
        "r-rstoolbox" \
        "r-sf" \
        "r-sp" \
        "r-systemfonts" \
        "r-terra" \
        "r-textshaping" \
        "r-tidyverse" \
        "r-tiff" \
        "r-vdiffr" > stdout.conda-install 2> stderr.conda-install

# conda update --yes -name base conda
echo finishtime=`date`

