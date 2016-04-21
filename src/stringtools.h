/*
Copyright (C) 2003-2004 Douglas Thain and the University of Wisconsin
Copyright (C) 2005- The University of Notre Dame
This software is distributed under the GNU General Public License.
See the file COPYING for details.
*/

#ifndef STRINGTOOLS_H
#define STRINGTOOLS_H

#include <stdint.h>
#include <stdlib.h>
#include <time.h>

typedef char *(*string_subst_lookup_t) (const char *name, void *arg);

int64_t string_metric_parse(const char *str);

/** Appends second to first, both null terminated strings. Returns the new
  formed string. First argument is reallocated with realloc.
  @param first Null terminated string.
  @param second Null terminated string.
  @return Null terminated string concatenating second to first.
  */

/** Returns a heap allocated freeable string formatted using sprintf.
	@param fmt Format string passed to sprintf.
	@param ... Variable arguments passed to sprintf.
	@return The formatted string.
*/
char *string_format (const char *fmt, ...)
__attribute__ (( format(printf,1,2) ));

#endif
