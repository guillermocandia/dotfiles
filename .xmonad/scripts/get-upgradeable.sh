#!/bin/bash

icon=""
color="cyan"
icon_color="yellow"

upgradeable=$(apt-get -q -y --ignore-hold --allow-change-held-packages --allow-unauthenticated -s dist-upgrade | grep ^Inst | wc -l)

echo "<fc=$icon_color><fn=1>$icon</fn></fc><fc=$color>  $upgradeable</fc>"
