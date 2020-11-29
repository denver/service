# Ultimate Service

[![CircleCI](https://circleci.com/gh/ardanlabs/service.svg?style=svg)](https://circleci.com/gh/ardanlabs/service)

<<<<<<< HEAD
Copyright 2018, 2019, Ardan Labs  
=======
Copyright 2018, 2019, 2020, Ardan Labs  
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
info@ardanlabs.com

## Licensing

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

<<<<<<< HEAD
## Description

This starter kit is a starting point for building production grade scalable web service applications. The goal of this project is to provide a proven starting point for new projects that reduce the repetitive tasks in getting a new project launched to production. It uses minimal dependencies, implements idiomatic code and follows Go best practices. Collectively, the project lays out everything logically to minimize guess work and enable engineers to quickly maintain a mental model for the project. This inturn will make current developers happy and expedite on-boarding of new engineers.

This project should not be considered a web framework. Coding is a discovery process and with that, this project leaves you in control of your project’s architecture and development. There are five areas of expertise that an engineer or their engineering team must do for a project to grow and scale. Based on our experience, a few core decisions were made for each of these areas that help you focus initially on writing the business logic.

* Micro level - Since business applications require data storage this project implements Postgres. The implementation facilitates the data semantics that define the data being captured and their relationships.
* Macro level - The project architecture and design provides basic project structure and foundation for development.
* Business logic - Defines an example Go packages that helps illustrate where value generating activities should reside and how the code will be delivered to clients.
* Deployment and Operations - Integrates with CircleCI and GCP/GKE for serverless deployments.
* Observability - Implements OpenCensus and Go standard library support to facilitate observability.

This project contains the following features:

* Minimal web application using standard html/template package.
* Middleware integration.
* Database support using Postgres.
* CRUD based pattern.
* Role-based access control (RBAC).
* Account signup and user management.
* Distributed logging and tracing.
* Integration with Opencensus for enterprise-level observability.
* Testing patterns.
* Use of Docker, Docker Compose, and Makefiles.
* Vendoring dependencies with Modules, requires Go 1.12 or higher.
* Continuous deployment pipeline.
* Serverless deployments.
* CLI with boilerplate templates to reduce repetitive copy/pasting.
* Integration with CircleCI for enterprise-level CI/CD.

## Local Installation

This project contains three services and uses 3rd party services such as MongoDB and Zipkin. Docker is required to run this software on your local machine.

### Getting the project

You can use the traditional `go get` command to download this project into your configured GOPATH.

```
$ GO111MODULE=off go get -u gitHub.com/ardanlabs/service
```

### Go Modules

This project is using Go Module support for vendoring dependencies. We are using the `tidy` and `vendor` commands to maintain the dependencies and make sure the project can create reproducible builds. This project assumes the source code will be inside your GOPATH within the traditional location.

```
$ cd $GOPATH/src/github.com/ardanlabs/service
$ GO111MODULE=off go mod tidy
$ GO111MODULE=off go mod vendor
```

### Installing Docker

Docker is a critical component to managing and running this project. It kills me to just send you to the Docker installation page but it's all I got for now.

https://docs.docker.com/install/

If you are having problems installing docker reach out or jump on [Gopher Slack](http://invite.slack.golangbridge.org/) for help.

## Running The Project

All the source code, including any dependencies, have been vendored into the project. There is a single `dockerfile`and a `docker-compose` file that knows how to build and run all the services.

A `makefile` has also been provide to make building, running and testing the software easier.

### Building the project

Navigate to the root of the project and use the `makefile` to build all of the services.

```
$ cd $GOPATH/src/github.com/ardanlabs/service
$ make all
```

### Running the project

Navigate to the root of the project and use the `makefile` to run all of the services.

```
$ cd $GOPATH/src/github.com/ardanlabs/service
$ make up
```

The `make up` command will leverage Docker Compose to run all the services, including the 3rd party services. The first time to run this command, Docker will download the required images for the 3rd party services.

Default configuration is set which should be valid for most systems. Use the `docker-compose.yaml` file to configure the services differently is necessary. Email me if you have issues or questions.

### Stopping the project

You can hit <ctrl>C in the terminal window running `make up`. Once that shutdown sequence is complete, it is important to run the `make down` command.

```
$ <ctrl>C
$ make down
```

Running `make down` will properly stop and terminate the Docker Compose session.

## About The Project

The service provides record keeping for someone running a multi-family garage sale. Authenticated users can maintain a list of products for sale.

<!--The service uses the following models:-->

<!--<img src="https://raw.githubusercontent.com/ardanlabs/service/master/models.jpg" alt="Garage Sale Service Models" title="Garage Sale Service Models" />-->

<!--(Diagram generated with draw.io using `models.xml` file)-->

### Making Requests

#### Seeding The Database

To do anything the database needs to be defined and seeded with data. This will also create the initial user.

```
$ make seed
```

This will create a user with email `admin@example.com` and password `gophers`.

#### Authenticating

Before any authenticated requests can be sent you must acquire an auth token. Make a request using HTTP Basic auth with your email and password to get the token.

```
$ curl --user "admin@example.com:gophers" http://localhost:3000/v1/users/token
```

I suggest putting the resulting token in an environment variable like `$TOKEN`.

```
$ export TOKEN="COPY TOKEN STRING FROM LAST CALL"
```

#### Authenticated Requests

To make authenticated requests put the token in the `Authorization` header with the `Bearer ` prefix.

```
$ curl -H "Authorization: Bearer ${TOKEN}" http://localhost:3000/v1/users
```

## What's Next

We are in the process of writing more documentation about this code. Classes are being finalized as part of the Ultimate series.
=======
## About The Project

Please read the project wiki.

https://github.com/ardanlabs/service/wiki

## Learn More

**To learn about Corporate training events, options and special pricing please contact:**

William Kennedy  
ArdanLabs (www.ardanlabs.com)  
bill@ardanlabs.com  

## Purchase Video

The entire training class has been recorded to be made available to those who can't have the class taught at their company or who can't attend a conference. This is the entire class material.

[education.ardanlabs.com](https://education.ardanlabs.com)

## Our Experience

We have taught Go to thousands of developers all around the world since 2014. There is no other company that has been doing it longer and our material has proven to help jump-start developers 6 to 12 months ahead of their knowledge of Go. We know what knowledge developers need in order to be productive and efficient when writing software in Go.

Our classes are perfect for intermediate-level developers who have at least a few months to years of experience writing code in Go. Our classes provide a very deep knowledge of the programming langauge with a big push on language mechanics, design philosophies and guidelines. We focus on teaching how to write code with a priority on consistency, integrity, readability and simplicity. We cover a lot about “if performance matters” with a focus on mechanical sympathy, data oriented design, decoupling and writing/debugging production software.

## Our Teachers

### William Kennedy ([@goinggodotnet](https://twitter.com/goinggodotnet))  
_William Kennedy is a managing partner at Ardan Labs in Miami, Florida. Ardan Labs is a high-performance development and training firm working with startups and fortune 500 companies. He is also a co-author of the book Go in Action, the author of the blog GoingGo.Net, and a founding member of GoBridge which is working to increase Go adoption through diversity._

_**Video Training**_  
[Ultimate Go Video](https://education.ardanlabs.com)  
[Ardan Labs YouTube Channel](http://youtube.ardanlabs.com/)

_**Blog**_  
[Going Go](https://www.ardanlabs.com/blog/)    

_**Writing**_  
[Running MongoDB Queries Concurrently With Go](http://blog.mongodb.org/post/80579086742/running-mongodb-queries-concurrently-with-go)    
[Go In Action](https://www.manning.com/books/go-in-action)  

_**Articles**_  
[IT World Canada](http://www.itworldcanada.com/article/nascent-google-development-language-shows-promise-for-more-productive-coding/387449)

_**Video**_  
[Go Generics Draft Proposal (2020)](https://www.youtube.com/watch?v=gIEPspmbMHM&t=2069s)

[Training Within The Go Community (2019)](https://www.youtube.com/watch?v=PSR1twjzzAM&feature=youtu.be)  

[GopherCon Australia (2019) - Modules](https://www.youtube.com/watch?v=MVxbVR_6Tac)  
[Golab (2019) - You Want To Build a Web Service?](https://www.youtube.com/watch?v=IV0wrVb31Pg)  
[GopherCon Singapore (2019) - Garbage Collection Semantics](https://www.youtube.com/watch?v=q4HoWwdZUHs)  
[GopherCon India (2019) - Channel Semantics](https://www.youtube.com/watch?v=AHAf1Xfr_HE)  
[GoWayFest Minsk (2018) - Profiling Web Apps](https://www.youtube.com/watch?v=-GBMFPegqgw)  
[GopherChina (2018) - Composition In Go William](https://www.youtube.com/watch?v=pvLUO9ZManM&feature=youtu.be)  
[GopherCon Singapore (2018) - Optimizing For Correctness](https://engineers.sg/video/optimize-for-correctness-gopherconsg-2018--2610)  
[GopherCon India (2018) - What is the Legacy You Are Leaving Behind](https://www.youtube.com/watch?v=j3zCUc06OXo&t=0s&index=11&list=PLhJxE57Cki63cElK2kmt3_vi8j2eIHTqZ)  
[Code::Dive (2017) - Optimizing For Correctness](https://www.youtube.com/watch?v=OTLjN8NQDyo)  
[Code::Dive (2017) - Go: Concurrency Design](https://www.youtube.com/watch?v=OrctYMf4btA)  
[dotGo (2017) - Behavior Of Channels](https://www.youtube.com/watch?v=zDCKZn4-dck)  
[GopherCon Singapore (2017) - Escape Analysis](https://engineers.sg/video/escape-analysis-and-memory-profiling-gophercon-sg-2017--1746)  
[Capital Go (2017) - Concurrency Design](https://www.youtube.com/watch?v=yGOOUCrrgrE&index=10&list=PLeGxIOPLk9EKdl-h_Y-sbLhLoP-ia7CJ5)  
[GopherCon India (2017) - Package Oriented Design](https://www.youtube.com/watch?v=spKM5CyBwJA#t=0m56s)  
[GopherCon India (2015) - Go In Action](https://www.youtube.com/watch?v=QkPw8-Pf0SM)  
[GolangUK (2016) - Dependency Management](https://youtu.be/CdhucJShJU8)  
[GothamGo (2015) - Error Handling in Go](https://vimeo.com/115782573)  
[GopherCon (2014) - Building an analytics engine](https://www.youtube.com/watch?v=EfJRQ1lGkUk)  

[Hack Potsdam (2017) - Tech Talk with William Kennedy](https://www.youtube.com/watch?v=sBzJ-sjhgs8)  
[Chicago Meetup (2016) - An Evening](https://vimeo.com/199832344)  
[Vancouver Meetup (2016) - Go Talk & Ask Me Anything With William Kennedy](https://www.youtube.com/watch?v=7YcLIbG1ekM&t=91s)  
[Vancouver Meetup (2015) - Compiler Optimizations in Go](https://www.youtube.com/watch?v=AQipeq39Aek)  
[Bangalore Meetup (2015) - OOP in Go](https://youtu.be/gRpUfjTwSOo)  
[GoSF Meetup - The Nature of Constants in Go](https://www.youtube.com/watch?v=ZUCHMAoOgUQ)    
[London Meetup - Mechanical Sympathy](https://skillsmatter.com/skillscasts/8353-london-go-usergroup)    
[Vancouver Meetup - Decoupling From Change](https://www.youtube.com/watch?v=7YcLIbG1ekM&feature=youtu.be)  

_**Podcasts**_  
[GoTime: Learning and Teaching Go](https://changelog.com/gotime/72)  
[GoTime: Bill Kennedy on Mechanical Sympathy](https://changelog.com/gotime/6)  
[GoTime: Discussing Imposter Syndrome](https://changelog.com/gotime/30)  
[HelloTechPros: Your Tech Interviews are Scaring Away Brilliant People](http://hellotechpros.com/william-kennedy-people)    
[HelloTechPros: The 4 Cornerstones of Writing Software](http://hellotechpros.com/bill-kennedy-productivity)  

## More About Go

Go is an open source programming language that makes it easy to build simple, reliable, and efficient software. Although it borrows ideas from existing languages, it has a unique and simple nature that make Go programs different in character from programs written in other languages. It balances the capabilities of a low-level systems language with some high-level features you see in modern languages today. This creates a programming environment that allows you to be incredibly productive, performant and fully in control; in Go, you can write less code and do so much more.

Go is the fusion of performance and productivity wrapped in a language that software developers can learn, use and understand. Go is not C, yet we have many of the benefits of C with the benefits of higher level programming languages.

[The Why of Go](https://www.infoq.com/presentations/go-concurrency-gc) - Carmen Andoh  
[Go Ten Years and Climbing](https://commandcenter.blogspot.com/2017/09/go-ten-years-and-climbing.html) - Rob Pike  
[The eigenvector of "Why we moved from language X to language Y"](https://erikbern.com/2017/03/15/the-eigenvector-of-why-we-moved-from-language-x-to-language-y.html) - Erik Bernhardsson  
[Learn More](https://talks.golang.org/2012/splash.article) - Go Team  
[Simplicity is Complicated](https://www.youtube.com/watch?v=rFejpH_tAHM) - Rob Pike  
[Getting Started In Go](http://aarti.github.io/2016/08/13/getting-started-in-go) - Aarti Parikh  

## Minimal Qualified Student

The material has been designed to be taught in a classroom environment. The code is well commented but missing some of the contextual concepts and ideas that will be covered in class. Students with the following minimal background will get the most out of the class.

* Studied CS in school or has a minimum of two years of experience programming full time professionally.
* Familiar with structural and object oriented programming styles.
* Has worked with arrays, lists, queues and stacks.
* Understands processes, threads and synchronization at a high level.
* Operating Systems
	* Has worked with a command shell.
	* Knows how to maneuver around the file system.
	* Understands what environment variables are.

## Important Reading

Please check out this page of [important reading](https://github.com/ardanlabs/gotraining/tree/master/reading). You will find articles and videos around mechanical sympathy, data-oriented design, Go runtime and optimizations and articles about the history of computing.

## Before You Come To Class

The following is a set of tasks that can be done prior to showing up for class.  We will also do this in class if anyone has not completed it.  However, the more attendees that complete this ahead of time the more time we have to cover additional training material.

### Prep Work

**Reading Material**  
http://go.dev/   
https://www.ardanlabs.com/blog/

**Exercises**  
https://tour.golang.org/welcome/1  
https://gophercises.com/

### Joining the Go Slack Community

We use a slack channel to share links, code, and examples during the training.  This is free.  This is also the same slack community you will use after training to ask for help and interact with may Go experts around the world in the community.

1. Using the following link, fill out your name and email address: https://gophersinvite.herokuapp.com/
1. Check your email, and follow the link to the slack application.
1. Join the training channel by clicking on this link: https://gophers.slack.com/messages/training/
1. Click the “Join Channel” button at the bottom of the screen.

### Installing Go

#### Local Installation

https://www.ardanlabs.com/blog/2016/05/installing-go-and-your-workspace.html

### Editors

**Visual Studio Code**  
https://code.visualstudio.com/Updates  
https://github.com/microsoft/vscode-go

**VIM**  
http://www.vim.org/download.php  
http://farazdagi.com/blog/2015/vim-as-golang-ide/

**Goland**  
https://www.jetbrains.com/go/
>>>>>>> 24002bb5690504cdbff6843ce8d8183c3da26d92
