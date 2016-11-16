#%Module1.0

# ======================================================================
# Useful Local Variables
# ======================================================================

#  $modfile      : This module's file path relative to modulefiles root
#  $submods      : List of submodules
#  $modfile_base : This module's plain file name 
#  $ver          : Module version (same as $modfile_base for now)

set modfile [ module-info name ] 
set submods [ split "$modfile" / ]  
set modfile_base [ lindex $submods [ expr [ llength $submods ] - 1 ] ]
set ver $modfile_base

# ======================================================================
# Documentation
# ======================================================================

module-whatis "PC GAMESS/Firefly v$ver"

# ====================================================================
# Dependencies
# ====================================================================

conflict firefly

# ====================================================================
# Local settings
# ====================================================================

# this is only sets a variable to be used in this modulefile
set root $::env(QCPROGS)/$modfile

# ====================================================================
# Add stuff to PATH, LD_LIBRARY_PATH, MANPATH, etc..
# ====================================================================

prepend-path PATH $root
