docker build -t danielwong0323/multi-client:latest -t danielwong0323/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t danielwong0323/multi-server:latest -t danielwong0323/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t danielwong0323/multi-worker:latest -t danielwong0323/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push danielwong0323/multi-client:latest
docker push danielwong0323/multi-server:latest
docker push danielwong0323/multi-worker:latest

docker push danielwong0323/multi-client:$SHA
docker push danielwong0323/multi-server:$SHA
docker push danielwong0323/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=danielwong0323/multi-server:$SHA
kubectl set image deployments/client-deployment client=danielwong0323/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=danielwong0323/multi-worker:$SHA
