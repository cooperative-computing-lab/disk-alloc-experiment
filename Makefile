CC=gcc
CFLAGS=-Wall -g
AR=ar
DTTOOLS = ./cctools-source/dttools/src
LDDFLAGS = -L./cctools-source/dttools/src -ldttools -lm
REPO = cooperative-computing-lab/cctools
COMMIT = cdeec57e41d3e5485987717402cdfb4393dfe8e4 
#dc3cdf8329daae7c5db9da938ecb025c129bf10f

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

PERF_MID_GRAPHS = \
	./meta_ext2_2GB.eps \
	./meta_ext2_4GB.eps \
	./meta_ext2_8GB.eps \
	./meta_ext3_2GB.eps \
	./meta_ext3_4GB.eps \
	./meta_ext3_8GB.eps \
	./meta_ext4_2GB.eps \
	./meta_ext4_4GB.eps \
	./meta_ext4_8GB.eps \
	./read_ext2_2GB.eps \
	./read_ext2_4GB.eps \
	./read_ext2_8GB.eps \
	./read_ext3_2GB.eps \
	./read_ext3_4GB.eps \
	./read_ext3_8GB.eps \
	./read_ext4_2GB.eps \
	./read_ext4_4GB.eps \
	./read_ext4_8GB.eps \
	./write_ext2_2GB.eps \
	./write_ext2_4GB.eps \
	./write_ext2_8GB.eps \
	./write_ext3_2GB.eps \
	./write_ext3_4GB.eps \
	./write_ext3_8GB.eps \
	./write_ext4_2GB.eps \
	./write_ext4_4GB.eps \
	./write_ext4_8GB.eps

META_MID_GRAPHS = \
	./create_ext2.eps \
	./create_ext3.eps \
	./create_ext4.eps \
	./delete_ext2.eps \
	./delete_ext3.eps \
	./delete_ext4.eps

MID_GRAPHS = \
	$(PERF_MID_GRAPHS) \
	$(META_MID_GRAPHS)

PERF_MID_DATA = \
	./out_final_ext2.dat \
	./out_final_ext3.dat \
	./out_final_ext4.dat

META_MID_DATA = \
	./out_empty_final_ext2.dat \
	./out_empty_final_ext3.dat \
	./out_empty_final_ext4.dat

MID_DATA = \
	$(PERF_MID_DATA) \
	$(META_MID_DATA)

DATA = \
	$(PERFORMANCE) \
	$(METADATA)

PERFORMANCE = \
	./out_raw_ext2.dat \
	./out_raw_ext3.dat \
	./out_raw_ext4.dat

METADATA = \
	./out_raw_empty_ext2.dat \
	./out_raw_empty_ext3.dat \
	./out_raw_empty_ext4.dat

TEST = ./src/test

PAPER = ./paper.pdf
LIB = ./cctools-source/dttools/src/libdttools.a
PROG = ./src/test
TAR = $(LIB) $(PROG)

all: $(TAR) $(PAPER)

$(LIB):
	git clone git://github.com/$(REPO)
	cd ./cctools && git checkout $(COMMIT)
	mv ./cctools ./cctools-source
	cd ./cctools-source && ./configure && make all
	$(AR) -rv $(LIB) $(SRC)
	ranlib $(LIB)

$(PROG): $(LIB)
	$(CC) $(CFLAGS) ./src/test.c -I $(DTTOOLS) $(LDDFLAGS) -o $@

out_raw_ext4.dat: $(PROG)
	$(PROG) ext4 0
	mv ./out_raw.dat ./out_raw_ext4.dat

out_raw_ext3.dat: $(PROG)
	$(PROG) ext3 0
	mv ./out_raw.dat ./out_raw_ext3.dat

out_raw_ext2.dat: $(PROG)
	$(PROG) ext2 0
	mv ./out_raw.dat ./out_raw_ext2.dat

out_raw_empty_ext4.dat: $(PROG)
	$(PROG) ext4 1
	mv ./out_raw_empty.dat ./out_raw_empty_ext4.dat

out_raw_empty_ext3.dat: $(PROG)
	$(PROG) ext3 1
	mv ./out_raw_empty.dat ./out_raw_empty_ext3.dat

out_raw_empty_ext2.dat: $(PROG)
	$(PROG) ext2 1
	mv ./out_raw_empty.dat ./out_raw_empty_ext2.dat

$(PERF_MID_DATA): $(PERFORMANCE)
	perl ./generate_graph_data ./out_raw_ext4.dat ./out_final_ext4
	perl ./generate_graph_data ./out_raw_ext3.dat ./out_final_ext3
	perl ./generate_graph_data ./out_raw_ext2.dat ./out_final_ext2

$(META_MID_DATA): $(METADATA)
	perl ./generate_alloc_graph_data.pl ./out_raw_empty_ext4.dat ./out_empty_final_ext4
	perl ./generate_alloc_graph_data.pl ./out_raw_empty_ext3.dat ./out_empty_final_ext3
	perl ./generate_alloc_graph_data.pl ./out_raw_empty_ext2.dat ./out_empty_final_ext2

$(MID_GRAPHS): $(MID_DATA) 
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

source: $(TEST)

performance: $(PERFORMANCE)

metadata: $(METADATA)

clean celan:
	rm -rf $(OBJ) $(TAR) $(MID_DATA) $(MID_GRAPHS) $(DATA) $(GRAPHS) ./*.dat ./*.eps ./*.pdf ./paper.aux ./paper.log ./cctools-source ./cctools

lean:
	rm -rf ./*.pdf ./*.eps ./out_*final*.dat

.PHONY: all small clean lean celan

# vim: set noexpandtab tabstop=4:
