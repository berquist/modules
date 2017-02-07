whatis("Q-Chem, copy of $QCSVN/branches/libresponse")

conflict("qchem")

local apps_root = "/ihome/dlambrecht/erb74/opt/apps/"
local package_root = pathJoin(apps_root, "qchem/branches_libresponse")

setenv("QCSCRATCH", pathJoin(os.getenv("HOME"), "scratch/qchem"))
setenv("QCLOCALSCR", os.getenv("LOCAL"))
setenv("QC", package_root)
setenv("QCAUX", pathJoin(package_root, "../qcaux"))
setenv("QC_EXT_LIBS", pathJoin(package_root, "../qc_ext_libs"))
setenv("QCREF", pathJoin(package_root, "../qcref"))
setenv("QCPLATFORM", "LINUX_Ix86_64")
setenv("QCRSH", "ssh")
setenv("QCMPI", "openmpi")
prepend_path("PATH", pathJoin(package_root, "bin"))

local svn_root = "https://jubilee.q-chem.com/svnroot"

setenv("SVNROOT", svn_root)
setenv("QCSVN", pathJoin(svn_root, "qchem"))
setenv("QCREFSVN", pathJoin(svn_root, "qchem_dailyref"))
setenv("QCAUXSVN", pathJoin(svn_root, "qcaux"))
setenv("QCMANUAL", pathJoin(svn_root, "qchem_manual"))
setenv("SVN_EDITOR", "emacs")
