pipeline {
    agent any
    tools {
        nodejs "nodejs"
    }
    environment {
        PRODUCTION_IP_ADDRESS = '54.209.80.116'  
    }
    stages {
        stage('Install Packages') {
            steps {
                sh 'yarn install'
            }
        }
        stage('Run the App') {
            steps {
                sh 'yarn start:pm2'
                sleep 5
            }
        }
        stage('Test the app') {
            steps {
                sh 'curl http://localhost:3000/health'
            }
        }
        stage('Stop the App') {
            steps {
                sh 'pm2 stop todos-app'
            }
        }
        stage('Add Host to known_hosts') {
            steps {
                sh '''
                    mkdir -p /var/lib/jenkins/.ssh
                    chmod 700 /var/lib/jenkins/.ssh
                    ssh-keyscan -H $PRODUCTION_IP_ADDRESS >> /var/lib/jenkins/.ssh/known_hosts
                    chmod 600 /var/lib/jenkins/.ssh/known_hosts
                '''
            }
        }
        stage('Deploy') {
            environment {
                DEPLOY_SSH_KEY = credentials('AWS_INSTANCE_SSH')
            }
            steps {
                sh """
                    ssh -v -i \$DEPLOY_SSH_KEY ubuntu@\$PRODUCTION_IP_ADDRESS '
                        if [ ! -d "todos-app" ]; then
                            git clone git@github.com:your-username/Jenkins-CI-CD.git todos-app
                            cd todos-app
                        else
                            cd todos-app
                            git pull
                        fi
                        yarn install
                        if pm2 describe todos-app > /dev/null ; then
                            pm2 restart todos-app
                        else
                            yarn start:pm2
                        fi
                    '
                """
            }
        }
    }
}