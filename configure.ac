AC_PREREQ([2.64])
AC_INIT([geany-faenza-icon], [0.1])
AC_CONFIG_SRCDIR([faenza-use-geany-icon.sh])
AC_CONFIG_AUX_DIR([build/ax])
AC_CONFIG_MACRO_DIR([build/m4])
AM_INIT_AUTOMAKE([1.11.1 foreign])

AM_PROG_INSTALL

AC_ARG_WITH([icons_dir],
            [AS_HELP_STRING([--with-icons-dir],
                            [directory where to install icons])],
            [iconsdir="$withval"],
            [iconsdir="${datadir}/icons"])
AC_SUBST([iconsdir])

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
