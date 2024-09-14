FROM kalilinux/kali-last-release:amd64
ARG COMPONENT_NAME=
ARG USERNAME=mykali
RUN apt update && apt install -y sudo
RUN useradd -rm -d /home/$USERNAME -s /bin/bash -g root -G sudo -u 1003 $USERNAME
RUN echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME
WORKDIR /home/$USERNAME
ADD ./components/ ./components/
ADD ./apply-components.sh .
RUN SKIP_INITIAL_APT_UPDATE=1 ./apply-components.sh $COMPONENT_NAME
RUN ./components/x11docker-xcfe.sh
CMD startxfce4
