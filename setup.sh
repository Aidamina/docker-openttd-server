#!/bin/bash
install_dependencies(){
	apt-get update
	apt-get install -y wget xz-utils unzip libsdl-image1.2 libfontconfig1
}
install_game(){
	#create data directory
	mkdir -p $DATA_DIR 
	#download and install server
	wget -qO- https://binaries.openttd.org/releases/$OPENTTD_VERSION/openttd-$OPENTTD_VERSION-linux-generic-amd64.tar.xz | tar -xJC $TEMP_DIR
	mv openttd-$OPENTTD_VERSION-linux-generic-amd64 $SERVER_DIR
	#download and install base gfx set
	wget -qO- http://binaries.openttd.org/extra/opengfx/$OPENGFX_VERSION/opengfx-$OPENGFX_VERSION-all.zip -O temp.zip && unzip temp.zip && rm temp.zip && tar -xf opengfx-$OPENGFX_VERSION.tar && rm opengfx-$OPENGFX_VERSION.tar
	mv opengfx-$OPENGFX_VERSION $SERVER_DIR/baseset
	
}
setup_user(){
	useradd -M -U openttd
	chown openttd:openttd $BASE_DIR -R
}
#Cleanup
cleanup(){
	apt-get remove -y unzip wget xz-utils && apt-get autoremove -y && apt-get autoclean -y
	rm -rf $TEMP_DIR/*

}