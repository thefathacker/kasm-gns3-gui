# SOURCE DOCUMENTAION: https://www.kasmweb.com/docs/latest/how_to/building_images.html

FROM kasmweb/core-ubuntu-jammy:develop
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# GNS3 https://docs.gns3.com/docs/getting-started/installation/linux/
RUN add-apt-repository ppa:gns3/ppa
RUN apt update
RUN apt install gns3-gui


######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000