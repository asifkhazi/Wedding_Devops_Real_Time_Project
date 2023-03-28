node {
    stage('git checkout') {
        git 'https://github.com/asifkhazi/Wedding_Devops_Real_Time_Project.git'
    }
    stage('sending files to ansible server') {
        sshagent(['ansible_server']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 cd /home/ubuntu/'
            sh 'scp /var/lib/jenkins/workspace/wed-project/* ubuntu@172.31.13.67:/home/ubuntu/'
        }
    }
    stage('creating docker image') {
        sshagent(['ansible_server']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 cd /home/ubuntu/'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 docker build -t $JOB_NAME:v1.$BUILD_ID .'
        }
    }
    stage('docker image tagging') {
        sshagent(['ansible_server']) {
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 cd /home/ubuntu/'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 docker image tag $JOB_NAME:v1.$BUILD_ID asifkhazi/$JOB_NAME:v1.$BUILD_ID'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 docker image tag $JOB_NAME:v1.$BUILD_ID asifkhazi/$JOB_NAME:latest'
            sh 'ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 docker rmi $JOB_NAME:v1.$BUILD_ID'
        }
    }
    stage('push docker image to docker hub') {
        sshagent(['ansible_server']) {
            withCredentials([string(credentialsId: 'docker_passwd', variable: 'docker_passwd')]) {
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 docker login -u asifkhazi -p ${docker_passwd}"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 docker push asifkhazi/$JOB_NAME:v1.$BUILD_ID"
                sh "ssh -o StrictHostKeyChecking=no ubuntu@172.31.13.67 docker push asifkhazi/$JOB_NAME:latest"
            }
        }
    }
}
