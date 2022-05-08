#!/opt/homebrew/bin/gnuplot --persist

set terminal png size 1600,900 enhanced font "Helvetica,20"
set output 'remote-numa-image.jpg'
set title "Sequential Read" font ",20"
set xlabel "thread number" font ",20"
set ylabel "bandwidth (Gb/s)"
set grid
set style fill solid
#set boxwidth 0.5
#set style data histogram
#set style histogram cluster gap 1
#set key outside below
set termoption dashed
#set autoscale y
#set term pngcairo dashed
set xtics font ",15"
set ytics font ",15"
#set xlabels off 0,-1
#set ylabels off -1,0

#help set xlabel
#set xrange[0:16]
#set yrange[]

red = "#FF0000"; green = "#00FF00"; blue = "#0000FF"; skyblue = "#87CEEB"
#set style line 1 lc rgb '#FF0000' lt 5 dashtype 2 pt 16 pi -1 ps 3
set style line 1 lc rgb '#B8C4E8' linewidth 3 lt 8 pt 7 pi -1 ps 3
set style line 2 lc rgb '#D4D4D4' linewidth 3 lt 2 pt 18 pi -1 ps 3
set style line 3 lc rgb '#0000FF' linewidth 3 lt 1 pt 9 pi -1 ps 3
set style line 4 lc rgb '#87CEEB' linewidth 3 lt 1	 pt 7 pi -1 ps 3
#set style line 1 linewidth 2 pointtype 7 pointsize 1.5 lc rgb "#B8C4E8" # RED
#set style line 2 linewidth 2 pointtype 7 pointsize 1.5 lc rgb "#D4D4D4" # GREEN
#set style line 3 linewidth 2 pointtype 7 pointsize 1.5 lc rgb "#0000FF" # YELLOW
#set style line 4 linewidth 2 pointtype 7 pointsize 1.5 lc rgb "#87CEEB" # BLUE
#set style line 1 lt 2 lc dt 3 rgb "grey" lw 1

#set pointintervalbox 3

# change as you want
set key horizontal at screen 0.5, screen 0.55 reverse center Left spacing 1.2 samplen 3.5 maxcols 2 maxrows 2 font "Times-New-Roman, 25"
#set key horizontal font "Times-New-Roman, 25" width 1.8 at graph 0.4, graph 0.1 center maxrows 1

#set tmargin 0.5
  #set bmargin 4.0
  #set lmargin 6
  #set rmargin 3


set multiplot layout 1,4

set title "Sequential Read"
set size 0.25, 0.5
#set rmargin 1
plot "sequential-read-100" using 2:xtic(1) title "NVDIMM-N" with linespoints ls 1, \
     "sequential-read-100" using 3 title "DCPMM" with linespoints ls 2
	#"sequential-read-0" using 4 title "Random Read" with linespoints ls 3, \
	#"sequential-read-0" using 5 title "Random Write" with linespoints ls 4

unset title
#unset lmargin
set title "Sequential Write"
set size 0.25, 0.5
set nokey
plot "sequential-write-100" using 2:xtic(1) title "NVDIMM-N" with linespoints ls 1, \
     "sequential-write-100" using 3 title "DCPMM" with linespoints ls 2

#set lmargin 4
set title "Random Read"
set size 0.25, 0.5
set nokey
plot "random-read-100" using 2:xtic(1) title "NVDIMM-N" with linespoints ls 1, \
     "random-read-100" using 3 title "DCPMM" with linespoints ls 2


set title "Random Write"
set size 0.25, 0.5
set nokey
plot "random-write-100" using 2:xtic(1) title "NVDIMM-N" with linespoints ls 1, \
     "random-write-100" using 3 title "DCPMM" with linespoints ls 2
unset multiplot
