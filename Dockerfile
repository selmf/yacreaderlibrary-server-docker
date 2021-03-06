FROM debian:jessie
MAINTAINER muallin@gmail.com

WORKDIR /src
WORKDIR git

# Update system
RUN apt-get update && \
    apt-get -y install git qt5-default libpoppler-qt5-dev libpoppler-qt5-1 wget unzip libqt5sql5-sqlite libqt5sql5 sqlite3 libqt5network5 libqt5gui5 libqt5core5a build-essential && \
    git clone git@github.com:josetesan/yacreaderlibrary-server-docker.git . && \
    git checkout 9.5.0 && \
    cd compressed_archive/unarr/ && \
    wget github.com/selmf/unarr/archive/master.zip &&\
    unzip master.zip  &&\
    rm master.zip &&\
    cd unarr-master/lzmasdk &&\
    ln -s 7zTypes.h Types.h  && \
    cd /src/git/YACReaderLibraryServer && \
    qmake YACReaderLibraryServer.pro && \
    make  && \
    make install && \
    cd /     && \
    rm -rf /src && \
    rm -rf /var/cache/apt &&\
    apt-get purge -y git wget build-essential && \
    apt-get -y autoremove

VOLUME /comics
    
EXPOSE 8080

ENTRYPOINT ["YACReaderLibraryServer","start"]
