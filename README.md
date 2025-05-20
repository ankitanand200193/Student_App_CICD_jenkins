# Student Management System (Flask + Pytest + Jenkins + Docker)

## 📌 Features
- Add, view, fetch, and delete students
- REST API with Flask
- Tested with pytest
- Dockerized
- CI/CD ready with Jenkins



## Setup

```
Create a database and collection in MongoD

Update MONGO_URI in the python code once its value stored in .env file

```

## Git Webhook Setup:

| Field            | Value                                                                    |
| ---------------- | ------------------------------------------------------------------------ |
| **Payload URL**  | `http://<your-jenkins-url>/github-webhook/`                              |
| **Content type** | `application/json`                                                       |
| **Secret**       | *(optional)* Add a secret if you want to secure communication            |
| **Events**       | Choose “**Just the push event**” (or also enable Pull request if needed) |

You can test the setup by hitting on recent deliveries. 

## Setting the gmail notification:

![gmail_notifiction]()

### To create the password:

* Go to your Google Account: https://myaccount.google.com/

* Enable 2-Step Verification.

* After enabling, go to Security > App Passwords.

* Choose App: Mail and Device: Other (Jenkins).

* Click Generate — you’ll get a 16-character app password.



## 🚀 Run Locally
```bash
pip install -r requirements.txt
python app.py
```

## 🧪 Run Tests
```bash
pytest test_app.py
```

## 🐳 Docker
```bash
docker build -t student-api .
docker run -p 5000:5000 student-api
```

## 🛠️ Jenkins Pipeline
This project contains a `Jenkinsfile` to automate:
- Code clone
- Dependency install
- Test execution
- App deployment
