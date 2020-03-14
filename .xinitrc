#!/bin/sh

sxhkd &
yabar &
hsetroot -solid "#000000" &
(sleep 1 && xcompmgr) &
remaps &
exec bspwm
