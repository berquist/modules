whatis("FFTW, the fastest Fourier transform in the West")

conflict("fftw")

local apps_root = "/ihome/dlambrecht/erb74/opt/apps/"
local package_root = apps_root .. "fftw/2.1.5-i2017.1.132-qchem"

setenv("FFTW_ROOT", package_root)
setenv("FFTW_DIR", package_root)

prepend_path("LIBRARY_PATH", pathJoin(package_root, "lib"))
prepend_path("INCLUDEPATH", pathJoin(package_root, "include"))
prepend_path("INCLUDE_PATH", pathJoin(package_root, "include"))
prepend_path("LD_LIBRARY_PATH", pathJoin(package_root, "lib"))
prepend_path("MANPATH", pathJoin(package_root, "share/man"))
prepend_path("CMAKE_PREFIX_PATH", package_root)
