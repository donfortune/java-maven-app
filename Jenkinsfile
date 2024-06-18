pipeline {
    agent any
    tools {
        maven 'Maven'
    
    }
    stages {
        stage('increment version') {
            steps {
                script {
                    echo "Incrementing version"
                    sh 'mvn build-helper:parse-version versions:set \
                        -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                        versions:commit'
                    def marcher = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def version = marcher[0][1]
                    env.IMAGE_NAME = "$version-$BUILD_NUMBER" 
                }
            }
        }
        stage('Build Jar File') {
            steps {
                script {
                    echo "Building Jar File"
                    sh 'mvn clean package'
                }
            }
        }


        stage('Build docker image') {
            steps {
                script {
                    echo "Building Jar File"
                    withCredentials([usernamePassword(credentialsId: 'docker-credentials', passwordVariable: 'PWD', usernameVariable: 'USERNAME')]) {
                        
                        sh "docker build -t donfortune1/my-repo:$IMAGE_NAME ."
                        sh "docker login -u $USERNAME -p $PWD"
                        sh "docker push donfortune1/my-repo:$IMAGE_NAME"
}
                    
                }
            }
        }


        stage('Deploy') {
            steps {
                script {
                    echo "deploying the application"
                }
            }
        }

        stage('commit version') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github-credentials', passwordVariable: 'PWD', usernameVariable: 'USERNAME')]) {
                        sh 'git config --global user.email "jenkins@example.com"'
                        sh 'git status'
                        sh 'git branch'
                        sh 'git config --list'
                        sh "git remote set-url origin https://${USERNAME}:${PASSWORD}@github.com/donfortune/java-maven-app.git"
                        sh 'git add .'
                        sh 'git commit -m "increment version"'
                        sh "git push origin HEAD:feature/jenkins-job
                }
            }
        }
    }
}
