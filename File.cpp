// HamFax -- an application for sending and receiving amateur radio facsimiles
// Copyright (C) 2001 Christof Schmittt, DH1CS <cschmit@suse.de>
//  
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//  
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

#include "File.hpp"
#include "Error.hpp"

File::File(QObject* parent)
	: QObject(parent)
{
	afSetErrorHandler(0);
}

File::~File(void)
{
	this->close();
}

void File::openOutput(const QString& fileName, unsigned int sampleRate)
{
	AFfilesetup fs;
	if((fs=afNewFileSetup())==AF_NULL_FILESETUP) {
		throw Error(tr("could not allocate AFfilesetup"));
	}
	afInitFileFormat(fs,AF_FILE_NEXTSND);
	afInitSampleFormat(fs,AF_DEFAULT_TRACK,AF_SAMPFMT_TWOSCOMP,16);
	afInitByteOrder(fs,AF_DEFAULT_TRACK,AF_BYTEORDER_BIGENDIAN);
	afInitChannels(fs,AF_DEFAULT_TRACK,1);
	afInitRate(fs,AF_DEFAULT_TRACK,sampleRate);
	
	if((aFile=afOpenFile(fileName,"w",fs))==AF_NULL_FILEHANDLE) {
		aFile=0;
		throw Error(tr("could not open file"));
	}
	afFreeFileSetup(fs);
}

void File::openInput(const QString& fileName, unsigned int& sampleRate)
{
	try {
		AFfilesetup fs=0;
		if((aFile=afOpenFile(fileName,"r",fs))==AF_NULL_FILEHANDLE) {
			throw Error(tr("could not open file"));
		}
		if(afGetFrameSize(aFile,AF_DEFAULT_TRACK,0)!=2) {
			throw Error(tr("samples size not 16 bit"));
		}
		sampleRate=(unsigned int)afGetRate(aFile,AF_DEFAULT_TRACK);
	} catch(Error) {
		close();
		throw;
	}
}

void File::close(void)
{
	if(aFile!=0) {
		afCloseFile(aFile);
		aFile=0;
	}
}

void File::write(signed short* samples, unsigned int number)
{
	try {
		if(aFile!=0) {
			if((afWriteFrames(aFile,AF_DEFAULT_TRACK,
					  samples,number))==AF_BAD_WRITE) {
				throw Error(tr("could not write to file"));
			}
		}
	} catch(Error) {
		close();
		throw;
	}
}

void File::read(signed short* samples, unsigned int& number)
{
	try {
		if(aFile!=0) {
			if((number=afReadFrames(aFile,AF_DEFAULT_TRACK,
						samples,number))<0) {
				throw Error(tr("could not read from file"));
			}
		}
	} catch(Error) {
		close();
		throw;
	}
}
