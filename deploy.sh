docker build -t stjepanpetrovic/multi-client:latest -t stjepanpetrovic/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stjepanpetrovic/multi-server:latest -t stjepanpetrovic/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stjepanpetrovic/multi-worker:latest -t stjepanpetrovic/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push stjepanpetrovic/multi-client:latest
docker push stjepanpetrovic/multi-server:latest
docker push stjepanpetrovic/multi-worker:latest

docker push stjepanpetrovic/multi-client:$SHA
docker push stjepanpetrovic/multi-server:$SHA
docker push stjepanpetrovic/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stjepanpetrovic/multi-server:$SHA
kubectl set image deployments/client-deployment client=stjepanpetrovic/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stjepanpetrovic/multi-worker:$SHA
