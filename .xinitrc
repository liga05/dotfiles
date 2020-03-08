#!/bin/sh

sxhkd &
yabar &
hsetroot -solid "#000000"
(sleep 1 && xcompmgr) &
xset r rate 340 50 &
exec bspwm
