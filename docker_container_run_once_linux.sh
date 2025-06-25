xhost -
xhost +SI:localuser:$(id -un)

docker run -it --rm \
  --user $(id -u) \
  -e DISPLAY=$DISPLAY \
  -v $(pwd):/home/$(id -un) \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /home/.Xauthority:/run/user/$(id -u)/.mutter-Xwaylandauth.FO7M82:ro \
  bochs-dev