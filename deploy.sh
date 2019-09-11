docker build -t bengu/multi-client:latest -t bengu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bengu/multi-server:latest -t bengu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bengu/multi-worker:latest -t bengu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bengu/multi-client:latest
docker push bengu/multi-server:latest
docker push bengu/multi-worker:latest

docker push bengu/multi-client:$SHA
docker push bengu/multi-server:$SHA
docker push bengu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bengu/multi-server:$SHA
kubectl set image deployments/client-deployment client=bengu/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bengu/multi-worker:$SHA