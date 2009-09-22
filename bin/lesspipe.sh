#!/bin/sh -
#
# To use this filter with less, define LESSOPEN:
# export LESSOPEN="|/usr/bin/lesspipe.sh %s"

lesspipe() {
  case "$1" in
    *.[1-9n]|*.man|*.[1-9n].bz2|*.man.bz2|*.[1-9].gz|*.[1-9]x.gz|*.[1-9].man.gz)
      case "$1" in
        *.gz)  DECOMPRESSOR="gunzip -c" ;;
        *.bz2) DECOMPRESSOR="bunzip2 -c" ;;
        *)     DECOMPRESSOR="cat" ;;
      esac
      if $DECOMPRESSOR -- "$1" | file - | grep -q troff; then
        if echo "$1" | grep -q ^/; then	#absolute path
          man -- "$1" | cat -s
        else
          man -- "./$1" | cat -s
        fi
      else
        $DECOMPRESSOR -- "$1"
      fi
      ;;
    *.tar)
      tar tvvf "$1"
      ;;
    *.tgz|*.tar.gz|*.tar.[zZ])
      tar tzvvf "$1"
      ;;
    *.tar.bz2|*.tbz2)
      tar jtvvf "$1"
      ;;
    *initrd*.gz)
      gunzip -c "$1" | cpio -tv
      ;;
    *.[zZ]|*.gz|*.svgz)
      gzip -dc -- "$1"
      ;;
    *.bz2)
      bzip2 -dc -- "$1"
      ;;
    *.zip|*.Zip|*.ZIP|*.jar|*.sar|*.xpi|*.job)
      zipinfo -- "$1"
      ;;
    *.rar)
      unrar v "$1"
      ;;
    *.[rs]pm)
      rq "$1"
      ;;
    *.cpi|*.cpio)
      cpio -itv < "$1"
      ;;
    *.htm|*.html)
      exec w3m -T text/html "$1"
      ;;
    *.gif|*.jpeg|*.jpg|*.pcd|*.png|*.tga|*.tiff|*.tif)
      if [ -x "`which identify`" ]; then
        identify "$1"
      else
        echo "No identify available"
        echo "Install ImageMagick to browse images"
      fi
      ;;
    *)
      case "$1" in
        *.gz)	DECOMPRESSOR="gunzip -c" ;;
        *.bz2)	DECOMPRESSOR="bunzip2 -c" ;;
      esac
      if [ ! -z $DECOMPRESSOR ] ; then
        $DECOMPRESSOR -- "$1" ;
      fi
      ;;
# Can't remember why I wanted to allow use as a filter but it breaks
# hitting 'v' from less to edit.
#  *) cat "$1" ;;
  esac
}

lesspipe "$1" 2>/dev/null
