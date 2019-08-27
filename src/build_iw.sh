#!/bin/bash
# Simple script for statically cross compiling iw tool for ARM architecture
# Free to use and modify

name=iw
version=3.15
source=(https://www.kernel.org/pub/software/network/iw/$name-$version.tar.gz)

# To change to a different ARC, change the line below
export CC=arm-linux-gnueabi-gcc

if [ ! -d $name-$version ]; then
    curl -q -L -O $source
    tar xvf $name-$version.*tar*
fi

cd $name-$version

object_files=`find . -name '*.o' | wc -l`
if [ $object_files -ne 0 ];
then
    make clean
    echo "Make-clean: remove all object files"
fi

# Make the changes needed to the Makefile to compile and link statically
sed -i -- 's/CFLAGS ?= -O2 -g/& -static/g' Makefile
line_num=`grep -n "CFLAGS += -Wall -Wundef -Wstrict-prototypes" Makefile | cut -d ':' -f1`
sed -i "$(($line_num+1))i #Change to static linking" Makefile
sed -i "$(($line_num+2))i LDFLAGS += -static" Makefile
line_num=`grep -n "NLLIBNAME = libnl-1" Makefile | cut -d ':' -f1`
sed -i "$(($line_num+3))i #Add required libraries for static linking" Makefile
sed -i "$(($line_num+4))i LIBS += -lm -ldl -lrt" Makefile
line_num=`grep -n 'all: $(ALL)' Makefile | cut -d ':' -f1`
sed -i "$(($line_num-1))i LIBS += -lpthread" Makefile
sed -i -- 's/$(Q)$(CC) $(LDFLAGS) $(OBJS) $(LIBS) -o iw/$(Q)$(CC) $(LDFLAGS) $(OBJS) $(LIBS) -lm -o iw/g' Makefile

export PKG_CONFIG_PATH=/usr/arm-linux-gnueabi/lib/pkgconfig
make V=$1


INSTALL_DIR="$(pwd)/_install"
if [ ! -d $INSTALL_DIR ]; then
    mkdir -p $INSTALL_DIR
fi
if [ -f $name ]; then
    mv $name $INSTALL_DIR/
    echo -e "\nCheck executable type: "
    ldd $INSTALL_DIR/$name
    file $INSTALL_DIR/$name
    echo "$name exectuable located in: $(pwd)/_install"
fi

echo "Remove tar package"
if [ -f ../$name-$version.tar.gz ]; then
    rm ../$name-$version.tar.gz
fi


