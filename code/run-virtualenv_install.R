
run.virtualenv_install <- function(
    env.path = "condaEnvGEE",
    packages = c(
        "gdal",
        "geopandas",
        "rasterio"
        )
    ) {

    thisFunctionName <- "run.virtualenv_install";
    cat("\n### ~~~~~~~~~~~~~~~~~~~~ ###");
    cat(paste0("\n",thisFunctionName,"() starts.\n\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(reticulate);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat("\nenv.path\n");
    print( env.path   );

    cat("\npackages\n");
    print( packages   );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat("\nvirtualenv_install() execution begins: '",env.path,"'\n");
    my.python.path <- reticulate::virtualenv_install(
       envname          = env.path,
       packages         = packages,
       ignore_installed = TRUE,
       pip_options      = character()
       );
    cat("\nmy.python.path\n");
    print( my.python.path   );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat("\nreticulate::py_list_packages(envname = env.path, type = 'conda')\n");
    print(
        reticulate::py_list_packages(
            envname = env.path,
            type    = "conda"
            )
        );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\n",thisFunctionName,"() quits."));
    cat("\n### ~~~~~~~~~~~~~~~~~~~~ ###\n");
    return( my.python.path );

    }

##################################################
