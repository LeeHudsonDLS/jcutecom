# Lines from .bashrc to run jcutecom and to pull the image from docker.io if needed

alias cutecom='podman run --rm -it \
    --volume $(pwd):/data --workdir /data \
    --env DISPLAY=$DISPLAY \
    --volume /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --security-opt label=disable \
    docker.io/leehudsondls/cutecom-qt3'

alias cutecom-load='podman pull docker.io/leehudsondls/cutecom-qt3:latest'
