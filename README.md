# Goal
### Create a Jenkins DSL that can deploy a simple Spring Boot app (build, run tests, run sonnar and deploy in EC2) use terraform

#### Create AWS EKS env with terraform. 
Create emvirnment with jenkins
#### Create Jenkins with terraform/helm. 
Create  with jenkins
#### Create Sonnar with terraform/helm
Create repo with sonnar
#### Create a DSL for repo
HelloWorld: [spring-boot-app-demo](https://github.com/luisfneu/spring-boot-app-demo)
Run deploy of Repo on EC2 with terraform

#### Idea: 
![image](https://github.com/user-attachments/assets/3b8f80e0-8cc8-4d2d-8d3e-3b05bab9dd2e)


##### export cluster config
    aws eks update-kubeconfig --region us-east-1 --name poc-cluster
