/*
Copyright (C) 2003-2004 Douglas Thain and the University of Wisconsin
Copyright (C) 2005- The University of Notre Dame
This software is distributed under the GNU General Public License.
See the file COPYING for details.
*/

#include "xxmalloc.h"

#include <stdlib.h>
#include <string.h>

/*
Note that xmalloc is a common name, as it is suggested by
the Stevens Unix book.  So a to avoid conflicts with packages
such as readline, we use xxmalloc, but it means the same thing.
*/

void *xxmalloc(size_t nbytes)
{
	void *result = malloc(nbytes);
	if(result) {
		return result;
	} else {
		//fatal("out of memory");
		return 0;
	}
}
/* vim: set noexpandtab tabstop=4: */
