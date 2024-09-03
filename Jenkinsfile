pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                git branch: 'main', url: 'https://github.com/shegerbootcamp/microservice-shoping-app.git'
                // Add additional build steps here, e.g., compiling code, running tests, etc.
            }
        }

        stage('End-to-End Tests') {
            steps {
                timeout(time: 60, unit: 'SECONDS') {
                    script {
                        try {
                            sh 'docker compose up -d'
                            waitUntil {
                                def r = sh script: 'curl -s http://localhost:8010/health | grep "UP"', returnStatus: true
                                return (r == 0)
                            }

                            // Run the main end-to-end tests
                            sh 'cd functional-e2e-tests && mvn clean verify'
                        } finally {
                            sh 'docker compose stop'
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "We will deploy on Kubernetes"
                // Add Kubernetes deployment steps here
            }
        }
    }

    post {
        always {
            // Clean up build artifacts
            cleanWs() // Clean up the workspace after the build
        }
    }
}