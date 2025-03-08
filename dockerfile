FROM python:3.13.2

WORKDIR /data

RUN pip install django==3.2

COPY . .

EXPOSE 8000
RUN python manage.py migrate
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]