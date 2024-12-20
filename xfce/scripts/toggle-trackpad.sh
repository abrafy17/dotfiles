#!/bin/bash

DEVICE="SynPS/2 Synaptics TouchPad"
STATUS=$(xinput list-props "$DEVICE" | grep "Device Enabled" | awk '{print $4}')

if [ "$STATUS" -eq 1 ]; then
    xinput disable "$DEVICE"
    notify-send "Trackpad Disable"
else
    xinput enable "$DEVICE"
    notify-send "Trackpad Enabled"m
fi