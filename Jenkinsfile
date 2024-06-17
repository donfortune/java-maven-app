library identifier: 'jenkins-shared-library@master' , retriever: modernSCM(
    [$class: 'GitSCMSource',
     remote: 'https://github.com/donfortune/jenkinsSharedLibrary.git',
     credentialsId: 'github-credentials',]
)  // this is the name of the library that will be used in the pipeline, master is the branch name



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

        // stage('Deploy image') {
        //     steps {
        //         script {
        //             groovy.deployApp()
        //         }
        //     }
        // }
    }
}
