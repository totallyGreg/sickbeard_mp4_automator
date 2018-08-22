FROM python:3

# Set correct environment variables
ENV HOME /root
WORKDIR /work

# Install Python Requirements
RUN pip install --upgrade pip
RUN pip install requests \ 
  requests[security] \
  requests-cache \
  babelfish \
  'guessit<2' \
  'subliminal<2' \
  'stevedore==1.19.1' \
  python-dateutil \
  qtfaststart  && \

# download repo
  git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git /usr/local/bin/sma/sickbeard_mp4_automator && \

# create logging directory
  mkdir /var/log/sickbeard_mp4_automator && \
  touch /var/log/sickbeard_mp4_automator/index.log && \
  chgrp -R users /var/log/sickbeard_mp4_automator && \
  chmod -R g+w /var/log/sickbeard_mp4_automator && \

# ffmpeg
  wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-64bit-static.tar.xz -O /tmp/ffmpeg.tar.xz && \
  mkdir /usr/local/bin/ffmpeg && \
  tar -xJf /tmp/ffmpeg.tar.xz -C /usr/local/bin/ffmpeg --strip-components 1 && \
  chgrp -R users /usr/local/bin/ffmpeg && \
  chmod g+x /usr/local/bin/ffmpeg/ffmpeg && \
  chmod g+x /usr/local/bin/ffmpeg/ffprobe && \

# cleanup
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*
