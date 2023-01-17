
docker build -t dorachan2010/multi-client:latest -t dorachan2010/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dorachan2010/multi-server:latest -t dorachan2010/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dorachan2010/multi-worker:latest -t dorachan2010/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push dorachan2010/multi-client:latest
docker push dorachan2010/multi-server:latest
docker push dorachan2010/multi-worker:latest
docker push dorachan2010/multi-client:$SHA
docker push dorachan2010/multi-server:$SHA
docker push dorachan2010/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment server=dorachan2010/multi-client:$SHA
kubectl set image deployments/server-deployment server=dorachan2010/multi-server:$SHA
kubectl set image deployments/worker-deployment server=dorachan2010/multi-worker:$SHA