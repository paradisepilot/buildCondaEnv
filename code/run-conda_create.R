
run.conda_create <- function(
    env.path = "condaEnvGEE"
    ) {

    thisFunctionName <- "run.conda_create";
    cat("\n### ~~~~~~~~~~~~~~~~~~~~ ###");
    cat(paste0("\n",thisFunctionName,"() starts.\n\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    require(reticulate);

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat("\nenv.path\n");
    print( env.path   );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    if ( dir.exists(env.path) ) {
        cat("\nThe conda environment '",env.path,"' already exists; activating this conda environment ...\n");
        reticulate::use_condaenv(condaenv = env.path, required = TRUE);
        cat("\nThe conda environment '",env.path,"' has been activated ...\n");
        DF.conda.list  <- reticulate::conda_list();
        selected.row   <- grepl(x = DF.conda.list[,'python'], pattern = env.path);
        my.python.path <- DF.conda.list[selected.row,'python'];
    } else {
        cat("\nConda environment creation begins: '",env.path,"'\n");
        my.python.path <- reticulate::conda_create(
            envname  = env.path,
            forge    = TRUE,
            conda    = "auto",
            packages = c("earthengine-api","google-cloud-sdk"),
            channel  = c(
                'conda-forge',
                'conda-forge/label/cf201901',
                'conda-forge/label/cf202003',
                'conda-forge/label/gcc7'
                )
            );
        cat("\nConda environment creation complete: '",env.path,"'\n");
        }

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
