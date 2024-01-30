/* $Id: api.h,v 1.7 2004/08/01 17:58:54 tlaronde Exp $
 * Copyright 2004 Thierry LARONDE <tlaronde@polynum.com>
 * All rights reserved. 
 * 
 * This work is under the KerGIS Public Licence v1.0
 *
 * See the COPYRIGHT file at the root of the source directory or see
 * http://www.kergis.org/licence.txt for complete information.
 *
 *!!!THIS SOFTWARE IS PROVIDED ``AS IS'' WITHOUT ANY WARRANTIES!!! 
 *                     USE IT AT YOUR OWN RISK 
 ********************************************************************/

/* Is Standard C supported by the compiler? */
#ifdef __STDC__
@@STDC=YES
#else
@@STDC=NO
#endif

/* What is the POSIX version if any? */
#include <stdlib.h>
#include <unistd.h>

#ifdef _POSIX_VERSION
@@C_POSIX_VERSION=_POSIX_VERSION
#else
@@C_POSIX_VERSION=
#endif

