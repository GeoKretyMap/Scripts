#!/bin/bash

cd ~/rrd

function graph {
    period=$1
    
    rrdtool graph --end now --start end-${period} --width 800 updates-${period}.png \
        DEF:basic=$HOME/rrd/filename.rrd:BASIC:AVERAGE \
        DEF:details=$HOME/rrd/filename.rrd:DETAILS:AVERAGE \
            VDEF:ds0max=basic,MAXIMUM \
            VDEF:ds0avg=basic,AVERAGE \
            VDEF:ds0min=basic,MINIMUM \
            VDEF:ds0pct=basic,95,PERCENT \
            VDEF:ds1max=details,MAXIMUM \
            VDEF:ds1avg=details,AVERAGE \
            VDEF:ds1min=details,MINIMUM \
            VDEF:ds1pct=details,95,PERCENT \
            COMMENT:"           " \
            COMMENT:"Maximum    " \
            COMMENT:"Average    " \
            COMMENT:"Minimum    " \
            COMMENT:"95th percentile\l" \
            LINE2:basic#0000ff:"basic     " \
            GPRINT:ds0max:"%6.2lf %SGK" \
            GPRINT:ds0avg:"%6.2lf %SGK" \
            GPRINT:ds0min:"%6.2lf %SGK" \
            GPRINT:ds0pct:"%6.2lf %SGK\l" \
            LINE1:details#ff0000:"details   " \
            GPRINT:ds1max:"%6.2lf %SGK" \
            GPRINT:ds1avg:"%6.2lf %SGK" \
            GPRINT:ds1min:"%6.2lf %SGK" \
            GPRINT:ds1pct:"%6.2lf %SGK\l"
}

graph "1h"
graph "1d"
graph "1m"
graph "1y"
