### 第一步下载项目

```javascript
git clone https://github.com/luo964973791/jenkins.git
```

### 第二步移动目录

```javascript
cd jenkins && mv jenkins /data && chown -R 1000:1000 /data/jenkins
```

### 第三步启动

```javascript
echo 1 > /proc/sys/net/ipv4/ip_forward
docker run --restart=always -p 8080:8080 -p 50000:50000 -d  -v /data/jenkins:/var/jenkins_home -e JAVA_OPTS=-Duser.timezone=Asia/Shanghai --name jenkins 964973791/jenkins:2.204.1
```

### 第四步查看密码

```javascript
docker logs jenkins
```

