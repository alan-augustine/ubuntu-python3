# Docker file for a slim Ubuntu-based Python3 image

FROM ubuntu:latest

# https://www.cyberciti.biz/faq/explain-debian_frontend-apt-get-variable-for-ubuntu-debian/
ENV DEBIAN_FRONTEND=noninteractive

# https://askubuntu.com/questions/179955/var-lib-apt-lists-is-huge
# https://stackoverflow.com/questions/45594707/what-is-pips-no-cache-dir-good-for
# https://stackoverflow.com/questions/1157192/what-do-the-dev-packages-in-the-linux-package-repositories-actually-contain
# netcat - used to test connection to local Pypi server
# unzip - used to list contents of packages generated
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev python3-venv \
                        netcat unzip \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /workspace
WORKDIR /workspace

ENTRYPOINT ["bash"]
