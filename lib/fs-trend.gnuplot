
set xdata time
# set timefmt "%H:%M:%S"
# set xrange ["14:43:20":"15:43:20"]
set timefmt "%s"
set xrange ["1211550201":"1211561235"]
set format x "%T"
set yrange [0:]
#set format y "%T"

plot '/tmp/var.du' using 1:4 with linespoints

pause -1
