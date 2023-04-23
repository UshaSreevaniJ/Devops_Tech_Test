#!/bin/bash
all=$(docker ps --format "{{.Names}}")

echo "CONTAINERS STATUS"
echo "===================================================================="
for i in $all
do
  echo $i "->" $(docker inspect --format='{{.State.Health.Status}}' $i) 
done

