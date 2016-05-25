
set terminal postscript eps size 2.5,1.5 font 'Helvetica,12'

set yrange [0:]
set ytics nomirror

set datafile missing "?"

set key off

set boxwidth .5


set ylabel "Time (s)"
set title "Creation"
set output "create_ext2.eps"
set xtics rotate by -45
#set xrange [-.5:14.5]
set xlabel "Size"
plot "out_empty_final_ext2.dat" using (log($4)):($5 + $2):($6):(.5):xtic(1) with boxerrorbars

set title "Deletion"
set output "delete_ext2.eps"
plot "out_empty_final_ext2.dat" using (log($4)):($5 + $3):($6):(.5):xtic(1) with boxerrorbars

set title "Creation"
set output "create_ext3.eps"
plot "out_empty_final_ext3.dat" using 0:($5 + $2):($6):(.5):xtic(1) with boxerrorbars

set title "Deletion"
set output "delete_ext3.eps"
plot "out_empty_final_ext3.dat" using 0:($5 + $3):($6):(.5):xtic(1) with boxerrorbars

set title "Creation"
set output "create_ext4.eps"
plot "out_empty_final_ext4.dat" using 0:($5 + $2):($6):(.5):xtic(1) with boxerrorbars

set title "Deletion"
set output "delete_ext4.eps"
plot "out_empty_final_ext4.dat" using 0:($5 + $3):($6):(.5):xtic(1) with boxerrorbars




set ylabel "MB/s"
set xtics ("native" -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10) rotate by 0
set xrange [-2:10.5]
set xlabel "Nest Depth"
set title "Write"
set output "write_ext4_2GB.eps"
plot "out_final_ext4_2GB.dat" using ($3 + $6 ):(($8/1000)/$9):($10):(.5) with boxerrorbars

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

