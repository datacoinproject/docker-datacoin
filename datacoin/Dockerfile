FROM ubuntu:latest

WORKDIR /root/
RUN apt update && apt upgrade -y && apt dist-upgrade -y && apt autoremove -y
RUN apt install -y build-essential m4 libssl-dev \
        libdb++-dev libboost-all-dev libminiupnpc-dev zip wget
ADD init.sh /init.sh
RUN chmod +x /init.sh
