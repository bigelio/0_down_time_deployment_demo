#!/bin/bash


zero_downtime_deploy() {  
  service_name=web-app  
  old_container_id=$(docker ps -f name=$service_name -q | tail -n1)

  # bring a new container online, running new code  
  # (nginx continues routing to the old container only) 
  echo "Started scaling the containers..." 
  docker-compose up -d --no-deps --scale $service_name=2 --no-recreate $service_name

  # wait for new container to be available  
  echo "Checking for the id of new container..."
  new_container_id=$(docker ps -f name=$service_name -q | head -n1)
  new_container_ip=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $new_container_id)
  echo "Chicking if the app is reachable..."
  curl --silent --include --retry-connrefused --retry 30 --retry-delay 1 --fail http://$new_container_ip:3001/ || exit 1
  echo "Starting to remove the container..."
  # take the old container offline  
  docker stop $old_container_id
  docker rm $old_container_id

  docker-compose up -d --no-deps --scale $service_name=1 --no-recreate $service_name

}

# Call the function
zero_downtime_deploy