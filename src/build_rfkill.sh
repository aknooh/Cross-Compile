 #!/bin/bash
 # Statically cross compile rfkill for ARM architecture

 name=rfkill
 version=0.5
 release=1
 source=(https://mirrors.edge.kernel.org/pub/software/network/rfkill/$name-$version.tar.gz)

 export CC=arm-linux-gnueabihf-gcc
 export CFLAGS='-static'
 export LDFLAGS='-static'


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
 make V=$1


 INSTALL_DIR="$(pwd)/_install"
 if [ ! -d $INSTALL_DIR ]; then
     mkdir -p $INSTALL_DIR
 fi
 
 
 if [ -f $name ]; then
     mv $name $INSTALL_DIR/
     echo "Check executable type: "
     ldd $INSTALL_DIR/$name
     file $INSTALL_DIR/$name
 fi


 echo -e "Do cleanup\n"
 if [ -f ../$name-$version.tar.gz ]; then
     rm ../$name-$version.tar.gz
 fi
