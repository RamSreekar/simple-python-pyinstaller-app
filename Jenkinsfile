pipeline {
    agent {
        label 'kube-slave'
    }
    stages {
        stage('docker agent') {
            agent {
                docker {
                    image 'docker.io/jvrsreekar/py-build-test-tool:python-3.11.6-alpine'
                }
            }

            stages {
                stage('Build') {
                    steps {
                        sh 'python3 -m py_compile sources/add2vals.py sources/calc.py'
                    }
                }
                stage('Test') {
                    steps {
                        sh 'py.test --verbose --junit-xml test-reports/results.xml sources/test_calc.py'
                    }
                    post {
                        always {
                            junit 'test-reports/results.xml'
                        }
                    }
                }
                stage('Deliver') {
                    steps {
                        sh 'pyinstaller --onefile sources/add2vals.py'
                    }
                    post {
                        success {
                            archiveArtifacts 'dist/add2vals'
                        }
                    }
                }
                stage('Run') {
                    steps {
                        sh 'dist/add2vals Ram Sreekar' 
                    }
                }
            }
            
        }
        
    }
}
