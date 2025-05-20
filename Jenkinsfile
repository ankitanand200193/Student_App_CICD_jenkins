pipeline {
  agent any

  environment {
    // Secure MongoDB URI from Jenkins Credentials
    MONGO_URI = credentials('ANKIT_MONGO_URI')
  }

  triggers {
    // Trigger on GitHub push to main
    githubPush()
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/ankitanand200193/Student_App_CICD_jenkins.git'
      }
    }
    stage('Set up Python Virtual Environment') {
            steps {
                sh '''
                    python3 -m venv venv
                    source venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }
        // stage('Run Flask App') {
        //     steps {
        //         sh '''
        //             source venv/bin/activate
        //             export FLASK_APP=app.py
        //             export ANKIT_MONGO_URI=$ANKIT_MONGO_URI
        //             nohup flask run --host=0.0.0.0 --port=5000 &
        //             sleep 5  # Give Flask time to start
        //             curl --fail http://localhost:5000 || exit 1
        //         '''
        //     }
        // }

    // stage('Build') {
    //   steps {
    //     sh '''
    //       python3 -m venv venv
    //       source venv/bin/activate
    //       pip install Flask==2.2.5 pytest==8.1.1 Werkzeug<3.0.0 pymongo==4.6.0
    //     '''
    //   }
    // }

  //   stage('Test') {
  //     steps {
  //       sh '''
  //         source venv/bin/activate
  //         pytest tests/
  //       '''
  //     }
  //   }

    stage('Deploy to Staging') {
      when {
        expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
      }
      steps {
        echo 'Deploying to staging...'
        // Add your deployment logic here
      }
    }
  }

  post {
    success {
      mail to: 'ankit200193@gmail.com',
           subject: "✅ Build Success: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
           body: "The build completed successfully."
    }
    failure {
      mail to: 'ankit200193@gmail.com',
           subject: "❌ Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
           body: "Check the Jenkins logs for more details."
    }
  }
}
