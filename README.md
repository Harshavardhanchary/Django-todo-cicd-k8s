# django-todo
A simple todo app built with django

![todo App](https://raw.githubusercontent.com/shreys7/django-todo/develop/staticfiles/todoApp.png)
### Setup
To get this repository, run the following command inside your git enabled terminal
```bash
$ git clone https://github.com/Harshavardhanchary/Django-todo-cicd-k8s.git
```
You will need docker and jenkins  to be installed in you terminal to run this app.

Once you have downloaded docker, go to the cloned repo directory and run the following command

```bash
$ docker build -t firstbuild:v1 .
```

This will create a docker image  required to run this app as a container.

Now, run the following command to run the container
```bash
$ docker run -d -p 8080:8080 "image-id"
```

Your Web-application will be live
Acess the app at
````bash
$ http://localhost:8080 #if you're running this app in your local-machine(i.e your personal laptop)
````
Acess the app at
````bash
$ http://'<your-instance-ip'>:8080 #if you're running this remotely(Ex :In ec2) 
````
````bash
$ 
````





Cheers and Happy Deploying :)
