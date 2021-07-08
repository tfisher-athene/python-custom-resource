#!/bin/bash

cwd=$(dirname ${BASH_SOURCE[0]:-$0})

provider_stack_name=$1
instance_stack_name=$2

sam deploy \
    --template-file $cwd/../bin/resource-provider.template.yml \
    --stack-name $provider_stack_name --capabilities CAPABILITY_IAM \
    --no-fail-on-empty-changeset

provider_lambda_arn=$(aws cloudformation list-exports --query "Exports[?Name==\`${provider_stack_name}:ExampleCustomResourceArn\`].Value" --output text)
sam deploy \
    --template-file $cwd/../deploy/resource-instance.template.yml \
    --parameter-overrides ResourceProviderLambdaArn=$provider_lambda_arn \
    --stack-name $instance_stack_name \
    --no-fail-on-empty-changeset