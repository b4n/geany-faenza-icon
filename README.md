Fix Geany icon on the Faenza theme
==================================

The Faenza icon theme
[1](http://tiheum.deviantart.com/art/Faenza-Icons-173323228 "On DeviantArt")
[2](http://gnome-look.org/content/show.php/Faenza?content=128143 "On GnomeLook")
is a popular theme that is even the default on some distributions (e.g.
[Mint](http://www.linuxmint.com/)).

No matter how great it is, many people don't like the icon this theme gives to
Geany: a blue arabic-style drawing with arabic letters reading "Geany" --
nothing similar to the gold magic lamp.  The scripts and icons here are intended
to help replacing this Faenza icon with a more Geany-looking one.


Installing the Faenza-looking icons
-----------------------------------

To install the Faenza-looking Geany icons, you can either manually copy the
icons in the Faenza directory or use the build system.  To use the build
system, you need to setup it first:

    $ ./autogen.sh

Then, you'll configure it to either install system-wide:

    $ ./configure

or to install in your home directory:

    $ ./configure --with-icons-dir="$HOME/.icons"

and finally perform the installation, with root privileges if necessary:

    $ make install

*This will overwrite existing Geany icons in the Faenza theme!*


Using the original Geany icons
------------------------------

Alternatively, you can also revert to the original Geany icon.  To do so, you
can either remove the "geany" icons from the Faenza theme, or override them
back with the originals (e.g. in case it is installed system-wide).
The script `faenza-use-geany-icon.sh` helps to perform the latter.

This script links and renders the original Geany icon from the Geany
installation folders in `~/.icons/Faenza` so they are used in priority over
any system-wide ones.  If the Faenza theme is installed in `~/.icons`, the
files that would get overwritten will be renamed with a `.bak` suffix.

To use this script, you'll need to have Geany installed on your system and
found either in the `PKG_CONFIG_PATH` or the `PATH`.  You will also need
either [Inkscape](http://inkscape.org/) or
[rsvg](https://live.gnome.org/LibRsvg) to render the SVG file at various sizes.

When you have all this, just run the script:

    $ ./faenza-use-geany-icon.sh


Removing the Feanza Geany icons
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you prefer to remove the offending icons from the Faenza theme, you may
use this command to rename the "geany" icons with a ".bak" suffix so they
won't be used:

    $ find ~/.icons/Faenza -name 'geany.*' -exec mv '{}' '{}.bak' ';'

This assumes the icons are installed in your home folder, but you can modify
the command if they are installed system wide (though in this case the
overrides solutions above maybe be better).
