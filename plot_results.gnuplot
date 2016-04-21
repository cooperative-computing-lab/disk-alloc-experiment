
set terminal postscript eps size 2.5,1.5 font 'Helvetica,12'

set yrange [0:]
set ytics nomirror

set datafile missing "?"

set key off

set boxwidth .5

set ylabel "MB/s"
set xtics ("native" -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10) rotate by 0
set xrange [-2:10.5]
set xlabel "Nest Depth"
set title "Write"
set output "write_ext4_2GB.eps"
#set multiplot
plot "out_final_ext4_2GB.dat" using ($3 + $6 ):(($8/1000)/$9):($10):(.5) with boxerrorbars
#set style fill solid 0.33
#plot "out_final_ext4_4GB.dat" using ($3 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars
#set style fill solid 0.66
#plot "out_final_ext4_8GB.dat" using ($3 + $6 + 0.5):(($8/1000)/$9):($10):(.5) with boxerrorbars
#unset multiplot

set title "Read"
set output "read_ext4_2GB.eps"
plot "out_final_ext4_2GB.dat" using ($2 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Metadata"
set output "meta_ext4_2GB.eps"
set ylabel "Files/s"
plot "out_final_ext4_2GB.dat" using ($4 + $6):($7 / $9):($7 * $10):(.5) with boxerrorbars

set ylabel "MB/s"
set title "Write"
set output "write_ext4_4GB.eps"
plot "out_final_ext4_4GB.dat" using ($3 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Read"
set output "read_ext4_4GB.eps"
plot "out_final_ext4_4GB.dat" using ($2 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Metadata"
set output "meta_ext4_4GB.eps"
set ylabel "Files/s"
plot "out_final_ext4_4GB.dat" using ($4 + $6):($7 / $9):($7 * $10):(.5) with boxerrorbars

set ylabel "MB/s"
set title "Write"
set output "write_ext4_8GB.eps"
plot "out_final_ext4_8GB.dat" using ($3 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Read"
set output "read_ext4_8GB.eps"
plot "out_final_ext4_8GB.dat" using ($2 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Metadata"
set output "meta_ext4_8GB.eps"
set ylabel "Files/s"
plot "out_final_ext4_8GB.dat" using ($4 + $6):($7 / $9):($7 * $10):(.5) with boxerrorbars



set ylabel "MB/s"
set title "Write"
set output "write_ext3_2GB.eps"
#set multiplot
plot "out_final_ext3_2GB.dat" using ($3 + $6 ):(($8/1000)/$9):($10):(.5) with boxerrorbars
#set style fill solid 0.33
#plot "out_final_ext3_4GB.dat" using ($3 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars
#set style fill solid 0.66
#plot "out_final_ext3_8GB.dat" using ($3 + $6 + 0.5):(($8/1000)/$9):($10):(.5) with boxerrorbars
#unset multiplot

set title "Read"
set output "read_ext3_2GB.eps"
plot "out_final_ext3_2GB.dat" using ($2 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Metadata"
set output "meta_ext3_2GB.eps"
set ylabel "Files/s"
plot "out_final_ext3_2GB.dat" using ($4 + $6):($7 / $9):($7 * $10):(.5) with boxerrorbars

set ylabel "MB/s"
set title "Write"
set output "write_ext3_4GB.eps"
plot "out_final_ext3_4GB.dat" using ($3 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Read"
set output "read_ext3_4GB.eps"
plot "out_final_ext3_4GB.dat" using ($2 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Metadata"
set output "meta_ext3_4GB.eps"
set ylabel "Files/s"
plot "out_final_ext3_4GB.dat" using ($4 + $6):($7 / $9):($7 * $10):(.5) with boxerrorbars

set ylabel "MB/s"
set title "Write"
set output "write_ext3_8GB.eps"
plot "out_final_ext3_8GB.dat" using ($3 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Read"
set output "read_ext3_8GB.eps"
plot "out_final_ext3_8GB.dat" using ($2 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Metadata"
set output "meta_ext3_8GB.eps"
set ylabel "Files/s"
plot "out_final_ext3_8GB.dat" using ($4 + $6):($7 / $9):($7 * $10):(.5) with boxerrorbars



set ylabel "MB/s"
set title "Write"
set output "write_ext2_2GB.eps"
#set multiplot
plot "out_final_ext2_2GB.dat" using ($3 + $6 ):(($8/1000)/$9):($10):(.5) with boxerrorbars
#set style fill solid 0.33
#plot "out_final_ext2_4GB.dat" using ($3 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars
#set style fill solid 0.66
#plot "out_final_ext2_8GB.dat" using ($3 + $6 + 0.5):(($8/1000)/$9):($10):(.5) with boxerrorbars
#unset multiplot

set title "Read"
set output "read_ext2_2GB.eps"
plot "out_final_ext2_2GB.dat" using ($2 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Metadata"
set output "meta_ext2_2GB.eps"
set ylabel "Files/s"
plot "out_final_ext2_2GB.dat" using ($4 + $6):($7 / $9):($7 * $10):(.5) with boxerrorbars

set ylabel "MB/s"
set title "Write"
set output "write_ext2_4GB.eps"
plot "out_final_ext2_4GB.dat" using ($3 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Read"
set output "read_ext2_4GB.eps"
plot "out_final_ext2_4GB.dat" using ($2 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Metadata"
set output "meta_ext2_4GB.eps"
set ylabel "Files/s"
plot "out_final_ext2_4GB.dat" using ($4 + $6):($7 / $9):($7 * $10):(.5) with boxerrorbars

set ylabel "MB/s"
set title "Write"
set output "write_ext2_8GB.eps"
plot "out_final_ext2_8GB.dat" using ($3 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Read"
set output "read_ext2_8GB.eps"
plot "out_final_ext2_8GB.dat" using ($2 + $6):(($8/1000)/$9):($10):(.5) with boxerrorbars

set title "Metadata"
set output "meta_ext2_8GB.eps"
set ylabel "Files/s"
plot "out_final_ext2_8GB.dat" using ($4 + $6):($7 / $9):($7 * $10):(.5) with boxerrorbars

