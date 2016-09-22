<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
       xmlns:aop="http://www.springframework.org/schema/aop"
    xsi:schemaLocation="
    http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context-3.0.xsd
     http://www.springframework.org/schema/aop
 http://www.springframework.org/schema/aop/spring-aop-3.0.xsd
    ">

    <!-- 开启组件扫描 -->
    <!-- 对包中的所有类进行扫描，以完成Bean创建和自动依赖注入的功能 -->
    <context:component-scan base-package="com.baidu,com.qding"/>

    <!-- 开启日志自动输出-->
    <aop:aspectj-autoproxy proxy-target-class="true"/>
    <bean class="{{project.packageName}}.service.log.TracerLogAspect" />



    <!-- 使用disconf必须添加以下配置 -->
    <bean id="disconfMgrBean" class="com.baidu.disconf.client.DisconfMgrBean"
          destroy-method="destory">
        <property name="scanPackage" value="com.qding"/>
    </bean>
    <bean id="disconfMgrBean2" class="com.baidu.disconf.client.DisconfMgrBeanSecond"
          init-method="init" destroy-method="destory">
    </bean>

    <!-- 使用托管方式的disconf配置(无代码侵入, 配置更改会自动reload)-->
    <bean id="configproperties_disconf"
          class="com.baidu.disconf.client.addons.properties.ReloadablePropertiesFactoryBean">
        <property name="locations">
            <list>
                <value>classpath:/rpc.properties</value>
                <value>classpath:/jdbc.properties</value>
                <value>classpath:/dictionary.properties</value>
                <value>classpath:/shiro_redis.properties</value>
            </list>
        </property>
    </bean>

    <bean id="propertyConfigurer"
          class="com.baidu.disconf.client.addons.properties.ReloadingPropertyPlaceholderConfigurer">
        <property name="ignoreResourceNotFound" value="true" />
        <property name="ignoreUnresolvablePlaceholders" value="true" />
        <property name="propertiesArray">
            <list>
                <ref bean="configproperties_disconf"/>
            </list>
        </property>
    </bean>

    <aop:aspectj-autoproxy proxy-target-class="true"/>


    <import resource="spring-remote-common.xml"></import>
</beans>
