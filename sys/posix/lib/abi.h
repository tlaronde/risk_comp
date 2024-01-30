/* $Id: abi.h,v 1.5 2020/07/11 19:00:59 tlaronde Exp $
 * Copyright 2004, 2020 Thierry LARONDE <tlaronde@polynum.com>
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
#include <limits.h>

/* Size of char */
#ifdef CHAR_BIT
#if CHAR_BIT == 8
#define CHAR_IS_BYTE
@@T_BYTE=char
#endif
#endif

/* Remaining will only work with BYTE chars (8 bits) */
#ifdef CHAR_IS_BYTE

/* We start by the more "natural" integer type so that what is
 * defined here takes precedence.
 */
/* Size of int */
#ifdef UINT_MAX
#if UINT_MAX == 0xffffffffU
@@T_TETRA=int
#elif UINT_MAX == 0xffffffffffffffffU
@@T_OCTA=int
#endif
#endif /* UINT_MAX */

/* Size of short */
#ifdef USHRT_MAX
#if USHRT_MAX == 0xffffU
@@T_WYDE=short
#elif USHRT_MAX == 0xffffffffU
@@T_TETRA=short
#elif USHRT_MAX == 0xffffffffffffffffU
@@T_OCTA=short
#endif
#endif /* USHRT_MAX */ 

/* Size of long */
#ifdef ULONG_MAX
#if ULONG_MAX == 0xffffffffUL
@@T_TETRA=${T_TETRA:-long}
#elif ULONG_MAX == 0xffffffffffffffffUL
@@T_OCTA=${T_OCTA:-long}
#endif
#endif /* ULONG_MAX */

#endif /* CHAR_IS_BYTE */

/* TODO IEEE/ISO standard 754 correct support 
 * single precision is 32 bits
 * double precision is 64 bits
 * but an implementation can have only double precision (on octabyte
 * computers) */

#include <float.h>

#ifdef FLT_MANT_DIG
#if FLT_MANT_DIG == 24
@@T_FLOAT=TETRA
#endif
#endif

#ifdef DBL_MANT_DIG
#if DBL_MANT_DIG == 53
@@T_DOUBLE=OCTA
#endif
#endif
