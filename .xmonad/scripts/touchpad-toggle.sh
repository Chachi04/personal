#!/bin/bash
xinput list-props "ELAN1200:00 04F3:3090 Touchpad" \
    | grep -qE "Device Enabled.*1$" \
    && xinput --set-prop "ELAN1200:00 04F3:3090 Touchpad" "Device Enabled" 0 \
    || xinput --set-prop "ELAN1200:00 04F3:3090 Touchpad" "Device Enabled" 1

