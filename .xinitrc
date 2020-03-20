#!/bin/sh

hsetroot -fill ~/.config/wall.jpg &
(sleep 1 && xcompmgr) &
sxhkd &
remaps &
exec bspwm
