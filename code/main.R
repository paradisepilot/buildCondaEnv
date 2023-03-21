
command.arguments <- commandArgs(trailingOnly = TRUE);
data.directory    <- normalizePath(command.arguments[1]);
code.directory    <- normalizePath(command.arguments[2]);
output.directory  <- normalizePath(command.arguments[3]);

print( data.directory );
print( code.directory );
print( output.directory );

print( format(Sys.time(),"%Y-%m-%d %T %Z") );

start.proc.time <- proc.time();

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
# set working directory to output directory
setwd( output.directory );

##################################################
require(reticulate);

# source supporting R code
code.files <- c(
    "run-conda_create.R",
    "run-virtualenv_install.R",
    "test-conda_clone-install_ee.R"
    );

for ( code.file in code.files ) {
    source(file.path(code.directory,code.file));
    }

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
my.seed <- 7654321;
set.seed(my.seed);

is.macOS <- grepl(x = sessionInfo()[['platform']], pattern = 'apple', ignore.case = TRUE);
n.cores  <- ifelse(test = is.macOS, yes = 2, no = parallel::detectCores() - 1);
cat(paste0("\n# n.cores = ",n.cores,"\n"));

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
env.path <- file.path(output.directory,"envGeospatial");
print( env.path );

if ( !dir.exists(paths = env.path) ) {
    dir.create(
        path         = env.path,
        showWarnings = TRUE,
        recursive    = TRUE,
        mode         = "0777"
        );
    }
print( dir.exists(paths = env.path) );

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
run.conda_create(
    env.path = env.path,
    packages = c(
        "earthengine-api",
        "google-cloud-sdk",
        "geemap"
        ),
    channels = c(
        'conda-forge',
        'conda-forge/label/cf201901',
        'conda-forge/label/cf202003',
        'conda-forge/label/gcc7'
        )
    );

run.virtualenv_install(
    env.path = env.path,
    packages = c(
        "gdal",
        "geopandas",
        "rasterio",
        "rHEALPixDGGS",
        "ease-grid",
        "pydggrid",
        "dggrid4py"
        )
    );

# test.conda_clone.install_ee(
#     clone.path   = gee.env.path,
#     to.be.cloned = "r-reticulate" # "base" # "r-reticulate" did NOT work; it stalled for 30 minutes
#     );

### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

##################################################
print( warnings() );

print( getOption('repos') );

print( .libPaths() );

print( sessionInfo() );

print( format(Sys.time(),"%Y-%m-%d %T %Z") );

stop.proc.time <- proc.time();
print( stop.proc.time - start.proc.time );
