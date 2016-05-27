CC=gcc
CFLAGS=-Wall -g
AR=ar
DTTOOLS = ./cctools_source/dttools/src
LDDFLAGS = -L./cctools_source/dttools/src -ldttools -lm
REPO = cooperative-computing-lab/cctools
COMMIT = 5b6e84351d5667e11d4c58778a7acc6ef965d862 
#dc3cdf8329daae7c5db9da938ecb025c129bf10f

GRAPHS = ./meta_ext2_2GB.pdf ./meta_ext2_4GB.pdf ./meta_ext2_8GB.pdf \
	./meta_ext3_2GB.pdf ./meta_ext3_4GB.pdf ./meta_ext3_8GB.pdf \
	./meta_ext4_2GB.pdf ./meta_ext4_4GB.pdf ./meta_ext4_8GB.pdf \
	./read_ext2_2GB.pdf ./read_ext2_4GB.pdf ./read_ext2_8GB.pdf \
	./read_ext3_2GB.pdf ./read_ext3_4GB.pdf ./read_ext3_8GB.pdf \
	./read_ext4_2GB.pdf ./read_ext4_4GB.pdf ./read_ext4_8GB.pdf \
	./write_ext2_2GB.pdf ./write_ext2_4GB.pdf ./write_ext2_8GB.pdf \
	./write_ext3_2GB.pdf ./write_ext3_4GB.pdf ./write_ext3_8GB.pdf \
	./write_ext4_2GB.pdf ./write_ext4_4GB.pdf ./write_ext4_8GB.pdf \
	./create_ext2.pdf ./create_ext3.pdf ./create_ext4.pdf \
	./delete_ext2.pdf ./delete_ext3.pdf ./delete_ext4.pdf

PERF_MID_GRAPHS = ./meta_ext2_2GB.eps ./meta_ext2_4GB.eps ./meta_ext2_8GB.eps \
	./meta_ext3_2GB.eps ./meta_ext3_4GB.eps ./meta_ext3_8GB.eps \
	./meta_ext4_2GB.eps ./meta_ext4_4GB.eps ./meta_ext4_8GB.eps \
	./read_ext2_2GB.eps ./read_ext2_4GB.eps ./read_ext2_8GB.eps \
	./read_ext3_2GB.eps ./read_ext3_4GB.eps ./read_ext3_8GB.eps \
	./read_ext4_2GB.eps ./read_ext4_4GB.eps ./read_ext4_8GB.eps \
	./write_ext2_2GB.eps ./write_ext2_4GB.eps ./write_ext2_8GB.eps \
	./write_ext3_2GB.eps ./write_ext3_4GB.eps ./write_ext3_8GB.eps \
	./write_ext4_2GB.eps ./write_ext4_4GB.eps ./write_ext4_8GB.eps

OVER_MID_GRAPHS = ./create_ext2.eps \
	./create_ext3.eps ./create_ext4.eps \
	./delete_ext2.eps ./delete_ext3.eps \
	./delete_ext4.eps

MID_GRAPHS = \
	$(PERF_MID_GRAPHS) \
	$(OVER_MID_GRAPHS)

PERF_MID_DATA = ./out_final_ext2_2GB.dat ./out_final_ext2_4GB.dat ./out_final_ext2_8GB.dat \
	./out_final_ext3_2GB.dat ./out_final_ext3_4GB.dat ./out_final_ext3_8GB.dat \
	./out_final_ext4_2GB.dat ./out_final_ext4_4GB.dat ./out_final_ext4_8GB.dat

OVER_MID_DATA = ./out_empty_final_ext2.dat \
	./out_empty_final_ext3.dat ./out_empty_final_ext4.dat

MID_DATA = \
	$(PERF_MID_DATA) \
	$(OVER_MID_DATA)

DATA = \
	$(PERFORMANCE) \
	$(OVERHEAD)

PERFORMANCE = ./out_raw_ext2.dat \
	./out_raw_ext3.dat ./out_raw_ext4.dat

OVERHEAD = ./out_raw_empty_ext2.dat \
	./out_raw_empty_ext3.dat ./out_raw_empty_ext4.dat

#Previous results gathered from original test platform
PREV_GRAPHS = ./previous_results/meta_ext2_2GB.pdf ./previous_results/meta_ext2_4GB.pdf ./previous_results/meta_ext2_8GB.pdf \
	./previous_results/meta_ext3_2GB.pdf ./previous_results/meta_ext3_4GB.pdf ./previous_results/meta_ext3_8GB.pdf \
	./previous_results/meta_ext4_2GB.pdf ./previous_results/meta_ext4_4GB.pdf ./previous_results/meta_ext4_8GB.pdf \
	./previous_results/read_ext2_2GB.pdf ./previous_results/read_ext2_4GB.pdf ./previous_results/read_ext2_8GB.pdf \
	./previous_results/read_ext3_2GB.pdf ./previous_results/read_ext3_4GB.pdf ./previous_results/read_ext3_8GB.pdf \
	./previous_results/read_ext4_2GB.pdf ./previous_results/read_ext4_4GB.pdf ./previous_results/read_ext4_8GB.pdf \
	./previous_results/write_ext2_2GB.pdf ./previous_results/write_ext2_4GB.pdf ./previous_results/write_ext2_8GB.pdf \
	./previous_results/write_ext3_2GB.pdf ./previous_results/write_ext3_4GB.pdf ./previous_results/write_ext3_8GB.pdf \
	./previous_results/write_ext4_2GB.pdf ./previous_results/write_ext4_4GB.pdf ./previous_results/write_ext4_8GB.pdf \
	./previous_results/create_ext2.pdf ./previous_results/create_ext3.pdf ./previous_results/create_ext4.pdf \
	./previous_results/delete_ext2.pdf ./previous_results/delete_ext3.pdf ./previous_results/delete_ext4.pdf

PREV_PERF_MID_GRAPHS = ./previous_results/meta_ext2_2GB.eps ./previous_results/meta_ext2_4GB.eps ./previous_results/meta_ext2_8GB.eps \
	./previous_results/meta_ext3_2GB.eps ./previous_results/meta_ext3_4GB.eps ./previous_results/meta_ext3_8GB.eps \
	./previous_results/meta_ext4_2GB.eps ./previous_results/meta_ext4_4GB.eps ./previous_results/meta_ext4_8GB.eps \
	./previous_results/read_ext2_2GB.eps ./previous_results/read_ext2_4GB.eps ./previous_results/read_ext2_8GB.eps \
	./previous_results/read_ext3_2GB.eps ./previous_results/read_ext3_4GB.eps ./previous_results/read_ext3_8GB.eps \
	./previous_results/read_ext4_2GB.eps ./previous_results/read_ext4_4GB.eps ./previous_results/read_ext4_8GB.eps \
	./previous_results/write_ext2_2GB.eps ./previous_results/write_ext2_4GB.eps ./previous_results/write_ext2_8GB.eps \
	./previous_results/write_ext3_2GB.eps ./previous_results/write_ext3_4GB.eps ./previous_results/write_ext3_8GB.eps \
	./previous_results/write_ext4_2GB.eps ./previous_results/write_ext4_4GB.eps ./previous_results/write_ext4_8GB.eps

PREV_OVER_MID_GRAPHS = ./previous_results/create_ext2.eps \
	./previous_results/create_ext3.eps ./previous_results/create_ext4.eps \
	./previous_results/delete_ext2.eps ./previous_results/delete_ext3.eps \
	./previous_results/delete_ext4.eps

PREV_MID_GRAPHS = \
	$(PREV_PERF_MID_GRAPHS) \
	$(PREV_OVER_MID_GRAPHS)

PREV_PERF_MID_DATA = ./previous_results/out_final_ext2_2GB.dat ./previous_results/out_final_ext2_4GB.dat ./previous_results/out_final_ext2_8GB.dat \
	./previous_results/out_final_ext3_2GB.dat ./previous_results/out_final_ext3_4GB.dat ./previous_results/out_final_ext3_8GB.dat \
	./previous_results/out_final_ext4_2GB.dat ./previous_results/out_final_ext4_4GB.dat ./previous_results/out_final_ext4_8GB.dat 

PREV_OVER_MID_DATA = ./previous_results/out_empty_final_ext2.dat \
	./previous_results/out_empty_final_ext3.dat ./previous_results/out_empty_final_ext4.dat

PREV_MID_DATA = \
	$(PREV_PERF_MID_DATA) \
	$(PREV_OVER_MID_DATA)

PREV_DATA = \
	$(PREV_PERFORMANCE) \
	$(PREV_OVERHEAD)

PREV_PERFORMANCE = ./previous_results/out_raw_ext2.dat \
	./previous_results/out_raw_ext3.dat ./previous_results/out_raw_ext4.dat

PREV_OVERHEAD = ./previous_results/out_raw_empty_ext2.dat \
	./previous_results/out_raw_empty_ext3.dat ./previous_results/out_raw_empty_ext4.dat

MISC_FILES = ./previous_results/out.txt \
	./paper.out ./paper.aux ./paper.log

TEST = ./src/test

PAPER = ./paper.pdf
LIB = ./cctools_source/dttools/src/libdttools.a
PROG = ./src/benchmark
CCTOOLS = ./cctools_source
TAR = $(LIB) $(PROG)

all: $(GRAPHS) $(PAPER)

$(CCTOOLS):
	git clone git://github.com/$(REPO)
	cd ./cctools && git checkout $(COMMIT)
	mv ./cctools ./cctools_source
	cd ./cctools_source && ./configure && make all

$(LIB): $(CCTOOLS)
	$(AR) -rv $(LIB) $(SRC)
	ranlib $(LIB)

$(PROG): $(LIB)
	$(CC) $(CFLAGS) ./src/benchmark.c -I $(DTTOOLS) $(LDDFLAGS) -o $@

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
	perl ./generate_graph_data.pl ./out_raw_ext4.dat ./out_final_ext4
	perl ./generate_graph_data.pl ./out_raw_ext3.dat ./out_final_ext3
	perl ./generate_graph_data.pl ./out_raw_ext2.dat ./out_final_ext2

$(OVER_MID_DATA): $(OVERHEAD)
	perl ./generate_alloc_graph_data.pl ./out_raw_empty_ext4.dat ./out_empty_final_ext4
	perl ./generate_alloc_graph_data.pl ./out_raw_empty_ext3.dat ./out_empty_final_ext3
	perl ./generate_alloc_graph_data.pl ./out_raw_empty_ext2.dat ./out_empty_final_ext2

$(MID_GRAPHS): $(MID_DATA) 
	gnuplot ./plot_results.gnuplot

$(PREV_PERF_MID_DATA): $(PREV_PERFORMANCE)
	perl ./generate_graph_data.pl ./previous_results/out_raw_ext4.dat ./previous_results/out_final_ext4
	perl ./generate_graph_data.pl ./previous_results/out_raw_ext3.dat ./previous_results/out_final_ext3
	perl ./generate_graph_data.pl ./previous_results/out_raw_ext2.dat ./previous_results/out_final_ext2

$(PREV_OVER_MID_DATA): $(PREV_OVERHEAD)
	perl ./generate_alloc_graph_data.pl ./previous_results/out_raw_empty_ext4.dat ./previous_results/out_empty_final_ext4
	perl ./generate_alloc_graph_data.pl ./previous_results/out_raw_empty_ext3.dat ./previous_results/out_empty_final_ext3
	perl ./generate_alloc_graph_data.pl ./previous_results/out_raw_empty_ext2.dat ./previous_results/out_empty_final_ext2

./out.txt: $(PREV_MID_DATA) 
	cd ./previous_results && gnuplot ./plot_results.gnuplot > ./out.txt

$(PREV_MID_GRAPHS): ./out.txt

%.pdf: %.eps
	epstopdf $< --outfile=$@

$(PAPER): ./paper.tex $(PREV_GRAPHS)
	pdflatex ./paper.tex

paper: $(PAPER)

graphs: $(GRAPHS)

mid_graphs: $(MID_GRAPHS)

build: $(LIB) $(PROG)

benchmark: $(DATA)

source: $(TEST)

performance: $(PERFORMANCE)

overhead: $(OVERHEAD)

clean celan:
	rm -rf $(OBJ) $(TAR) $(MID_DATA) $(MID_GRAPHS) $(DATA) $(GRAPHS) $(PREV_PERF_MID_DATA) $(PREV_OVER_MID_DATA) $(PREV_MID_GRAPHS) $(PREV_GRAPHS) $(MISC_FILES) ./cctools_source ./cctools

lean:
	rm -rf $(MID_GRAPHS) $(GRAPHS) $(PREV_MID_GRAPHS) $(PREV_GRAPHS) $(PAPER) $(MISC_FILES)

.PHONY: all small clean lean celan

# vim: set noexpandtab tabstop=4:
