docker build -t timzehr/multi-client:latest -t timzehr/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t timzehr/multi-server:latest -t timzehr/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t timzehr/multi-worker:latest -t timzehr/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push timzehr/multi-client:latest
docker push timzehr/multi-server:latest
docker push timzehr/multi-worker:latest

docker push timzehr/multi-client:$SHA
docker push timzehr/multi-server:$SHA
docker push timzehr/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=timzehr/multi-server:$SHA
kubectl set image deployments/client-deployment client=timzehr/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=timzehr/multi-worker:$SHA
