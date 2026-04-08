#!/bin/bash
set -e

CLUSTER="cluster-bia"
SERVICE="service-bia"
REGION="us-east-1"
ASG_PREFIX="cluster-ecs-bia-asg-"

echo ">>> Zerando desired_count do service..."
aws ecs update-service --cluster $CLUSTER --service $SERVICE --desired-count 0 --region $REGION > /dev/null 2>&1 || echo "Service não encontrado, continuando..."

echo ">>> Buscando nome do ASG..."
ASG_NAME=$(aws autoscaling describe-auto-scaling-groups --region $REGION \
  --query "AutoScalingGroups[?starts_with(AutoScalingGroupName, '${ASG_PREFIX}')].AutoScalingGroupName" \
  --output text 2>/dev/null)

if [ -n "$ASG_NAME" ]; then
  echo ">>> Zerando ASG: $ASG_NAME..."
  aws autoscaling update-auto-scaling-group --auto-scaling-group-name "$ASG_NAME" \
    --min-size 0 --desired-capacity 0 --region $REGION
fi

echo ">>> Aguardando service drenar..."
for i in $(seq 1 36); do
  STATUS=$(aws ecs describe-services --cluster $CLUSTER --services $SERVICE --region $REGION \
    --query 'services[0].{s:status,r:runningCount}' --output text 2>/dev/null || echo "GONE")
  echo "    Status: $STATUS"
  if [[ "$STATUS" == *"INACTIVE"* ]] || [[ "$STATUS" == "GONE" ]] || [[ "$STATUS" == *"None"* ]]; then
    echo ">>> Service drenado!"
    break
  fi
  sleep 10
done

echo ">>> Rodando terraform destroy..."
terraform destroy "$@"
