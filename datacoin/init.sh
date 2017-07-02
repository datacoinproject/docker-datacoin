#!/bin/bash

if [ ! -e /root/.datacoin/debug.log  ]; then
    wget http://mirrors.kernel.org/gnu/gmp/gmp-5.1.2.tar.bz2 &&
    tar xjvf gmp-5.1.2.tar.bz2 && cd gmp-5.1.2 &&
    ./configure --enable-cxx &&
    make && make install &&
    wget https://github.com/foo1inge/datacoin-hp/archive/master.zip &&
    unzip ./master.zip && cd datacoin-hp-master/src &&
    cp makefile.unix makefile.my &&
    sed -i -e 's/$(OPENSSL_INCLUDE_PATH))/$(OPENSSL_INCLUDE_PATH) \/usr\/local\/include)/' makefile.my &&
    sed -i -e 's/$(OPENSSL_LIB_PATH))/$(OPENSSL_LIB_PATH) \/usr\/local\/lib)/' makefile.my &&
    sed -i -e 's/$(LDHARDENING) $(LDFLAGS)/$(LDHARDENING) -Wl,-rpath,\/usr\/local\/lib $(LDFLAGS)/' makefile.my &&
    sed -i -e 's@boost::get<const CScriptID&>(address)@boost::get<CScriptID>(address)@' rpcrawtransaction.cpp &&
    make -f makefile.my &&
    cp -f datacoind /usr/local/bin/ &&
    cd /root/ &&
    mkdir -p .datacoin &&
    cat << EOF > .datacoin/datacoin.conf
rpcallowip=127.0.0.1
rpcuser=primecoinrpc
rpcpassword=$(cat /dev/urandom | base64 | head -1)
server=1
gen=1
addnode=144.76.64.49:50852
addnode=125.215.137.66:56180
addnode=5.8.126.127:28046
addnode=51.254.196.222:54374
addnode=45.77.30.227:4777
addnode=99.0.80.78:3687
addnode=5.8.126.127:15450
addnode=[2001:19f0:7001:7fb:5400:ff:fe6e:a871]
addnode=144.76.64.49
addnode=139.162.210.78
addnode=[2a01:4f8:191:7330::2]
addnode=71.239.112.232
addnode=[2001:558:6033:87:956a:244e:c4ab:e7b]
EOF

fi

datacoind -daemon

tail -f /root/.datacoin/debug.log
