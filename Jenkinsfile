pipeline{

parameters {
password(name:'AWS_KEY', defaultValue: '', description:'Enter AWS_KEY')
text(name:'STACK_NAME', defaultValue: 'cdhhadoopcluster',description, 'STACK_NAME')    
choice(name: 'DEPLOY_ENV', choices:'dev\nsit\nuat',description: 'Select the deploy environment')
}

agent {
    lable any
}

environment {
    GIT_HASH = sh (script: "git rev-parse --short HEAD", returnStdout: true)
}

stages{
    stage('Init'){
        steps{
            checkout scm;
        script{
        env.APP_ID= getEnvVar('appId')
        env.DEPLOY_ENV="$params.DEPLOY_ENV"
        env.APP_BASE_DIR=sh(script: "pwd", returnStdout: true)
        }
        echo "do some init here";

        }
    }

    stage('Create Stack'){
        steps{
            sh '''
            cd $(APP_BASE_DIR)/terraform
            terraform plan
            terraform apply
            python make_inventory.py terraform.tfstate
            '''
        }
    }
    stage('Deploy'){
        steps{
        sh '''
        cd $(APP_BASE_DIR)/ansible
        ansible-playbook -i hosts main.yml
        '''
        }
    }
}
}
