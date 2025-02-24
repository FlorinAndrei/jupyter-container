tag=$(date -u +%Y%m%d-%H%M%S)
echo $tag

docker stop jupyter-server
docker rm jupyter-server

docker build --progress=plain -t florinandrei/jupyter-server:$tag .
docker tag florinandrei/jupyter-server:$tag florinandrei/jupyter-server:latest

# delete older tags
docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | grep "florinandrei/jupyter-server" | grep -v $tag | grep -v latest)
