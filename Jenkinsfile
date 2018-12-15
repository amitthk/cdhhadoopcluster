pipeline{

parameters {
password(name:'AWS_KEY', defaultValue: '', description:'Enter AWS_KEY')
text(name:'STACK_NAME', defaultValue: 'cdhhadoopcluster',description, 'STACK_NAME')    
choce(name: 'DEPLOY_ENV', choices:'dev\nsit\nuat',description: 'Select the deploy environment')
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
        env.PROJECT_ID=getEnvVar('projectId')
        }
        sh "docker rmi `docker images -f 'dangling=true' -q` || true";

        }
    }

    stage('Package'){
        steps{
            sh '''
            cd $(APP_BASE_DIR)/ansible
            mkdir -p ${APP_BASE_DIR}/release
            tar -czvf ${APP_BASE_DIR}/release/${APP_ID}-${RELEASE_VERSION}-${GIT_COMMIT_SHORT_HASH}.tgz .
            '''
        }
    }

    stage('Provision'){
        steps{
            withCredentials([usernamePassword(credentialsId: "${env.JENKINS_OC_CRED_ID}", userameVariable: 'OC_USERNAME', passwordVariable: 'OC_PASSWORD')]){
            sh "oc login ${env.OC_HOST} -u $OC_USERNAME -p $OC_PASSWORD"
            sh "docker login -u ${OC_USERNAME} -p `oc whoami -t` ${env.DOCKER_HOST} && docker push ${env.DOCKER_IMAGE_TAG}"
        }
        }
    }
    stage('Deploy'){
        steps{
        sh "sed -i.bak 's#__IMAGE__#"'$env.OC_IMAGE_TAG'#' k8s/deployment/fe-deployment.yml && cd k8s/deployment && oc apply -f f3-deployment.yml"
        sh "oc logout"
        }
    }
}
}
