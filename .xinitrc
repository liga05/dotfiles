#!/bin/sh

sxhkd &
yabar &
xcompmgr &
xset r rate 340 50 &
exec bspwm
