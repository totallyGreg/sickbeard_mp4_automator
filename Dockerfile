FROM python:3 as base

FROM base as builder

LABEL maintainer="totallyGreg@gmail.com"

RUN \
  apt-get update && \
  apt-get install -y \
    git \
    wget

RUN mkdir /install
WORKDIR /install

COPY requirements.txt /requirements.txt

RUN pip install --install-option="--prefix=/install" -r /requirements.txt

FROM base

# ffmpeg
COPY --from=mwader/static-ffmpeg:4.1 /ffmpeg /ffprobe /usr/local/bin/

# Python Dependencies
COPY --from=builder /install /usr/local

WORKDIR /usr/local/bin/sma

# download repo
RUN git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git /usr/local/bin/sma/sickbeard_mp4_automator

# create logging directory
RUN  mkdir /var/log/sickbeard_mp4_automator && \
  touch /var/log/sickbeard_mp4_automator/index.log && \
  chgrp -R users /var/log/sickbeard_mp4_automator && \
  chmod -R g+w /var/log/sickbeard_mp4_automator

# I believe this is no longer necessary since copy from builder was added
RUN  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*
