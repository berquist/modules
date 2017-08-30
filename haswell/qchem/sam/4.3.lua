-- Package Root
local package_root = "/ihome/crc/build/qchem/4.3"

-- Description
whatis("Name: "..myModuleName())
whatis("Version: 4.3")
whatis("Description: QChem 4.3")
whatis("Keywords: QChem")
whatis("URL: http://www.q-chem.com/qchem-website/manual/qchem43_manual/")

-- Environment Variables
if (os.getenv("SLURM_SCRATCH") == nil) then
    LmodError("ERROR: Running outside of SLURM, exiting")
else
    setenv("QCSCRATCH", os.getenv("SLURM_SUBMIT_DIR"))
    setenv("QCLOCALSCR", os.getenv("SLURM_SCRATCH"))
end

-- Gaussian profile script
execute{cmd="source " .. pathJoin(package_root, "/qcenv.sh"), modeA={"load"}}
