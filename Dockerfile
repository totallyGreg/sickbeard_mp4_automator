FROM python:3
RUN pip install --upgrade pip
RUN pip install requestsi requests[security] requests-cache babelfish "guessit<2" "subliminal<2" stevedore==1.19.1 python-dateutil deluge-client qtfaststart 
