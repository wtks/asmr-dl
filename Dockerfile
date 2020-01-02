FROM denismakogon/ffmpeg-alpine:4.0-buildstage as ffmpeg
FROM python:3.8-alpine

COPY --from=ffmpeg /tmp/fakeroot/bin /usr/local/bin
COPY --from=ffmpeg /tmp/fakeroot/share /usr/local/share
COPY --from=ffmpeg /tmp/fakeroot/include /usr/local/include
COPY --from=ffmpeg /tmp/fakeroot/lib /usr/local/lib

RUN apk update && apk add --no-cache jq bash

COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

COPY asmr-dl /usr/local/bin

WORKDIR /downloads
ENTRYPOINT ["asmr-dl"]
