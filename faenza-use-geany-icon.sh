#!/bin/sh -e
#
# this script installs default Geany icons so Faenza theme uses them instead of
# its weird icon.  works both if the theme is installed system-wide or in
# ~/.icons; but in the latter case you might simply want to rename the Faenza
# icons, using e.g.
#   $ find ~/.icons/Faenza -name 'geany.*' -exec mv '{}' '{}.bak' ';'

find_geany_datadir() {
  dir=$(pkg-config --variable=datadir geany 2>/dev/null)
  if [ -z "$dir" ]; then
    dir=$(which geany 2>/dev/null | sed 's%/bin/geany$%/share%')
  fi
  
  [ -n "$dir" ] && echo "$dir"
}

die() {
  echo "$@" >&2
  exit 1
}

render_svg() {
  if which inkscape >/dev/null; then
    echo "rendering '$1' as '$2' (size '$3') with inkscape"
    inkscape -f "$1" -e "$2" -w "$3" -h "$3"
    [ -f "$2" ] # inkscape always exists with code 0, so check the output file
  elif which rsvg >/dev/null; then
    echo "rendering '$1' as '$2' (size '$3') with rsvg"
    rsvg -f png -o "$2" -w "$3" -h "$3" "$1"
  else
    die "no SVG renderer found"
  fi
}


SRC="$(find_geany_datadir)/icons/hicolor" || die "cannot find Geany data directory"
DEST="$HOME/.icons/Faenza"

[ -d "$SRC" ] || die "invalid Geany data directory '$SRC'"
[ -d "$DEST" ] || mkdir -p "$DEST"

for size in 16 22 24 32 48 64 96 scalable; do
  ext=$(if [ "$size" = scalable ]; then echo svg; else echo png; fi)
  
  f="${DEST}/apps/${size}/geany.${ext}"
  if [ -e "$f" ]; then
    mv "$f" "$f.bak"
  fi
  d="$(dirname "$f")"
  [ -d "$d" ] || mkdir -p "$d"
  
  if [ "$size" = scalable ]; then
    f="$SRC/${size}/apps/geany.svg"
    [ -f "$f" ] || die "$f: no such file or directory"
    ln -s "$f" "$d"
  else
    s="$SRC/${size}x${size}/apps/geany.${ext}"
    if [ -f "$s" ]; then
      ln -s "$s" "$d"
    else
      render_svg "$SRC/scalable/apps/geany.svg" "$f" "$size" >/dev/null
    fi
  fi
done

echo 'OK, done.'
