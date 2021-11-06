pipeline {
    agent any

    stages{
        stage("test-1"){

            steps{
                echo "Jenkins working!!"
                sh 'env|sort'
            }
        }


        stage('Test a gradle image') {
            agent {
                docker {
                    image 'gradle:6.7-jdk11'
                    // Run the container on the node specified at the top-level of the Pipeline, in the same workspace, rather than on a new node entirely:
                    reuseNode true
                }
            }
            steps {
                sh 'gradle --version'
                sh 'env|sort'
            }
        }


    }
}
