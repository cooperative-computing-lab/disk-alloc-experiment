/*
 * Copyright (C) 2013- The University of Notre Dame
 * This software is distributed under the GNU General Public License.
 * See the file COPYING for details.
 */

#include "path.h"

#include "xxmalloc.h"

#include <dirent.h>
#include <fcntl.h>
#include <fnmatch.h>

#include <sys/stat.h>
#include <sys/types.h>

#include <errno.h>
#include <limits.h>
#include <stdlib.h>
#include <string.h>

void path_remove_trailing_slashes (char *path)
{
	char *s;

	/* Note: Loop body is never run where s == path (never removes first char)
	 * Consequently Note: if path == `/' then loop body never executes.
	 */
	for (s = path+strlen(path)-1; s > path && *s == '/'; s--) {
		*s = '\0';
	}
}
/* vim: set noexpandtab tabstop=4: */
