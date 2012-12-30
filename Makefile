# $Id$

################################################################################

# Copyright © 2012, Alan M. Watson. All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# * Redistributions in binary form must reproduce the above copyright
# notice, this list of conditions and the following disclaimer in the
# documentation and/or other materials provided with the distribution.
# 
# * The names of its contributors may not be used to endorse or promote
# products derived from this software without specific prior written
# permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

################################################################################

all: Topo.dmg

clean:
	rm -rf TopoHelper.app Topo.pkg Topo.dmg

TopoHelper.app: TopoHelper.applescript
	osacompile -o TopoHelper.app TopoHelper.applescript

Topo.pkg: TopoHelper.app
	rm -rf pkg
	mkdir pkg
	cp -pr topo topo.1 TopoHelper.app pkg
	sudo chown -R root:wheel pkg/*
	packagemaker -d Topo.pmdoc -o Topo.pkg

Topo.dmg: Topo.pkg README.rtf LICENSE.rtf
	rm -rf dmg
	mkdir -p dmg/Topo
	cp -r Topo.pkg README.rtf LICENSE.rtf dmg/Topo
	hdiutil create Topo.dmg -srcfolder dmg/Topo -ov
	rm -rf dmg
