FROM  python:3.11-slim 
WORKDIR /app

RUN pip install --upgrade pip
COPY requirements.txt requirements.txt
COPY . .
RUN pip install -r requirements.txt

COPY . .
EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
