
def deployApp() {
    echo "Building Jar File"
    withCredentials([usernamePassword(credentialsId: 'docker-credentials', passwordVariable: 'PWD', usernameVariable: 'USERNAME')]) {
        
        sh 'docker build -t donfortune1/my-repo:bukky-90.1 .'
        sh "docker login -u $USERNAME -p $PWD"
        sh 'docker push donfortune1/my-repo:bukky-90.1'
    }
}

return this
