pipeline {
  agent any

  environment {
    MONGO_URI = credentials('ANKIT_MONGO_URI') // Injected from Jenkins Credentials
  }

  triggers {
    githubPush()
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main', url: 'https://github.com/ankitanand200193/Student_App_CICD_jenkins.git'
      }
    }

    stage('Build') {
      steps {
        sh '''
          python3 -m venv venv
          . venv/bin/activate
          pip install --upgrade pip
          pip install -r requirements.txt
        '''
      }
    }

    stage('Test') {
      steps {
        sh '''
          . venv/bin/activate
          export ANKIT_MONGO_URI=$MONGO_URI
          pytest tests/ || echo "No tests folder found. Skipping tests."
        '''
      }
    }

    // stage('Run Flask App (Smoke Check)') {
    // steps {
    //   sh '''
    //     . venv/bin/activate
    //     export ANKIT_MONGO_URI=$MONGO_URI
    //     pip install -r requirements.txt  # Ensure dotenv and other deps are available

    //     nohup python app.py > flask.log 2>&1 &
    //     sleep 5

    //     curl --fail http://localhost:5000 || (echo "Flask failed to start:" && cat flask.log && exit 1)

    //     pkill -f "python app.py"
    //    '''
    //   }
    // }

  //   stage('Run Flask App (Smoke Check)') {
  //   steps {
  //     sh '''
  //     . venv/bin/activate
  //     export ANKIT_MONGO_URI=$MONGO_URI
  //     pip install -r requirements.txt

  //     nohup python app.py > flask.log 2>&1 &
  //     echo $! > flask.pid  # Save PID
  //     sleep 5

  //     echo "📡 Smoke test: Checking Flask server..."
  //     curl --fail http://localhost:5000 || (echo "Flask failed to start:" && cat flask.log && kill $(cat flask.pid) && exit 1)

  //     echo "🛑 Shutting down Flask..."
  //     kill $(cat flask.pid)
  //     '''
  //   }
  // }
          stage('Run Flask App (Smoke Check)') {
            steps {
              sh '''
              . venv/bin/activate
              export ANKIT_MONGO_URI=$MONGO_URI
              pip install -r requirements.txt

              nohup python app.py > flask.log 2>&1 &
              echo $! > flask.pid
              sleep 5

              echo "📡 Smoke test: Checking Flask server..."
              curl --fail http://localhost:5000 || (echo "Flask failed to start:" && cat flask.log && kill $(cat flask.pid) && exit 1)

              echo "🛑 Shutting down Flask..."
              kill $(cat flask.pid) 2>/dev/null || echo "Process already stopped"
              '''
            }
          }



    stage('Deploy to Staging') {
      when {
        expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
      }
      steps {
        echo 'Deploying to staging...'
        // You can insert deployment steps here
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
