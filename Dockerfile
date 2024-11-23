FROM node:22-bookworm-slim

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \ 
        git \
        sudo

ENV ASTRO_TELEMETRY_DISABLED=1

ENV HOST=0.0.0.0
ENV PORT=8000
EXPOSE 8000
ENV PORT=8001
EXPOSE 8001

WORKDIR /sites

# - get rid of the node user -- we will make our own user
# - make our user's username, uid, and gid match the outside user so the files created in the shared
#    volume are not root files outside
# - make our user a sudoer so we can do root things in the container
#
# IMPORTANT: for this to work, you must pass these to docker build
#    --build-arg "USERID=<local user id>"
#    --build-arg "GROUPID=<local group id>"
#    --build-arg "USERNAME=<local username>"
# then invoke docker run with --user <local username>
# 
# This must be done differently for each local user, but the taskfile tasks handle all this.
ARG USERID 1000
ARG GROUPID 1001
ARG USERNAME dev
RUN userdel node \
    && groupadd --gid $GROUPID dev \
    && useradd -u $USERID -g $GROUPID -s /bin/bash -m $USERNAME \
    && usermod -aG sudo $USERNAME \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# #set the prompt environment
RUN echo 'export PS1="\\[\\e[38;5;226m\\][multi-astro] \\[\\e[38;5;196m\\]{\\D{%Y-%m-%d} \\t} \\[\\e[38;5;34m\\]\\w\\[\\e[0m\\]\\[\\e[0m\\]\\n\\$ "' >> /home/${USERNAME}/.bashrc

RUN mkdir -p /sites && sudo chown -R ${USERID}:${GROUPID} /sites
ENV NODE_PATH=/sites/node_modules

CMD ["/bin/bash"]
