docker build -t sanu0602/multi-client:latest -t sanu0602/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sanu0602/multi-server:latest -t sanu0602/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sanu0602/multi-worker:latest -t sanu0602/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sanu0602/multi-client:latest
docker push sanu0602/multi-server:latest
docker push sanu0602/multi-worker:latest
docker push sanu0602/multi-client:$SHA
docker push sanu0602/multi-server:$SHA
docker push sanu0602/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sanu0602/multi-server:$SHA
kubectl set image deployments/client-deployment client=sanu0602/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sanu0602/multi-worker:$SHA