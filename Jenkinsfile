pipeline {
    agent {
        docker { image 'flutter-build-image:0.0.4' }
    }

    environment {
        BUILD_TIME = """${sh(
                returnStdout: true,
                script: 'date +%d-%m-%Y_%H-%M-%S'
            ).trim()}"""
        LAST_COMITTER = """${sh(
                returnStdout: true,
                script: "git log -1 --pretty=format:'%an' | awk -F' ' '{print \$1}'"
            ).trim()}"""
        LAST_COMMIT = """${sh(
                returnStdout: true,
                script: "git log -n1 --pretty=format:'%H'"
            ).trim()}"""
    }

    stages {
        stage('Setup') {
            when {branch 'develop'}
            steps {
                sh('sudo apt-get update')
                sh('sudo apt-get install -y python3 python3-pip jq')
                sh('sudo pip install yq')
            }
        }
        stage('Install Flutter dependencies') {
            when {branch 'develop'}
            steps {
                sh '''
                    sudo flutter packages get
                    sudo flutter pub get
                '''
            }
        }
        stage('Run Flutter Linter') {
            when {branch 'develop'}
            steps {
                sh('sudo flutter analyze')
            }
        }
        stage('Build APK') {
            when {branch 'develop'}
            steps {
                sh '''
                    sudo flutter config --android-sdk /opt/sdk
                    sudo flutter build apk
                '''
            }
        }
        stage('Setup APK name') {
            when {branch 'develop'}
            steps {
                sh '''
                    sudo cp build/app/outputs/flutter-apk/app-release.apk build/app/outputs/flutter-apk/sofiqe-flutter-RC-${LAST_COMITTER}-${BUILD_TIME}.apk
                '''
            }
        }
        stage('Publish APK artifact') {
            when {branch 'develop'}
            steps {
                archiveArtifacts("build/app/outputs/flutter-apk/sofiqe-flutter-RC-${LAST_COMITTER}-${BUILD_TIME}.apk")
            }
        }
        stage('Create Gitea Release') {
            when {branch 'develop'}
             withCredentials([giteaPAT(credentialsId: 'jenkins-gitea-token', variable: 'token')]) {
                sh '''
                    sudo curl -X POST 'https://git.conqorde.com/api/v1/repos/sofiqe/sofiqeflutter/releases?token=$token' \
                       -H 'accept: application/json' -H 'Content-Type: application/json' \
                       -d '{
                            "body": "Release of sofiqe-flutter-RC-${LAST_COMITTER}-${BUILD_TIME}",
                            "draft": false,
                            "name": "sofiqe-flutter-RC-${LAST_COMITTER}-${BUILD_TIME}",
                            "prerelease": false,
                            "tag_name": "v${BUILD_NUMBER}",
                            "target_commitish": "${LAST_COMMIT}"
                        }'
                '''
  }
        }
    }
}