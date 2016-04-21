/*
Copyright (C) 2003-2004 Douglas Thain and the University of Wisconsin
Copyright (C) 2005- The University of Notre Dame
This software is distributed under the GNU General Public License.
See the file COPYING for details.
*/

#include "stringtools.h"
#include "xxmalloc.h"

#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <math.h>
#include <regex.h>
#include <signal.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>
#include <sys/types.h>
#include <sys/stat.h>


int64_t string_metric_parse(const char *str)
{
	int64_t result;
	char prefix;

	switch (sscanf(str, "%"PRId64" %c", &result, &prefix)) {
		case 2:
			switch (toupper((int) prefix)) {
				case 'P':
					return result << 50;
				case 'T':
					return result << 40;
				case 'G':
					return result << 30;
				case 'M':
					return result << 20;
				case 'K':
					return result << 10;
				default:
					return result;
			}
		case 1:
			return result;
		default:
			return errno = EINVAL, -1;
	}
}

char *string_format(const char *fmt, ...)
{
	va_list va;

	va_start(va, fmt);
	int n = vsnprintf(NULL, 0, fmt, va);
	va_end(va);

	if(n < 0)
		return NULL;

	char *str = xxmalloc((n + 1) * sizeof(char));
	va_start(va, fmt);
	n = vsnprintf(str, n + 1, fmt, va);
	assert(n >= 0);
	va_end(va);

	return str;
}
/* vim: set noexpandtab tabstop=4: */
