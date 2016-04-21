#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <inttypes.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <time.h>
#include <errno.h>
#include <math.h>
#include <string.h>

#include "disk_alloc.h"
#include "stringtools.h"

int read_write_test(int64_t kbyte_size, char *size, char *loc, int nest, int iterations) {

	int64_t average_read_time = 0;
	int64_t average_write_time = 0;
	int64_t read_times[iterations];
	int64_t write_times[iterations];
	int64_t test_size = (kbyte_size * 95) / 100;
	int i;
	struct timeval write_wall_start;
	struct timeval read_wall_end;
	struct timeval read_wall_start;
	struct timeval write_wall_end;
	char *io_args;
	int64_t write_wall_time, read_wall_time;
	char *flush = "sync";
	char cwd[FILENAME_MAX];
	getcwd(cwd, sizeof(cwd));
	char *file, *file2;
	file = string_format("%s/out_raw.dat", cwd);
	file2 = string_format("%s/out.dat", cwd);
	FILE *f;
	double avg_read_time, avg_write_time, read_std_dev, write_std_dev, read_acc, write_acc;
	char *read_results = NULL;
	char *write_results = NULL;
	printf("Performing Read/Write test.\n");
	for(i = 0; i < iterations; i++) {	
		system(flush);
		gettimeofday(&write_wall_start, NULL);
		io_args = string_format("dd if=/dev/zero of=%s/temp bs=4K count=%"PRId64"", loc, (test_size / 4));
		system(io_args);
		gettimeofday(&write_wall_end, NULL);
		system(flush);
		write_wall_time = ((1000000 * write_wall_end.tv_sec) + write_wall_end.tv_usec) - ((1000000 * write_wall_start.tv_sec) + write_wall_start.tv_usec);
		gettimeofday(&read_wall_start, NULL);
		free(io_args);
		io_args = string_format("echo 3 > /proc/sys/vm/drop_caches;dd if=%s/temp of=/dev/null bs=4k", loc);
		system(io_args);
		gettimeofday(&read_wall_end, NULL);
		system(flush);
		free(io_args);
		io_args = string_format("echo 0 > /proc/sys/vm/drop_caches;rm %s/temp", loc);
		system(io_args);
		free(io_args);
		read_wall_time =((1000000 * read_wall_end.tv_sec) + read_wall_end.tv_usec) - ((1000000 * read_wall_start.tv_sec) + read_wall_start.tv_usec);

		read_results = string_format("%s 0 ? ? ? %d ? %"PRId64" %"PRId64"\n", size, nest, test_size, read_wall_time);
		write_results = string_format("%s ? 0 ? ? %d ? %"PRId64" %"PRId64"\n", size, nest, test_size, write_wall_time);

		//Acknowledge wild outliers
		/*
		if(i > 0 && (read_wall_time >= (read_times[i-1] * 10))) {
			printf("Found outlier greater than or equal to one order of magnitude of previous test.\n");
			f = fopen(file3, "a");
			fprintf(f, read_results);
			fclose(f);
		}
		else if(i > 0 && (write_wall_time >= (write_times[i-1] * 10))) {
			printf("Found outlier greater than or equal to one order of magnitude of previous test.\n");
			f = fopen(file3, "a");
			fprintf(f, write_results);
			fclose(f);
		}*/
		average_read_time += read_wall_time;
		average_write_time += write_wall_time;
		read_times[i] = read_wall_time;
		write_times[i] = write_wall_time;

		if(read_results && write_results) {
			f = fopen(file, "a");	
			if(f == NULL) {
				printf("File %s could not be opened during read/write testing. Printing test results for manual entry into %s.\n%s%s", file, file, read_results, write_results);
				free(read_results);
				free(write_results);
				free(file);
				fprintf(stderr, "Read/Write test errno %d: %s\n", errno, strerror(errno));
				return 1;
			}
			fprintf(f, read_results);
			fprintf(f, write_results);
			fclose(f);
			free(read_results);
			free(write_results);
			}
		else {
			printf("Read/Write results could not be calculated. Current test aborted.\n");
			free(file);
			return 1;
		}
	}

	//Mean and standard deviation calculations and write
	avg_read_time = average_read_time / (iterations * 1.0);
	avg_write_time = average_write_time / (iterations * 1.0);
	read_acc = 0; 
	write_acc = 0;
	for(i = 0; i < iterations; i++) {
		read_acc += pow((read_times[i] - avg_read_time), 2);
		write_acc += pow((write_times[i] - avg_write_time), 2);
	}
	read_acc = read_acc / iterations;
	write_acc = write_acc / iterations;
	read_std_dev = sqrt(read_acc);
	write_std_dev = sqrt(write_acc);
	read_std_dev = read_std_dev / 1000000;
	write_std_dev = write_std_dev / 1000000;
	avg_read_time = avg_read_time / 1000000;
	avg_write_time = avg_write_time / 1000000;
	read_results = string_format("%s 0 ? ? ? %d ? %"PRId64" %f %f\n", size, nest, test_size, avg_read_time, read_std_dev);
	write_results = string_format("%s ? 0 ? ? %d ? %"PRId64" %f %f\n", size, nest, test_size, avg_write_time, write_std_dev);
	if(read_results && write_results) {
		f = fopen(file2, "a");	
		if(f == NULL) {
			printf("File %s could not be opened during read/write testing. Printing test results for manual entry into %s.\n%s%s", file, file, read_results, write_results);
			free(read_results);
			free(write_results);
			free(file2);
			fprintf(stderr, "Read/Write test errno %d: %s\n", errno, strerror(errno));
			return 1;
		}
		fprintf(f, read_results);
		fprintf(f, write_results);
		fclose(f);
		free(read_results);
		free(write_results);
		}
	else {
		printf("Read/Write results could not be calculated. Current test aborted.\n");
		free(file2);
		return 1;
	}
	printf("Read/Write test complete.\nAverage Read Time: %f\nAverage Write time: %f\n", avg_read_time, avg_write_time);
	free(file);
	return 0;
}

int metadata_test(char *size, char *loc, int nest, int iterations) {

	int k, i;
	char cwd[FILENAME_MAX];
	getcwd(cwd, sizeof(cwd));
	char *file, *file2;
	file = string_format("%s/out_raw.dat", cwd);
	file2 = string_format("%s/out.dat", cwd);
	char *temp_file;
	FILE *f;
	struct stat buff;
	int64_t average_time = 0;
	int64_t wall_time;
	int64_t meta_times[iterations];
	struct timeval wall_start;
	struct timeval wall_end;
	double avg_time, meta_acc, meta_std_dev;
	char *meta_results;
	printf("Performing Metadata test.\n");
	for(k = 0; k < iterations; k++) {
		i = 0;
		system("sync;echo 3 > /proc/sys/vm/drop_caches");
		gettimeofday(&wall_start, NULL);
		while(i < 10000) {
			temp_file = string_format("%s/create_%d", loc, i);
			f = fopen(temp_file, "w");
			fclose(f);
			stat(temp_file, &buff);
			free(temp_file);
			i++;
		}
		while(i >= 0) {
			temp_file = string_format("%s/create_%d", loc, i);
			remove(temp_file);
			free(temp_file);
			i--;
		}
		gettimeofday(&wall_end, NULL);
		system("echo 0 > /proc/sys/vm/drop_caches");
		wall_time = ((1000000 * wall_end.tv_sec) + wall_end.tv_usec) - ((1000000 * wall_start.tv_sec) + wall_start.tv_usec);

		meta_results = string_format("%s ? ? 0 ? %d 10000 ? %"PRId64"\n", size, nest, wall_time);

		//Acknowledge wild outliers
		/*
		if(k > 0 && (wall_time >= (meta_times[k-1] * 10))) {
			printf("Found outlier greater than or equal to one order of magnitude of previous test.\n");
			f = fopen(file3, "a");
			fprintf(f, meta_results);
			fclose(f);
		}
		*/
		average_time += wall_time;
		meta_times[k] = wall_time;

		if(meta_results) {
			f = fopen(file, "a");
			if(f == NULL) {
				printf("File %s could not be opened during metadata testing. Printing test results for manual entry into %s.\n%s", file, file, meta_results);
				free(meta_results);
				free(file);
				fprintf(stderr, "Metadata test errno %d: %s\n", errno, strerror(errno));
				return 1;
			}
			fprintf(f, meta_results);
			fclose(f);
			free(meta_results);
		}
		else {
			printf("Metadata results could not be calculated. Current test aborted.\n");
			free(file);
			return 1;
		}
	}
	avg_time = average_time / (iterations * 1.0);
	meta_acc = 0;
	for(k = 0; k < iterations; k++) {
		meta_acc += pow((meta_times[k] - avg_time), 2);
	}

	//Mean and standard deviation calculations and write
	meta_acc = meta_acc / iterations;
	meta_std_dev = sqrt(meta_acc);
	meta_std_dev = meta_std_dev / 1000000;
	avg_time = avg_time / 1000000;
	meta_results = string_format("%s ? ? 0 ? %d 10000 ? %f %f\n", size, nest, avg_time, meta_std_dev);
	if(meta_results) {
		f = fopen(file2, "a");
		if(f == NULL) {
			printf("File %s could not be opened during metadata testing. Printing test results for manual entry into %s.\n%s", file, file, meta_results);
			free(meta_results);
			free(file2);
			fprintf(stderr, "Metadata test errno %d: %s\n", errno, strerror(errno));
			return 1;
		}
		fprintf(f, meta_results);
		fclose(f);
		free(meta_results);
	}
	else {
		printf("Metadata results could not be calculated. Current test aborted.\n");
		free(file2);
		return 1;
	}
	printf("Metadata test complete.\nAverage Metadata time: %f\n", avg_time);
	free(file);
	return 0;
}

int disk_alloc_test_empty(char *size, int iterations, char *fs) {

	int64_t times[iterations];
	struct timeval wall_start;
	struct timeval wall_end;
	int64_t wall_time;
	char *flush = "sync";
	char cwd[FILENAME_MAX];
	getcwd(cwd, sizeof(cwd));
	char *file, *file2;
	file = string_format("%s/out_raw_empty.dat", cwd);
	file2 = string_format("%s/out_empty.dat", cwd);
	FILE *f;
	char *results = NULL;

	char *loc = "/tmp/disk_test";
	int64_t fit_size = string_metric_parse(size) / 1024;
	int k = 0;
	int j, result = 0;

	printf("Performing empty loop device allocation speed test.\n");

	for(j = 0; j < iterations; j++) {
		system(flush);
		gettimeofday(&wall_start, NULL);
		result = disk_alloc_create(loc, fs, fit_size);
		gettimeofday(&wall_end, NULL);
		if(result != 0) {
			return 1;
		}
		wall_time = ((1000000 * wall_end.tv_sec) + wall_end.tv_usec) - ((1000000 * wall_start.tv_sec) + wall_start.tv_usec);
		results = string_format("%s ? ? ? 0 %d ? %"PRId64" %"PRId64"\n", size, 0, fit_size, wall_time);
		times[k] = wall_time;
		if(results) {
			f = fopen(file, "a");
			if(f == NULL) {
				printf("File %s could not be opened during empty lood device testing. Printing test results for manual entry into %s.\n%s", file, file, results);
				free(results);
				free(file);
				fprintf(stderr, "Empty loop device test errno %d: %s\n", errno, strerror(errno));
				return 1;
			}
			fprintf(f, results);
			fclose(f);
			free(results);
		}
		else {
			printf("Empty loop device results could not be calculated. Current test aborted.\n");
			free(file);
			return 1;
		}
		disk_alloc_delete(loc);
		k++;
	}
	
	free(file);
	return 0;
}

int disk_alloc_test(char *size, int max_nest, int iterations, char *fs) {

	char *loc = "/tmp/disk_test";
	char *nested_loc;
	nested_loc = loc;
	char *locs[max_nest + 1];
	int64_t fit_size = string_metric_parse(size) / 1024;
	int64_t nested_size = (fit_size * 99) / 100;
	int i = 0;
	if(disk_alloc_create(loc, fs, fit_size) != 0) {
		return 1;
	}
	locs[0] = loc;
	read_write_test(fit_size, size, loc, i, iterations);
	metadata_test(size, nested_loc, i, iterations);
	for(i = 1; i < max_nest + 1; i++) {
		nested_loc = string_format("%s/%d", nested_loc, i);
		locs[i] = nested_loc;
		nested_size = (nested_size * 95) / 100;
		if(disk_alloc_create(nested_loc, fs, nested_size) != 0) {
			printf("Disk allocation failed for nest size. Deleting allocations and skipping tests.\n");
			break;
		}
		read_write_test(nested_size, size, nested_loc, i, iterations);
		metadata_test(size, nested_loc, i, iterations);
	}
	i--;
	while(i >= 0) {
		disk_alloc_delete(locs[i]);
		i--;
	}
	free(nested_loc);
	return 0;
}

int native_test_empty(int iterations) {

	char *loc = "/tmp/native_test";
	struct stat buf;
	int k = 0;
	while(k < iterations) {
		struct timeval wall_start;
		gettimeofday(&wall_start, NULL);
		mkdir(loc, 0777);
		stat(loc, &buf);
		rmdir(loc);
		struct timeval wall_end;
		gettimeofday(&wall_end, NULL);
		int64_t wall_time =((1000000 * wall_end.tv_sec) + wall_end.tv_usec) - ((1000000 * wall_start.tv_sec) + wall_start.tv_usec);
		off_t stat_size = buf.st_size;
		printf("wall: %"PRId64"\nsize: %"PRId64"\n", wall_time, (int64_t) stat_size);
		char *file = "./out.dat";
		FILE *f = fopen(file, "a");
		fprintf(f, "native ? ? ? 0 -1 ? ? %"PRId64"\n", wall_time);
		fclose(f);
		k++;
	}
	return 0;
}

int native_test(char *size, int iterations) {

	char *loc = "/tmp/native_test";
	int64_t fit_size = string_metric_parse(size) / 1024;
	mkdir(loc, 0777);
	read_write_test(fit_size, size, loc, -1, iterations);
	metadata_test(size, loc, -1, iterations);
	rmdir(loc);
	return 0;
}

int main(int argc, char *argv[]) {

	if(argc < 2) { printf("Must provide filesystem argument"); exit(1); }
	//disk_alloc_test_empty("2GB", argv[1]);
	//disk_alloc_test_empty("4GB", argv[1]);
	//disk_alloc_test_empty("8GB", argv[1]);
	disk_alloc_test_empty("1MB", 20, argv[1]);
	disk_alloc_test_empty("2MB", 20, argv[1]);
	disk_alloc_test_empty("4MB", 20, argv[1]);
	disk_alloc_test_empty("8MB", 20, argv[1]);
	disk_alloc_test_empty("16MB", 20, argv[1]);
	disk_alloc_test_empty("32MB", 20, argv[1]);
	disk_alloc_test_empty("64MB", 20, argv[1]);
	disk_alloc_test_empty("128MB", 20, argv[1]);
	disk_alloc_test_empty("256MB", 20, argv[1]);
	disk_alloc_test_empty("512MB", 20, argv[1]);
	disk_alloc_test_empty("1GB", 20, argv[1]);
	disk_alloc_test_empty("2GB", 20, argv[1]);
	disk_alloc_test_empty("4GB", 20, argv[1]);
	disk_alloc_test_empty("8GB", 20, argv[1]);
	disk_alloc_test_empty("16GB", 20, argv[1]);
	//native_test_empty(20);
	/*native_test("2GB", 20);
	native_test("4GB", 20);
	native_test("8GB", 20);
	disk_alloc_test("2GB", 20, 20, argv[1]);
	disk_alloc_test("4GB", 20, 20, argv[1]);
	disk_alloc_test("8GB", 20, 20, argv[1]);
	*///disk_alloc_test("2GB", 2, 2, argv[1]);

	printf("All tests successfully completed.\n");
	return 0;
}
