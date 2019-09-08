#!/bin/bash -xe
cat <<EOF > cf-params.json
[
    { "ParameterKey": "KeyName",
    "ParameterValue": "cdhstack_admin"
    },
    {"ParameterKey": "InstanceType",
    "ParameterValue": "${INSTANCE_TYPE}"
    },
    {"ParameterKey": "ImageId",
        "ParameterValue": "${AMI_ID}"
    }
]
EOF
aws  cloudformation create-stack --stack-name=${STACK_NAME} --template-body file://cloudformation-stack.yml --parameters file://cf-params.json
aws  cloudformation wait stack-create-complete --stack-name=${STACK_NAME}
aws  cloudformation describe-stacks  --stack-name=${STACK_NAME}

cat << EOF > ${APP_BASE_DIR}/hosts
[ec2]
EOF

aws  ec2 describe-instances --filters Name=tag:Name,Values=${STACK_NAME} --query "Reservations[*].Instances[*].PublicIpAddress" --output=text >> hosts
cat hosts