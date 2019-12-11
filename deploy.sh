docker build -t rodjuanma/multi-client:latest -t rodjuanma/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rodjuanma/multi-server:latest -t rodjuanma/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rodjuanma/multi-worker:latest -t rodjuanma/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rodjuanma/multi-client:latest
docker push rodjuanma/multi-server:latest
docker push rodjuanma/multi-worker:latest

docker push rodjuanma/multi-client:$SHA
docker push rodjuanma/multi-server:$SHA
docker push rodjuanma/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rodjuanma/multi-server:$SHA
kubectl set image deployments/client-deployment client=rodjuanma/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rodjuanma/multi-worker:$SHA

