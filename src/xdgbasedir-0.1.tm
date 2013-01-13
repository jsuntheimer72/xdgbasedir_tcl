# XDG Base Directory Specification handling
#
# Copyright (C) 2013 Lawrence Woodman
#
# Licensed under an MIT licence.  Please see LICENCE.md for details.
#
# For XDG Base Directory Specification
#   http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
#

namespace eval XDG {

  variable DEFAULTS [list \
    DATA_HOME [file join $::env(HOME) .local share] \
    CONFIG_HOME [file join $::env(HOME) .config]
  ]

  proc HOME {var default {subdir ""} } {
    set dir $default

    if {[info exists ::env(XDG_$var)] && $::env(XDG_$var) ne ""} {
      set dir $::env(XDG_$var)
    }

    return [file join $dir $subdir]
  }

  # Create procs to access the XDG variables
  dict for {var default} $DEFAULTS {
    set internalCommand [regsub {^(.*_)([^_]+)$} $var {\2}]
    proc $var { {subdir ""} } [concat $internalCommand $var $default {$subdir}]
  }
}
