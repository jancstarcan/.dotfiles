#!/bin/zsh

usage() {
  echo "Usage: $0 {full|area|active}"
  exit 1
}

if [[ $# -ne 1 ]]; then
  usage
fi

MODE=$1
OUTFILE=~/Pictures/Screenshots/$(date +'%s_grim.png')

case $MODE in
  full)
    # Full screen capture
    grim - | tee "$OUTFILE" | wl-copy
    ;;
  area)
    # Select area with slurp
    grim -g "$(slurp)" - | tee "$OUTFILE" | wl-copy
    ;;
  active)
    # Active monitor capture
    ACTIVE_OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')
    grim -o "$ACTIVE_OUTPUT" - | tee "$OUTFILE" | wl-copy
    ;;
  *)
    usage
    ;;
esac
