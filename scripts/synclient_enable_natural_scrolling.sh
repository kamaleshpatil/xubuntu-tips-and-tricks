#!/bin/bash

# check if synclient is installed
which synclient &> /dev/null
synclient_exists="$?"

if [[ 0 -eq "$synclient_exists" ]]; then
   vert_scroll_delta=`synclient | grep VertScrollDelta`

   vert_scroll_delta_value_count=`echo $vert_scroll_delta | grep -oP '[0-9]+' | wc -l`

   # proceed only if there is single value
   if [[ 1 -eq "$vert_scroll_delta_value_count" ]]; then
      vert_scroll_delta_value=`echo $vert_scroll_delta | grep -oP '[0-9]+'`

      # use negation of that value as new value
      #echo Setting new value to "VertScrollDelta=-$vert_scroll_delta_value"
      synclient "VertScrollDelta=-$vert_scroll_delta_value"
   fi
fi
