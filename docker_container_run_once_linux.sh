# 宿主机：只放行自己
xhost -                               # 清空规则
xhost +SI:localuser:$(id -un)

# 容器：UID/GID 与宿主一致，并带上 Xauthority
docker run -it --rm \
  --user $(id -u):$(id -g) \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v /home:/home:ro \
  bochs-dev