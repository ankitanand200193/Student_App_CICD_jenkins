# FROM python:3.11-slim
# WORKDIR /app
# COPY . .
# RUN pip install --no-cache-dir -r requirements.txt
# EXPOSE 5000
# CMD ["python", "app.py"]


# Dockerfile

FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy code and env file
COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
