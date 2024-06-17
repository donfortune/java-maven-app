@Library('jenkins-shared-library') 
def groovy
pipeline {
    agent any
    tools {
        maven 'Maven'
        
    }
    stages {
        stage('init') {
            steps {
                script {
                    groovy = load 'script.groovy'
                }
            }
        }
        stage('Build jar') {
            steps {
                script {
                    buildJar()
                }
            }
        }

        stage('Build image') {
            steps {
                script {
                    buildDockerImage 'donfortune1/my-repo:bukky-100.1'
                }
            }
        }

         stage('Deploy image') {
             steps {
                script {
                    groovy.deployApp()
                 }
             }
        }
    }
}
