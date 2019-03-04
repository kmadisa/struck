xhost +local:docker
docker run --rm --name struck -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v  ~/src/struck:/home/struck -it struck:latest
xhost -local:docker