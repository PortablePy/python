# =========================================================================
#     This makefile was generated by
#     Bakefile 0.2.12 (http://www.bakefile.org)
#     Do not modify, all changes will be overwritten!
# =========================================================================




prefix = /usr/local
exec_prefix = ${prefix}
datarootdir = ${prefix}/share
INSTALL = /usr/bin/install -c
EXEEXT = 
WINDRES = 
NM = nm
BK_DEPS = /Users/apt/பதிவிறக்கங்கள்/wxWidgets-3.1.5/build-cocoa-debug/bk-deps
srcdir = ../../../samples/vscroll
top_srcdir = ../../..
LIBS = -lz -framework Security -lpthread -liconv
LDFLAGS_GUI = 
CXX = g++ -std=gnu++11 -mmacosx-version-min=10.10
CXXFLAGS = 
CPPFLAGS = 
LDFLAGS = 
USE_DPI_AWARE_MANIFEST = 2
WX_LIB_FLAVOUR = 
TOOLKIT = OSX_COCOA
TOOLKIT_LOWERCASE = osx_cocoa
TOOLKIT_VERSION = 
TOOLCHAIN_FULLNAME = osx_cocoa-unicode-3.1
EXTRALIBS =   -framework IOKit -framework Carbon -framework Cocoa -framework QuartzCore -framework AudioToolbox -framework System -framework OpenGL  -lz -framework Security -lpthread -liconv 
EXTRALIBS_XML =  -lexpat
EXTRALIBS_GUI = -framework WebKit
WX_CPPFLAGS = -I${wx_top_builddir}/lib/wx/include/osx_cocoa-unicode-3.1 -I${top_srcdir}/include -D_FILE_OFFSET_BITS=64 
WX_CXXFLAGS = -Wall -Wundef -Wunused-parameter -Wno-ctor-dtor-privacy -Woverloaded-virtual -Wno-deprecated-declarations -g -O0 -fno-common  -fvisibility=hidden -fvisibility-inlines-hidden
WX_LDFLAGS =  -framework IOKit -framework Carbon -framework Cocoa -framework QuartzCore -framework AudioToolbox -framework System -framework OpenGL 
HOST_SUFFIX = 
SAMPLES_RPATH_FLAG = 
SAMPLES_CXXFLAGS =  -dynamic -fPIC -DPIC
wx_top_builddir = /Users/apt/பதிவிறக்கங்கள்/wxWidgets-3.1.5/build-cocoa-debug

### Variables: ###

DESTDIR = 
WX_RELEASE = 3.1
WX_VERSION = $(WX_RELEASE).5
LIBDIRNAME = $(wx_top_builddir)/lib
VSTEST_CXXFLAGS = $(WX_CPPFLAGS) -D__WX$(TOOLKIT)__ $(__WXUNIV_DEFINE_p) \
	$(__DEBUG_DEFINE_p) $(__EXCEPTIONS_DEFINE_p) $(__RTTI_DEFINE_p) \
	$(__THREAD_DEFINE_p) -I$(srcdir) $(__DLLFLAG_p) -I$(srcdir)/../../samples \
	$(WX_CXXFLAGS) $(SAMPLES_CXXFLAGS) $(CPPFLAGS) $(CXXFLAGS)
VSTEST_OBJECTS =  \
	$(__vstest___win32rc) \
	vstest_vstest.o

### Conditionally set variables: ###

#CXXC = $(CXX)
CXXC = $(BK_DEPS) $(CXX)
#PORTNAME = base
PORTNAME = $(TOOLKIT_LOWERCASE)$(TOOLKIT_VERSION)
#WXBASEPORT = _carbon
#WXDEBUGFLAG = d
WXUNICODEFLAG = u
#WXUNIVNAME = univ
EXTRALIBS_FOR_BASE = $(EXTRALIBS)
#EXTRALIBS_FOR_BASE = $(EXTRALIBS) \
#	$(EXTRALIBS_XML) $(EXTRALIBS_GUI)
EXTRALIBS_FOR_GUI = $(EXTRALIBS_GUI)
#EXTRALIBS_FOR_GUI = 
#__WXUNIV_DEFINE_p = -D__WXUNIVERSAL__
#__WXUNIV_DEFINE_p_1 = --define __WXUNIVERSAL__
#__DEBUG_DEFINE_p = -DwxDEBUG_LEVEL=0
#__DEBUG_DEFINE_p_1 = --define wxDEBUG_LEVEL=0
#__EXCEPTIONS_DEFINE_p = -DwxNO_EXCEPTIONS
#__EXCEPTIONS_DEFINE_p_1 = --define wxNO_EXCEPTIONS
#__RTTI_DEFINE_p = -DwxNO_RTTI
#__RTTI_DEFINE_p_1 = --define wxNO_RTTI
#__THREAD_DEFINE_p = -DwxNO_THREADS
#__THREAD_DEFINE_p_1 = --define wxNO_THREADS
__DLLFLAG_p = -DWXUSINGDLL
__DLLFLAG_p_1 = --define WXUSINGDLL
#__WIN32_DPI_MANIFEST_p = \
#	--define \
#	wxUSE_DPI_AWARE_MANIFEST=$(USE_DPI_AWARE_MANIFEST)
COND_PLATFORM_OS2_1___vstest___os2_emxbindcmd = $(NM) vstest$(EXEEXT) | if grep \
	-q pmwin.763 ; then emxbind -ep vstest$(EXEEXT) ; fi
#__vstest___os2_emxbindcmd = $(COND_PLATFORM_OS2_1___vstest___os2_emxbindcmd)
#__RCDEFDIR_p = --include-dir \
#	$(LIBDIRNAME)/wx/include/$(TOOLCHAIN_FULLNAME)
#__vstest___win32rc = vstest_sample_rc.o
__vstest_app_Contents_PkgInfo___depname \
	= vstest.app/Contents/PkgInfo
__vstest_bundle___depname = vstest_bundle
#____vstest_BUNDLE_TGT_REF_DEP = \
#	$(__vstest_app_Contents_PkgInfo___depname)
#____vstest_BUNDLE_TGT_REF_DEP \
#	= $(__vstest_app_Contents_PkgInfo___depname)
____vstest_BUNDLE_TGT_REF_DEP \
	= $(__vstest_app_Contents_PkgInfo___depname)
#____vstest_BUNDLE_TGT_REF_DEP \
#	= $(__vstest_app_Contents_PkgInfo___depname)
#____vstest_BUNDLE_TGT_REF_DEP = \
#	$(__vstest_app_Contents_PkgInfo___depname)
COND_MONOLITHIC_0___WXLIB_CORE_p = \
	-lwx_$(PORTNAME)$(WXUNIVNAME)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)_core-$(WX_RELEASE)$(HOST_SUFFIX)
__WXLIB_CORE_p = $(COND_MONOLITHIC_0___WXLIB_CORE_p)
COND_MONOLITHIC_0___WXLIB_BASE_p = \
	-lwx_base$(WXBASEPORT)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)-$(WX_RELEASE)$(HOST_SUFFIX)
__WXLIB_BASE_p = $(COND_MONOLITHIC_0___WXLIB_BASE_p)
COND_MONOLITHIC_1___WXLIB_MONO_p = \
	-lwx_$(PORTNAME)$(WXUNIVNAME)$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)-$(WX_RELEASE)$(HOST_SUFFIX)
#__WXLIB_MONO_p = $(COND_MONOLITHIC_1___WXLIB_MONO_p)
#__LIB_SCINTILLA_IF_MONO_p \
#	= \
#	-lwxscintilla$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)-$(WX_RELEASE)$(HOST_SUFFIX)
__LIB_TIFF_p \
	= \
	-lwxtiff$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)-$(WX_RELEASE)$(HOST_SUFFIX)
__LIB_JPEG_p \
	= \
	-lwxjpeg$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)-$(WX_RELEASE)$(HOST_SUFFIX)
__LIB_PNG_p \
	= \
	-lwxpng$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)-$(WX_RELEASE)$(HOST_SUFFIX)
#__LIB_ZLIB_p = \
#	-lwxzlib$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)-$(WX_RELEASE)$(HOST_SUFFIX)
COND_wxUSE_REGEX_builtin___LIB_REGEX_p = \
	-lwxregex$(WXUNICODEFLAG)$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)-$(WX_RELEASE)$(HOST_SUFFIX)
__LIB_REGEX_p = $(COND_wxUSE_REGEX_builtin___LIB_REGEX_p)
#__LIB_EXPAT_p = \
#	-lwxexpat$(WXDEBUGFLAG)$(WX_LIB_FLAVOUR)-$(WX_RELEASE)$(HOST_SUFFIX)

### Targets: ###

all: vstest$(EXEEXT) $(__vstest_bundle___depname)

install: 

uninstall: 

install-strip: install

clean: 
	rm -rf ./.deps ./.pch
	rm -f ./*.o
	rm -f vstest$(EXEEXT)
	rm -rf vstest.app

distclean: clean
	rm -f config.cache config.log config.status bk-deps bk-make-pch shared-ld-sh Makefile

vstest$(EXEEXT): $(VSTEST_OBJECTS) $(__vstest___win32rc)
	$(CXX) -o $@ $(VSTEST_OBJECTS)    -L$(LIBDIRNAME)  $(LDFLAGS_GUI) $(SAMPLES_RPATH_FLAG) $(LDFLAGS)  $(WX_LDFLAGS) $(__WXLIB_CORE_p)  $(__WXLIB_BASE_p)  $(__WXLIB_MONO_p) $(__LIB_SCINTILLA_IF_MONO_p) $(__LIB_TIFF_p) $(__LIB_JPEG_p) $(__LIB_PNG_p)  $(EXTRALIBS_FOR_GUI) $(__LIB_ZLIB_p) $(__LIB_REGEX_p) $(__LIB_EXPAT_p) $(EXTRALIBS_FOR_BASE) $(LIBS)
	$(__vstest___os2_emxbindcmd)

vstest.app/Contents/PkgInfo: vstest$(EXEEXT) $(top_srcdir)/src/osx/carbon/Info.plist.in $(top_srcdir)/src/osx/carbon/wxmac.icns
	mkdir -p vstest.app/Contents
	mkdir -p vstest.app/Contents/MacOS
	mkdir -p vstest.app/Contents/Resources
	
	
	sed -e "s/IDENTIFIER/`echo $(srcdir) | sed -e 's,\.\./,,g' | sed -e 's,/,.,g'`/" \
	-e "s/EXECUTABLE/vstest/" \
	-e "s/VERSION/$(WX_VERSION)/" \
	$(top_srcdir)/src/osx/carbon/Info.plist.in >vstest.app/Contents/Info.plist
	
	
	/bin/echo "APPL????" >vstest.app/Contents/PkgInfo
	
	
	ln -f vstest$(EXEEXT) vstest.app/Contents/MacOS/vstest
	
	
	cp -f $(top_srcdir)/src/osx/carbon/wxmac.icns vstest.app/Contents/Resources/wxmac.icns

vstest_bundle: $(____vstest_BUNDLE_TGT_REF_DEP)

vstest_sample_rc.o: $(srcdir)/../../samples/sample.rc
	$(WINDRES) -i$< -o$@    --define __WX$(TOOLKIT)__ $(__WXUNIV_DEFINE_p_1) $(__DEBUG_DEFINE_p_1)  $(__EXCEPTIONS_DEFINE_p_1) $(__RTTI_DEFINE_p_1) $(__THREAD_DEFINE_p_1)  --include-dir $(srcdir) $(__DLLFLAG_p_1) $(__WIN32_DPI_MANIFEST_p) --include-dir $(srcdir)/../../samples $(__RCDEFDIR_p) --include-dir $(top_srcdir)/include

vstest_vstest.o: $(srcdir)/vstest.cpp
	$(CXXC) -c -o $@ $(VSTEST_CXXFLAGS) $(srcdir)/vstest.cpp


# Include dependency info, if present:
-include ./.deps/*.d

.PHONY: all install uninstall clean distclean vstest_bundle
