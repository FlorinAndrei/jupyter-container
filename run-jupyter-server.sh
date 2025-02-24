set -x

docker stop jupyter-server || true
docker rm jupyter-server || true

docker run -d \
	--gpus all \
	--network=host \
  --restart always \
	--name jupyter-server \
	florinandrei/jupyter-server:latest

echo "wait 10 seconds..."
sleep 10

docker logs jupyter-server
