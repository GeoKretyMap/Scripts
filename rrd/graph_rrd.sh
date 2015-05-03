#!/bin/bash

cd ~/rrd

rrdtool graph --end now --start end-1h --width 800 updates-1h.png \
	DEF:basic=$HOME/rrd/filename.rrd:BASIC:AVERAGE \
	DEF:details=$HOME/rrd/filename.rrd:DETAILS:AVERAGE \
	LINE2:basic#0000ff:"basic" \
	LINE1:details#ff0000:"details"

rrdtool graph --end now --start end-1d --width 800 updates-1d.png \
	DEF:basic=$HOME/rrd/filename.rrd:BASIC:AVERAGE \
	DEF:details=$HOME/rrd/filename.rrd:DETAILS:AVERAGE \
	LINE2:basic#0000ff:"basic" \
	LINE1:details#ff0000:"details"

rrdtool graph --end now --start end-1m --width 800 updates-1m.png \
	DEF:basic=$HOME/rrd/filename.rrd:BASIC:AVERAGE \
	DEF:details=$HOME/rrd/filename.rrd:DETAILS:AVERAGE \
	LINE2:basic#0000ff:"basic" \
	LINE1:details#ff0000:"details"

rrdtool graph --end now --start end-1y --width 800 updates-1y.png \
	DEF:basic=$HOME/rrd/filename.rrd:BASIC:AVERAGE \
	DEF:details=$HOME/rrd/filename.rrd:DETAILS:AVERAGE \
	LINE2:basic#0000ff:"basic" \
	LINE1:details#ff0000:"details"

