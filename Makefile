CC=gcc
CFLAGS=-Wall -g -lm
AR=ar
DTTOOLS = ./cctools-source/dttools/src

OBJ = \
	./src/test.o \
	./src/disk_alloc.o \
	./src/stringtools.o \
	./src/path.o \
	./src/xxmalloc.o

SRC = \
	./cctools-source/dttools/src/disk_alloc.o \
	./cctools-source/dttools/src/stringtools.o \
	./cctools-source/dttools/src/path.o \
	./cctools-source/dttools/src/xxmalloc.o
	
GRAPHS = \
	./meta_ext2_2GB.pdf \
	./meta_ext2_4GB.pdf \
	./meta_ext2_8GB.pdf \
	./meta_ext3_2GB.pdf \
	./meta_ext3_4GB.pdf \
	./meta_ext3_8GB.pdf \
	./meta_ext4_2GB.pdf \
	./meta_ext4_4GB.pdf \
	./meta_ext4_8GB.pdf \
	./read_ext2_2GB.pdf \
	./read_ext2_4GB.pdf \
	./read_ext2_8GB.pdf \
	./read_ext3_2GB.pdf \
	./read_ext3_4GB.pdf \
	./read_ext3_8GB.pdf \
	./read_ext4_2GB.pdf \
	./read_ext4_4GB.pdf \
	./read_ext4_8GB.pdf \
	./write_ext2_2GB.pdf \
	./write_ext2_4GB.pdf \
	./write_ext2_8GB.pdf \
	./write_ext3_2GB.pdf \
	./write_ext3_4GB.pdf \
	./write_ext3_8GB.pdf \
	./write_ext4_2GB.pdf \
	./write_ext4_4GB.pdf \
	./write_ext4_8GB.pdf

MID_GRAPHS = \
	./meta_*.eps \
	./read_*.eps \
	./write_*.eps

MID_DATA = \
	./out_*.dat

DATA = \
	./out_raw_ext2.dat \
	./out_raw_ext3.dat \
	./out_raw_ext4.dat

PAPER = ./paper.pdf
LIB = ./src/libtest.a
#LIB = ./cctools-source/dttools/src/libdttools.a
PROG = ./src/test
TAR = $(LIB) $(PROG)

all: $(PAPER)

$(LIB):
	git clone git@github.com:nkremerh/cctools -b disk_alloc_fix
	mv ./cctools ./cctools-source
	cd ./cctools-source && ./configure && make all
	$(AR) -rv $(LIB) $(SRC)
	ranlib $(LIB)
#	cp $(SRC) ./src/

$(PROG): $(LIB)
	$(CC) $(CFLAGS) $^ -I $(DTTOOLS) ./src/test.c -o $@

$(DATA): $(PROG)
	sudo $(PROG) ext4
	mv ./out.dat ./out_ext4.dat
	mv ./out_raw.dat ./out_raw_ext4.dat
	mv ./out_empty.dat ./out_empty_ext4.dat
	mv ./out_raw_empty.dat ./out_raw_empty_ext4.dat
	sudo $(PROG) ext3
	mv ./out.dat ./out_ext3.dat
	mv ./out_raw.dat ./out_raw_ext3.dat
	mv ./out_empty.dat ./out_empty_ext3.dat
	mv ./out_raw_empty.dat ./out_raw_empty_ext3.dat
	sudo $(PROG) ext2
	mv ./out.dat ./out_ext2.dat
	mv ./out_raw.dat ./out_raw_ext2.dat
	mv ./out_empty.dat ./out_empty_ext2.dat
	mv ./out_raw_empty.dat ./out_raw_empty_ext2.dat

#$(LIB):
	

$(MID_GRAPHS): $(DATA)
	perl ./generate_graph_data ./out_raw_ext4.dat ./out_final_ext4
	perl ./generate_graph_data ./out_raw_ext3.dat ./out_final_ext3
	perl ./generate_graph_data ./out_raw_ext2.dat ./out_final_ext2
	gnuplot ./plot_results.gnuplot 

%.pdf: %.eps
	epstopdf $< --outfile=$@

$(PAPER): ./paper.tex $(GRAPHS)
	pdflatex ./paper.tex

paper: $(PAPER)

graphs: $(GRAPHS)

mid_graphs: $(MID_GRAPHS)

build: $(LIB) $(PROG)

test: $(DATA)

clean lean celan:
	rm -rf $(OBJ) $(TAR) $(MID_DATA) $(MID_GRAPHS) $(GRAPHS) ./paper.aux ./paper.log ./cctools-source ./cctools

.PHONY: all small clean lean celan

# vim: set noexpandtab tabstop=4:
