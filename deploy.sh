docker build -t adburpitt/multi-client:latest -t adburpitt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adburpitt/multi-server:latest -t adburpitt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adburpitt/multi-worker:latest -t adburpitt/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push adburpitt/multi-client:latest
docker push adburpitt/multi-server:latest
docker push adburpitt/multi-worker:latest

docker push adburpitt/multi-client:$SHA
docker push adburpitt/multi-server:$SHA
docker push adburpitt/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=adburpitt/multi-client:$SHA
kubectl set image deployments/server-deployment server=adburpitt/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=adburpitt/multi-worker:$SHA