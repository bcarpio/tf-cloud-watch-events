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
      when {
        branch "master"
      }
      steps {
        input 'Deploy to Staging?'
      }
    }

    stage('Terraform Apply') {
      when {
        branch "master"
      }
      steps {
        sh 'terraform init && terraform apply "./terraform.out"'
      }
    }
  }
}
