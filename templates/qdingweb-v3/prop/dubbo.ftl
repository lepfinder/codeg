#registry  （qa与rd分别不同的注册中心）
dubbo.registry.address=zookeeper://10.37.253.74:2181?backup=10.37.253.74:2182,10.37.253.74:2183
 
#protocol
dubbo.protocol.name=dubbo
dubbo.protocol.port=20880
dubbo.protocol.threads=500
 
dubbo.monitor.protocol=registry
 
#application
dubbo.application.name=rd-{{project.name}}
dubbo.application.owner=