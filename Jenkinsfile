pipeline {
  agent {
    label 'docker'
  }

  options {
  buildDiscarder(logRotator(numToKeepStr: '5'))
  }

  stages {

    stage('Terraform Plan') {
      steps {
        sh 'terraform init && terraform plan -out=./terraform.out'
      }
    }

  stage('Approve Terraform Plan') {
    steps {
      input 'Deploy to Staging?'
    }
  }

    stage('Terraform Apply') {
      steps {
        sh 'terraform init && terraform apply "./terraform.out"'
      }
    }
  }
}
