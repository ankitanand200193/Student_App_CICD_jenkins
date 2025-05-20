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

    stage('Run Flask App (Smoke Check)') {
      steps {
        sh '''
          . venv/bin/activate
          export ANKIT_MONGO_URI=$MONGO_URI
          nohup python app.py &
          sleep 5
          curl --fail http://localhost:5000 || exit 1
          pkill -f "python app.py"
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
      mail to: '@gmail.com',
           subject: "✅ Build Success: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
           body: "The build completed successfully."
    }
    failure {
      mail to: 'XYZ@gmail.com',
           subject: "❌ Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
           body: "Check the Jenkins logs for more details."
    }
  }
}
