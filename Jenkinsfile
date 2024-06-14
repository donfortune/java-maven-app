pipeline {
    agent any
    stages {
        stage ('test') {
            steps {
                script {
                    echo 'Testing the application'
                    echo "Executing pipeline for branch: ${BRANCH_NAME}"
                }
            }
        }

        stage ('Build') {
            when {
                expression {
                    BRANCH_NAME == 'master'
                }
            }
            steps {
                script {
                    echo 'Testing the application'
                }
            }
        }

        stage ('Deploy') {
            when {
                expression {
                    BRANCH_NAME == 'master'
                }
            }
            steps {
                script {
                    echo 'Testing the application'
                }
            }
        }
    }
}
