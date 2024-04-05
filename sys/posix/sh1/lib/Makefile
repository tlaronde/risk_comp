# Automatically defined by rkconfig
MATRIX = ##MATRIX##
TOOLDIR = ##TOOLDIR##
PROJECTDIR = ##PROJECTDIR##
OBJDIRPREFIX = ##OBJDIRPREFIX##
OBJDIR = ##OBJDIR##
MAKE = ##MAKE##
SHELL = ##SHELL##
NB_DIRS = ##NB_DIRS##
RK_LIST = $(OBJDIR)/.rkcomp/list
RK_VERIF = $(OBJDIR)/.rkcomp/libes.verif
RK_STATS = $(OBJDIR)/.rkcomp/stats
PKGNAME = ##PKGNAME##

all: 
	@if test $(MATRIX) != plan9; then\
		user="$$(id -un)";\
		test "$$user" != "root" -a "$$user" != "0"\
		|| { echo "Do NOT compile as ROOT!" >&2; exit 1; };\
	fi
	@trap "echo ' interrupted!' >&2; exit" QUIT INT; \
	nb=0;\
	for dir in `cat $(RK_LIST)`; do \
	  nb=$$(($$nb + 1)); \
	  dir=$${dir%/}; \
	  { echo $$dir | grep '^[^#@!]' >/dev/null 2>&1;} || continue; \
	  $(MAKE) SAVE_SPACE=$(SAVE_SPACE) compile dir=$$dir nb=$$nb; \
	done
	@if grep '^[^#@]' $(RK_LIST) >/dev/null 2>&1; then \
	  $(MAKE) show_failed; exit 1;\
	else \
	  echo "############## COMPILATION SUCCEEDED! ##############" >&2; \
	fi

retry: 
	@if test $(MATRIX) != plan9; then\
		user="$$(id -un)";\
		test "$$user" != "root" -a "$$user" != "0"\
		|| { echo "Do NOT compile as ROOT!" >&2; exit 1; };\
	fi
	@trap "echo ' interrupted!' >&2; exit" QUIT INT; \
	for dir in `sed -n 's/^!\(.*\)$$/\1/p' $(RK_LIST)`; do \
	  $(MAKE) compile dir=$$dir; \
	done
	@if grep '^[^#@]' $(RK_LIST) >/dev/null 2>&1; then \
	  $(MAKE) show_failed; exit 1;\
	else \
	  echo "############## COMPILATION SUCCEEDED! ##############" >&2; \
	fi

compile:
	@if test $(MATRIX) != plan9; then\
		user="$$(id -un)";\
		test "$$user" != "root" -a "$$user" != "0"\
		|| { echo "Do NOT compile as ROOT!" >&2; exit 1; };\
	fi
	@ [ "x$(dir)" != "x" ] || { echo "You must specify a dir!" >&2; exit 1; }
	@test -f $(PROJECTDIR)/$(dir)/Makefile.ker || { echo "$(PROJECTDIR)/$(dir) is not a correct dir!" >&2; exit 1; }
	@echo >&2; echo "#========== BUILDING $(dir)" >&2;
	@dir=$(dir); dir=$${dir%/}; \
	if ! $(SHELL) $(TOOLDIR)/sys/posix/sh1/rkbuild $$dir; then\
		echo "Problem rkbuilding $$dir. Skipping..." >&2; \
	    { echo '1,$$s%^[#!@]*'$$dir'$$%!'$$dir'%'; echo w; echo q;} | ed $(RK_LIST) >/dev/null 2>&1; \
		exit 1;\
	else\
		cd $(OBJDIR)/$(dir);\
		if ! $(MAKE); then\
			dir=$(dir); dir=$${dir%/}; \
			echo "Problem making $$dir. Skipping..." >&2;\
			{ echo '1,$$s%^[#!@]*'$$dir'$$%!'$$dir'%'; echo w; echo q;} | ed $(RK_LIST) >/dev/null 2>&1;\
			exit 1;\
		fi;\
		test "x$(SAVE_SPACE)" != "xYES"\
		|| { $(MAKE) clean; rm -f Makefile; }; \
	fi
	@if [ "x$(nb)" != "x" ]; then \
	  echo >&2; echo "#========== $(dir) DONE ($(nb)/$(NB_DIRS))" >&2;\
	else \
	  echo >&2; echo "#========== $(dir) DONE" >&2;\
	fi;\
	dir=$(dir); dir=$${dir%/}; \
	{ echo '1,$$s%^[#!@]*'$$dir'$$%@'$$dir'%'; echo w; echo q;} | ed $(RK_LIST) >/dev/null 2>&1; 

debug:
	@if test $(MATRIX) != plan9; then\
		user="$$(id -un)";\
		test "$$user" != "root" -a "$$user" != "0"\
		|| { echo "Do NOT compile as ROOT!" >&2; exit 1; };\
	fi
	@ [ "x$(dir)" != "x" ] || { echo "You must specify a dir!" >&2; exit 1; }
	@test -f $(PROJECTDIR)/$(dir)/Makefile.ker || { echo "$(PROJECTDIR)/$(dir) is not a correct dir!" >&2; exit 1; }
	@echo >&2; echo "#========== RKDEBUG BUILDING $(dir)" >&2;
	@if ! $(SHELL) $(TOOLDIR)/sys/posix/sh1/rkbuild -d $(dir); then\
		echo "Problem rkbuilding $(dir). Skipping..." >&2; \
		exit 1;\
	else\
		cd $(OBJDIR)/$(dir);\
		if ! $(MAKE); then\
			echo "Problem making $(dir). Skipping..." >&2;\
			exit 1;\
		fi;\
	fi
	echo >&2; echo "#========== RKDEBUG $(dir) DONE" >&2;


show_failed:
	@echo "Programs that failed to build:" >&2
	@sed -n '/^!/p' $(RK_LIST) 

pkg: all
	@echo "Packaging the result..." >&2
	@if [ "x$(SAVE_SPACE)" = "xYES" ]; then \
	  $(SHELL) $(TOOLDIR)/sys/posix/sh1/rkpkg -s; \
	else \
	  $(SHELL) $(TOOLDIR)/sys/posix/sh1/rkpkg; \
	fi

build_clean: pkg_clean
	@{ echo '1,$$s/^[!@]//'; echo w; echo q; } | ed $(RK_LIST) >/dev/null 2>&1 || true
	@{ echo '1,$$s/^[^#]/#&/'; echo w; echo q; } | ed $(RK_VERIF) >/dev/null 2>&1 || true
	@for dir in `sed '/^#/d' $(RK_LIST)`; do \
	  rm -fr $(OBJDIR)/$$dir; \
	done

pkg_clean:
	@rm -fr .rkcomp/kept/*
	@rm -fr .rkcomp/installed/*
	@rm -fr .rkcomp/preserved/*
	@rm -f .rkcomp/*.list
	@rm -f "$(PKGNAME).tar"

stats: 
	@if test $(MATRIX) != plan9; then\
		user="$$(id -un)";\
		test "$$user" != "root" -a "$$user" != "0"\
		|| { echo "Do NOT compile as ROOT!" >&2; exit 1; };\
	fi
	@$(MAKE) build_clean
	@echo $(uname -a) >$(RK_STATS)
	@echo "########## PROG START SIZE BUILT DATE SIZE COMPILED DATE SIZE" >>$(RK_STATS) 
	@export BLOCKSIZE=; trap "echo ' interrupted!' >&2; exit" QUIT INT; \
	for dir in `sed -n '/^#/!p' $(RK_LIST)`; do \
	  echo -n "$$dir $$(date -u) $$(du -s . | sed s/^\([0-9]*\).$$/\1/)" >>$(RK_STATS);\
	  if $(SHELL) $(TOOLDIR)/sys/posix/sh1/rkbuild $$dir; then \
	    echo -n " OK $$(date -u) $$(du -s . | sed s/^\([0-9]*\).$$/\1/)" >>$(RK_STATS);\
	  else \
	    echo " FAILED $$(date -u) $$(du -s . | sed s/^\([0-9]*\).$$/\1/ )" >>$(RK_STATS); continue;\
	  fi;\
	  cd $(OBJDIR)/$$dir ; if $(MAKE); then  \
	     echo -n " OK" >>$(RK_STATS); else \
	     echo -n " FAILED" >>$(RK_STATS);\
	  fi;\
	  echo " $$(date -u) $$(du -s $(OBJDIR) | sed s/^\([0-9]*\).$$/\1/)" >> $(RK_STATS);\
	  $(MAKE) clean; rm -f Makefile; \
	  cd $(OBJDIR);\
	done
	@{ export BLOCKSIZE=; echo "### END COMPILATION";\
	echo "FINISHED=$$(date -u)";\
	echo "FINAL_COMPILE_SIZE=$$(du -s . | sed s/^\([0-9]*\).$$/\1/)";\
	} >>$(RK_STATS)

# this one could be used when compiling identity (for this very same
# TARGET)
local_install: all
	@echo "Installing locally..." >&2
	@if [ "x$(SAVE_SPACE)" = "xYES" ]; then\
	  $(SHELL) $(TOOLDIR)/sys/posix/sh1/rkpkg -l -s;\
	else\
	  $(SHELL) $(TOOLDIR)/sys/posix/sh1/rkpkg -l;\
	fi

