#!/bin/bash
#http://www.famzah.net/rrdwizard/rrdcreate.php?

rrdtool create filename.rrd --step '900' 'DS:BASIC:GAUGE:1350:U:U' 'DS:DETAILS:GAUGE:9000:U:U' 'RRA:AVERAGE:0.5:1:900' 'RRA:AVERAGE:0.5:10:300' 'RRA:AVERAGE:0.5:15:600' 'RRA:AVERAGE:0.5:50:1000' 'RRA:AVERAGE:0.5:200:4380'
