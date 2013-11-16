#
# Utility TCL procedures (and possibly variables)
#
# Path to this file is set in the global module initialization script ./etc/rc
# And sourced from modulefiles.
# 
# Ideally, the /etc/rc would contain these functions, but it seems proc definitions
# are lost when the actual module file is processed. This is not the case for the 
# definitions in the .modulerc file on the same directory as the modulefile itself.
# TODO  Check EnvironmentModules code to see why. 
# 


# ======================================================================
# Procedure: _get_render_code
# ======================================================================
# a dictionary of escape codes 
# "\e\[CODEm" is the terminal escape thingy
#
proc _get_render_code {mnemonic} {
    switch $mnemonic {
        black   { return 30 }
        red     { return 31 }
        green   { return 32 }
        yellow  { return 33 }
        blue    { return 34 }
        magenta { return 35 }
        cyan    { return 36 }
        white   { return 37 }
        nocolor { return 39 }
        bold    { return 1  }
        reset   { return 0  }
        underline {return 4}
        reset   { return 0  }
        default { return 0 }
    }
}


# ======================================================================
# Procedure: color_string
# ======================================================================
# Returns colorized string 
# Falls back to nocolor if TERM!=xterm
#
proc color_string {specs str} {
    if { ! [ info exists ::env(TERM) ] } {return $str}
    if { ! ( 
            [string match xterm* $::env(TERM) ] || 
            [string match screen $::env(TERM) ] 
            ) 
     } { return $str }
    
    set render_code ""
    foreach i $specs {
        set render_code [format "%s\033\[%sm" $render_code [_get_render_code $i]]
    }
    return [format "%s%s\033\[%sm" $render_code $str [_get_render_code reset]]
}


# ======================================================================
# Procedure: warning
# ======================================================================
# display warning message
#
proc warning msg {
    puts stderr "[color_string {yellow bold} {warning:}] $msg"
}


# ======================================================================
# Procedure: error
# ======================================================================
# display error message
#
proc errorm msg {
    puts stderr "[color_string {red bold} {error:}] $msg"
}


# ======================================================================
# Procedure: check_group
# ======================================================================
# Check is a given user (defaults to current user) is part of a given group
#
proc check_group {group {user ""} } {
    
    if [ string length "$user" ] {
        set found  [lsearch -exact [split [exec groups $user]] $group] 
    } else { # this is beacuse of the weird behavior of the group cmd, see core.sam.pitt.edu/node/2131
        set found  [lsearch -exact [split [exec groups ]] $group] 
    }

    if { $found >= 0 } {
        return 1
    } else {
        return 0
    }
}


# ======================================================================
# Procedure: require_group
# ======================================================================
# Verify if a user belongs to and break with a proper error if not
#
proc require_group group {
    if [check_group $group ] {return}
        
    set curmod [module-info specified]
    puts stderr ""
    errorm [ format {\
        You must be part of the %s group in order to load %s. 
        To get this resolved, please request access at %s
    } [color_string green $group] \
      [color_string yellow $curmod] \
      [color_string blue http://core.sam.pitt.edu]\
    ]
    break
}


# ======================================================================
# Procedure: require_group_any
# ======================================================================
#
proc require_group_any groups {
    foreach g "$groups" {
        if [check_group $g] {return}
    }
            
    set curmod [module-info specified]
    puts stderr ""
    #errorm [ format {\
        #You must be part of any one of %s groups in order to load %s. 
        #To get this resolved, please request access at %s
    #} [color_string green "$groups"] \
      #[color_string yellow $curmod] \
      #[color_string blue http://core.sam.pitt.edu]\
    #]
    errorm [ format {\
        You do not have permission to load %s. 
        To get this resolved, please request access at %s
    } [color_string yellow $curmod] \
      [color_string blue http://core.sam.pitt.edu]\
    ]

    break
}


# ======================================================================
# Procedure: check_not_in_queue
# ======================================================================
#
proc check_not_in_queue {} {
    if {! [ info exists "::env(PBS_JOBID)" ]} {
        return 1
    } else { return 0; }
}


# ======================================================================
# Procedure: module-load-clean
# ======================================================================
# Loads conditionally when really needs loading
# NOTE: Should change this to match the naming convention of the other
#       procedures in this file. However, there are 90 module files
#       using this procedure as of 22 Oct 13!
#
proc module-load-clean module {
    if { [ module-info mode load ] } {
#        puts stderr "mode load $module"
        if { ![ is-loaded $module ] } {
#            puts stderr "loading $module"
            module load $module
        }
    } else {
#        puts stderr "mode other [module-info mode]"
    }
}


# ======================================================================
# Procedure: deprecate
# ======================================================================
# Show a warning message telling this module is deprecated
# with an optional replacement module
#
# e.g.  No arguments: deprecate
#       One argument: deprecate new-module
#
proc deprecate  args  {
    set deprecated_module "[color_string {red} [module-info specified]]"
    puts stderr ""
    if { $args == "" } {
        warning "Module $deprecated_module is deprecated"
    } else {
        set alternate_module "[color_string {green} $args]"
        warning "Module $deprecated_module is deprecated. Please use $alternate_module instead."
    }
    puts stderr ""
}


# ======================================================================
# Procedure: print_bar
# ======================================================================
# Print a separator bar
#
proc print_bar { } {
    puts stderr "==================================================================="
}


# ======================================================================
# Procedure: print_file
# ======================================================================
proc print_file filename {
    set file [open $filename]
    while {![eof $file]} {
        puts [gets $file]
    }
}
