whatis("DALTON, an overly-complicated high-level quantum chemistry package")

conflict("dalton")

local apps_root = "/ihome/dlambrecht/erb74/opt/apps/"
local package_root = pathJoin(apps_root, "dalton/2016.2-i2017.1-mkl_parallel-omp")

setenv("DALTON_ROOT", package_root)

if (os.getenv("SLURM_SCRATCH") == nil) then
    setenv("DALTON_TMPDIR", "/tmp")
else
    setenv("DALTON_TMPDIR", os.getenv("SLURM_SCRATCH"))
end

prepend_path("PATH", pathJoin(package_root, "dalton"))
