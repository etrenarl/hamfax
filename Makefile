# Generated automatically from Makefile.in by configure.
# HamFax -- an application for sending and receiving amateur radio facsimiles
# Copyright (C) 2001 Christof Schmittt, DH1CS <cschmit@suse.de>
#  
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#  
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

CXX=c++
CXXFLAGS=-Wall -I/usr/lib/qt2/include -g -O2
CPPFLAGS=
LIBS=-L/usr/lib/qt2/lib -lqt  -lSM -lICE  -L/usr/X11R6/lib -lX11 -lXext -lXmu -lXt -lXi  -laudiofile
INSTALL=/usr/bin/install -c
INSTALLDIR=/usr/local/bin/
QT_MOC=/usr/lib/qt2/bin/moc

all: hamfax

clean:
	rm -rfv *~ *.o moc_*.cpp hamfax qhamfax\
        config.cache config.log config.status moc_bnv_qt_test.C

install: hamfax
	$(INSTALL) hamfax $(INSTALLDIR)

.cpp.o:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $<

moc_%.cpp: %.hpp
	$(QT_MOC) $< -o $@

Error.o: Error.cpp Error.hpp

FaxControl.o: FaxControl.cpp FaxControl.hpp

FaxDemodulator.o: FaxDemodulator.cpp FaxDemodulator.hpp

FaxImage.o: FaxImage.cpp FaxImage.hpp

FaxModulator.o: FaxModulator.cpp FaxModulator.hpp

FaxReceiver.o: FaxReceiver.cpp FaxReceiver.hpp FaxImage.hpp

FaxTransmitter.o: FaxTransmitter.cpp FaxTransmitter.hpp FaxImage.hpp

FaxView.o: FaxView.cpp FaxView.hpp FaxImage.hpp

FaxWindow.o: FaxWindow.cpp FaxWindow.hpp\
             Error.hpp FaxView.hpp OptionsDialog.hpp\
             FaxControl.hpp FaxDemodulator.hpp FaxImage.hpp\
             FaxModulator.hpp FaxReceiver.hpp FaxTransmitter.hpp\
             File.hpp PTC.hpp PTT.hpp ReceiveDialog.hpp\
             Sound.hpp TransmitDialog.hpp

File.o: File.cpp File.hpp

OptionsDialog.o: OptionsDialog.cpp OptionsDialog.hpp

PTC.o: PTC.cpp PTC.hpp Error.hpp

PTT.o: PTT.cpp PTT.hpp Error.hpp

ReceiveDialog.o: ReceiveDialog.cpp ReceiveDialog.hpp

ScaleDialog.o: ScaleDialog.cpp ScaleDialog.hpp

Sound.o: Sound.cpp Sound.hpp Error.hpp

TransmitDialog.o: TransmitDialog.cpp TransmitDialog.hpp

hamfax.o: hamfax.cpp FaxWindow.hpp

hamfax: Error.o\
        FaxControl.o moc_FaxControl.o\
        FaxDemodulator.o moc_FaxDemodulator.o\
        FaxImage.o moc_FaxImage.o\
        FaxModulator.o moc_FaxModulator.o\
        FaxReceiver.o moc_FaxReceiver.o\
        FaxTransmitter.o moc_FaxTransmitter.o\
        FaxView.o moc_FaxView.o\
        FaxWindow.o moc_FaxWindow.o\
        File.o moc_File.o\
        OptionsDialog.o moc_OptionsDialog.o\
        PTC.o moc_PTC.o\
        PTT.o moc_PTT.o\
        ReceiveDialog.o moc_ReceiveDialog.o\
        ScaleDialog.o moc_ScaleDialog.o\
        Sound.o moc_Sound.o\
        TransmitDialog.o moc_TransmitDialog.o\
        hamfax.o
	$(CXX) -o $@ $(CXXFLAGS) $(LIBS) $+
