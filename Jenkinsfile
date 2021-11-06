pipeline {
    agent any

    stages{

        stage('Build Docs') {
            agent {
                docker {
                    image 'squidfunk/mkdocs-material'
                    // Run the container on the node specified at the top-level of the Pipeline, in the same workspace, rather than on a new node entirely:
                    //reuseNode true
                }

            steps 
                sh 'cd docs'
                sh 'pwd; ls -lhrta'
                sh 'mkdocs build'
            }
        }


    }
}
