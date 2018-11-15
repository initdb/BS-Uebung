AC_PREREQ([2.69])
AC_INIT([simple_prog], [1.0], [xxx@fh-rosenheim.de])
AC_CONFIG_HEADERS([config.h])

# Configure to use build-aux for auxilary files
AC_CONFIG_AUX_DIR([build-aux])

# Checks for programs.
AC_PROG_CC

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h])

# Init automake
AM_INIT_AUTOMAKE([1.11 -Wall -Werror])

# Configure creates Makefile
AC_CONFIG_FILES([Makefile])

AC_OUTPUT
