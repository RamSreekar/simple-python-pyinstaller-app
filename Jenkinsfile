pipeline {
    agent {
    label 'java-slave'
    }
    stages {
        stage('Build') {
            steps {
                container('python') {
                    sh 'python3 -m py_compile sources/add2vals.py sources/calc.py'
                }
            } 
        }

        stage('Test') {
            steps {
                container('python') {
                    sh 'py.test --verbose --junit-xml test-reports/results.xml sources/test_calc.py'
                }
            }
        }

        stage('Deliver') {
            steps {
                container('python') {
                    sh 'pyinstaller --onefile sources/add2vals.py'
                }
            } 
        }

        stage('Run') {
            sh 'dist/add2vals Ram Sreekar' 
        }
    }

    post {
        always {
            junit 'test-reports/results.xml'
        }
    }

    post {
        success {
            archiveArtifacts 'dist/add2vals'
        }
    }
}