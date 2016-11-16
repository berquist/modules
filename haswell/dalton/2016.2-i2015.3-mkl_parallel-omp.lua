whatis("DALTON, an overly-complicated high-level quantum chemistry package")

conflict("dalton")

local apps_root = "/ihome/dlambrecht/erb74/opt/apps/"
local package_root = pathJoin(apps_root, "dalton/2016.2-i2015.3-mkl_parallel-omp")

setenv("DALTON_ROOT", package_root)
setenv("WRKDIR", os.getenv("SLURM_SUBMIT_DIR"))
setenv("DALTON_TMPDIR", os.getenv("LOCAL"))

prepend_path("PATH", pathJoin(package_root, "dalton"))
