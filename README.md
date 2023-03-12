# BP-GRAUDIT-STEP

GRAUDIT step help us to perform a security audit on source code. It is designed to identify potential security vulnerabilities in code written in various programming languages, including C/C++, Java, PHP, Python, Ruby, and others.

## Setup
* Clone the code available at [BP-GRAUDIT-STEP](https://github.com/OT-BUILDPIPER-MARKETPLACE/BP-GRAUDIT-STEP.git)
* Build the docker image
```
git submodule init
git submodule update
docker build -t ot/graudit:0.1 .s
