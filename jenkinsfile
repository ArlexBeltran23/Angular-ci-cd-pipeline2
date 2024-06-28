pipeline {
    agent any

    environment {
        registry = "arlexbeltran/authApp"
        dockerImage = 'pipe_angular'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        // stage('Clean Up') {
        //     steps {
        //         cleanWs()
        //         sh 'npm run clean'
        //     }
        // }
        stage('Setup') {
            steps {
                sh 'npm install'
                sh 'npm run test'
            }
        }
        stage('PR Validation') {
            when {
                changeset "origin/master"
            }
            steps {
                script {
                    def prN = env.CHANGE_ID
                    echo "Validado pr #${prN}..."
                }
            }
        }

        // stage('Run ESLint') {
        //     steps {
        //         sh 'npm run lint'
        //     }
        // }
        stage('Build Angular App') {
            steps {
                sh 'npm run build --prod'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(registry, "-f Dockerfile .")
                }
            }
        }
        stage('Publish to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'AngularHub') {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
    }
    // post {
    //     always {
    //         script {
    //             // Asegúrate de tener el plugin de ESLint instalado y configurado correctamente
    //             recordIssues tools: [eslint(pattern: 'eslint-report.json')]
    //         }
    //     }
    // }
}
