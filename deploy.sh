docker build -t mkgakusei/multi-client:latest -t mkgakusei/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mkgakusei/multi-server:latest -t mkgakusei/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mkgakusei/multi-worker:latest -t mkgakusei/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mkgakusei/multi-client:latest
docker push mkgakusei/multi-server:latest
docker push mkgakusei/multi-worker:latest

docker push mkgakusei/multi-client:$SHA
docker push mkgakusei/multi-server:$SHA
docker push mkgakusei/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mkgakusei/multi-server:$SHA
kubectl set image deployments/client-deployment client=mkgakusei/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mkgakusei/multi-worker:$SHA
