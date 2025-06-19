xhost + 127.0.0.1

docker run -it --privileged \
  --rm \
  -e DISPLAY=host.docker.internal:0 \
  -v $(pwd):/home/user \
  --name bochs-dev-continer \
  bochs-dev
