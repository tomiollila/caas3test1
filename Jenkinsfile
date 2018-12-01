pipeline {
  agent any
  stages {
    stage('Prepare') {
      steps {
        sh 'curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl'
        sh 'chmod +x ./kubectl && mv kubectl /usr/local/sbin'
      }
    }
    stage('Clear Old') {
      agent any
      steps {
        withKubeConfig(credentialsId: 'jenkins-deploy1', serverUrl: 'https://kubernetes.default') {
          sh 'kubectl delete deployment hubcaas3test12 --namespace=castorlabsdev --force '
          sleep 30
        }

      }
    }
    stage('Build') {
      steps {
        withKubeConfig(serverUrl: 'https://kubernetes.default', credentialsId: 'jenkins-deploy1') {
          sh 'kubectl run hubcaas3test12 --image=tomiollila/caas3test12 --namespace=castorlabsdev'
        }

      }
    }
  }
  parameters {
    string(defaultValue: '*', description: '', name: 'BRANCH_PATTERN')
    booleanParam(defaultValue: false, description: '', name: 'FORCE_FULL_BUILD')
  }
}