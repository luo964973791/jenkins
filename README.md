### 一、启动jenkins.

```javascript
echo 1 > /proc/sys/net/ipv4/ip_forward
mkdir /data/jenkins -p && chown -R 1000:1000 /data/jenkins
#启动
docker run --restart=always -p 8080:8080 -p 50000:50000 -d  -v /data/jenkins:/var/jenkins_home -e JAVA_OPTS=-Duser.timezone=Asia/Shanghai --name jenkins jenkins/jenkins:lts


#jenkins slave部署,token为master部署好以后生成
mkdir /data/jenkins -p && chown -R 1000:1000 /data/jenkins
docker run -itd --restart=always --name slave-1 --init -v /data/jenkins:/home/jenkins/agent jenkins/inbound-agent:jdk8 -url http://172.27.0.3:38080 -workDir=/home/jenkins/agent fce9ca7c44b6ff141adc6828606f2fd6ad6bfb527df855f369a431b931ab2aed slave-1




#helm部署jenkins
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install jenkins \
  --namespace jenkins --create-namespace \
  --set controller.adminUser=admin \
  --set controller.adminPassword="Test@123" \
  --set controller.serviceType=LoadBalancer \
  --set persistence.storageClass=local-path \
  --set persistence.size=6Gi \
  --set controller.nodeSelector."kubernetes\.io/hostname"=node3 \
  --set controller.javaOpts="-Duser.timezone=Asia/Shanghai" \
  jenkins/jenkins
```

![](./image/6.png)

### 二、配置项目

![](./image/0.png)

![1](./image/1.png)

![2](./image/2.png)

![3](./image/3.png)

![4](./image/4.png)


```javascript
#!/bin/bash
image_version=`date +%Y%m%d%H%M`
cd /data/jenkins/workspace/newjob
docker build -t nginx:$image_version .
old=`kubectl get deploy/nginx -o yaml | grep -P '\- image'| awk '{print $3}'`
kubectl set image deployment/nginx nginx=nginx:$image_version
sleep 10
docker rmi $old
docker images
```

### 三、helm安装jenkins

```javascript
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm fetch bitnami/jenkins
cd jenkins
vi values.yaml
storageClass: "csi-rbd-sc"
type: NodePort

kubectl create ns jenkins
helm install -f values.yaml jenkins bitnami/jenkins -n jenkins
```

