### 一、启动jenkins.

```javascript
echo 1 > /proc/sys/net/ipv4/ip_forward
mkdir /data/jenkins -p && chown -R 1000:1000 /data/jenkins
#启动
docker run --restart=always -p 8080:8080 -p 50000:50000 -d  -v /data/jenkins:/var/jenkins_home -e JAVA_OPTS=-Duser.timezone=Asia/Shanghai --name jenkins jenkins/jenkins:lts
```

### 二、配置项目

![](./image/0.png)

![1](./image/1.png)

![2](./image/2.png)

![3](./image/3.png)

![4](./image/4.png)
