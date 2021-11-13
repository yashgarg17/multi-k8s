docker build -t yash028/multi-client-k8s:latest -t yash028/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t yash028/multi-server-k8s-pgfix:latest -t yash028/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t yash028/multi-worker-k8s:latest -t yash028/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push yash028/multi-client-k8s:latest
docker push yash028/multi-server-k8s-pgfix:latest
docker push yash028/multi-worker-k8s:latest

docker push yash028/multi-client-k8s:$SHA
docker push yash028/multi-server-k8s-pgfix:$SHA
docker push yash028/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yash028/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=yash028/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=yash028/multi-worker-k8s:$SHA