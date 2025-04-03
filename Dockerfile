# SOURCE DOCUMENTAION: https://www.kasmweb.com/docs/latest/how_to/building_images.html

FROM kasmweb/core-ubuntu-noble:develop
USER root

ENV HOME=/home/kasm-default-profile
ENV STARTUPDIR=/dockerstartup
ENV INST_SCRIPTS=$STARTUPDIR/install
ENV GNS3_CONF_PATH=$HOME/.config/GNS3/2.2/
WORKDIR $HOME

######### Customize Container Here ###########

# GNS3 https://docs.gns3.com/docs/getting-started/installation/linux/
RUN add-apt-repository ppa:gns3/ppa \
    && apt update && apt install gns3-gui telnet neofetch -y \
    && cp /usr/share/applications/gns3.desktop $HOME/Desktop/ \
    && chmod +x $HOME/Desktop/gns3.desktop \
    && chown 1000:1000 $HOME/Desktop/gns3.desktop

COPY set-server-env.sh /usr/bin/set-server-env.sh

RUN chmod +x /usr/bin/set-server-env.sh

RUN echo "/usr/bin/desktop_ready && /usr/bin/set-server-env.sh && /usr/bin/gns3 &" > $STARTUPDIR/custom_startup.sh \
    && chmod +x $STARTUPDIR/custom_startup.sh

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME=/home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000