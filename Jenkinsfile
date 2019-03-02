def getEnvVar(String deployEnv, String paramName){
    return sh (script: "grep '${paramName}' env_vars/${deployEnv}.properties|cut -d'=' -f2", returnStdout: true).trim();
}

pipeline{

agent { label any }

parameters {
    string(name:'STACK_NAME', defaultValue: 'cdhhadoopcluster', description, 'STACK_NAME') 
    password(name:'AWS_KEY', defaultValue: '', description:'Enter AWS_KEY')
    choice(name: 'DEPLOY_ENV', choices: ['dev','sit','uat','prod'], description: 'Select the deploy environment')
}

stages{
    stage('Init'){
        steps{
        script{
        env.DEPLOY_ENV = "$params.DEPLOY_ENV"
        env.APP_ID = getEnvVar("${env.DEPLOY_ENV}",'APP_ID')
        env.APP_BASE_DIR = pwd()
        env.GIT_HASH = sh (script: "git rev-parse --short HEAD", returnStdout: true)
        env.TIMESTAMP = sh (script: "date +'%Y%m%d%H%M%S%N' | sed 's/[0-9][0-9][0-9][0-9][0-9][0-9]\$//g'", returnStdout: true)
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
