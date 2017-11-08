<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:context="http://www.springframework.org/schema/context"
    xmlns:tx="http://www.springframework.org/schema/tx" xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="
    http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans.xsd
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context-3.0.xsd
    http://www.springframework.org/schema/tx
    http://www.springframework.org/schema/tx/spring-tx-3.0.xsd
    http://www.springframework.org/schema/aop
    http://www.springframework.org/schema/aop/spring-aop-3.0.xsd">
    
  <!--   <context:component-scan base-package="com.wanda.rpc.demo" />--> 
    
	<bean id="dictionaryClient" class="com.qding.rpc.client.config.spring.RpcClientRegisterBean">
		<property name="target" value="com.qding.thrift.service.dictionary.RPCDictionaryService"/>
		<!-- 默认直连IP端口设置 -->
		<property name="remoteIp" value="${dictionary_ip}"/>
		<property name="remotePort" value="${dictionary_port}"/>
		<!-- ZK设置 -->
		<property name="zkHosts" value=""/>
		<property name="version" value="1.0"/>
		<!-- 连接池设置 -->
		<property name="waitTimeOut" value="10000"/>
		<property name="socketTimeOut" value="10000"/>
		<property name="maxPoolSize" value="10"/>
		<property name="maxIdle" value="5"/>
		<property name="minIdle" value="3"/>
		<property name="idleTimeSeconds" value="1800"/>
	</bean>
	
	<bean id="dictionaryService" class="com.qding.dictionary.client.DictionaryClient" >
	     <property name="client" ref="dictionaryClient"/>
	 </bean>
</beans>
