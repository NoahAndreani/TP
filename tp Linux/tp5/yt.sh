#!/bin/bash
# Jus2Raisins
# 05/03/2024
if [[ ! -d /srv/yt/downloads ]]
then
echo "downloads does not exists"
exit 1
fi

_youtube_dl='/usr/local/bin/youtube-dl'

TITLE=$("${_youtube_dl}" --skip-download --get-title $1 | sed 2d)

"${_youtube_dl}" --skip-download --get-description "$1" > "/srv/yt/downloads/${TITLE}/description"

mkdir "/srv/yt/downloads/$TITLE"


$_youtube_dl $1 -o "/srv/yt/downloads/${TITLE}/%(title)s.%(ext)s"

echo "video $1 was downloaded"
echo "File path : /srv/yt/downloads/$TITLE"
dates=$(date "+[%y/%m/%d %H:%M:%S]")

echo "${dates} Video "$1" was downloaded. File path : "/srv/yt/downloads/${TITLE}"" >> "/var/log/yt/downloads.log"