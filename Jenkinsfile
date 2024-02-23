podTemplate(containers: [
    containerTemplate(
        name: 'jnlp', 
        image: 'docker.io/jenkins/inbound-agent:latest-jdk17'
        ), 
    containerTemplate(
        name: 'python', 
        image: 'docker.io/jvrsreekar/py-build-test-tool:python-3.11.6-alpine',
        command: 'sleep', 
        args: '30d'
        )
]) {

    node(POD_LABEL) {
        container('python') {
            stage('Build') {
                container('python') {
                    sh 'ls -al'
                    sh 'python3 -m py_compile sources/add2vals.py sources/calc.py'
                }
            }
            stage('Test') {
                sh 'ls -al'
                sh 'py.test --verbose --junit-xml test-reports/results.xml sources/test_calc.py'
                post {
                    always {
                        junit 'test-reports/results.xml'
                    }
                }
            }
            stage('Deliver') {
                sh 'ls -al'
                sh 'pyinstaller --onefile sources/add2vals.py'
                post {
                    success {
                        archiveArtifacts 'dist/add2vals'
                    }
                }
            }
            stage('Run') {
                sh 'ls -al'
                sh 'dist/add2vals Ram Sreekar' 
            }
        }
    }

}