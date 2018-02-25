#!/bin/bash

alter_scroll_value() {
   # which dimension are we updating
   DimScrollDelta="$1"

   # Dimensional natural scrolling
   # ----------------------------
   dim_scroll_delta=`synclient | grep $DimScrollDelta`

   dim_scroll_delta_value_count=`echo $dim_scroll_delta | grep -oP '[0-9]+' | wc -l`

   # proceed only if there is single value
   if [[ 1 -eq "$dim_scroll_delta_value_count" ]]; then
      dim_scroll_delta_value=`echo $dim_scroll_delta | grep -oP '[0-9]+'`

      # use negation of that value as new value
      #echo Setting new value to "$DimScrollDelta=-$dim_scroll_delta_value"
      synclient "$DimScrollDelta=-$dim_scroll_delta_value"
   fi
}

# check if synclient is installed
which synclient &> /dev/null
synclient_exists="$?"

if [[ 0 -eq "$synclient_exists" ]]; then

   # Vertical natural scrolling
   # --------------------------
   alter_scroll_value VertScrollDelta

   # Horizontal natural scrolling
   # ----------------------------
   alter_scroll_value HorizScrollDelta

fi
