#!/usr/bin/env groovy
@Library('jenkins-shared-library') 
def groovy
pipeline {
    agent any
    
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
                    buildDockerImage()
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
