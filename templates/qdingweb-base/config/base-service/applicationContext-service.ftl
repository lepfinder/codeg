<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xsi:schemaLocation="
    http://www.springframework.org/schema/beans 
    http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context-3.0.xsd
    ">

    <!-- 开启组件扫描 -->
    <!-- 对包中的所有类进行扫描，以完成Bean创建和自动依赖注入的功能 -->
    <context:component-scan base-package="{{project.packageName}}"/>

    <bean id="propertyPlaceholderConfigurer" class="org.springframework.beans.factory.config.PropertyPlaceholderConfigurer">
        <property name="locations">
            <list>
                <value>file:${qding.conf.path}jdbc.properties</value>
                <value>file:${qding.conf.path}rpc.properties</value>
            </list>
        </property>
    </bean>


    <import resource="spring-remote-client.xml"></import>
</beans>
