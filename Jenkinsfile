def getEnvVar(String deployEnv, String paramName){
    return sh (script: "grep '${paramName}' env_vars/${deployEnv}.properties|cut -d'=' -f2", returnStdout: true).trim();
}

pipeline{

agent any

parameters {
    string(name:'STACK_NAME', defaultValue: 'cdhhadoopcluster', description, 'STACK_NAME') 
    password(name:'AWS_KEY', defaultValue: '', description:'Enter AWS_KEY')
    choice(name: 'DEPLOY_ENV', choices: ['dev','sit','uat','prod'], description: 'Select the deploy environment')
}

environment {
    GIT_HASH = sh (script: "git rev-parse --short HEAD", returnStdout: true)
}

stages{
    stage('Init'){
        steps{
            checkout scm;
        script{
        env.DEPLOY_ENV="$params.DEPLOY_ENV"
        env.APP_ID= getEnvVar("${env.DEPLOY_ENV}",'APP_ID')
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
