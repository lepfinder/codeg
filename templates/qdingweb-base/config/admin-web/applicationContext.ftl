<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:context="http://www.springframework.org/schema/context"
    xmlns:aop="http://www.springframework.org/schema/aop"
    xmlns:tx="http://www.springframework.org/schema/tx"
    xmlns:mvc="http://www.springframework.org/schema/mvc"
    xsi:schemaLocation="
    http://www.springframework.org/schema/beans 
    http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
    http://www.springframework.org/schema/tx
    http://www.springframework.org/schema/tx/spring-tx-2.0.xsd
    http://www.springframework.org/schema/aop
    http://www.springframework.org/schema/aop/spring-aop-2.0.xsd
    http://www.springframework.org/schema/context
    http://www.springframework.org/schema/context/spring-context-3.0.xsd
    http://www.springframework.org/schema/mvc
    http://www.springframework.org/schema/mvc/spring-mvc.xsd" >
    
    <!-- 开启组件扫描 -->
    <!-- 对包中的所有类进行扫描，以完成Bean创建和自动依赖注入的功能 -->
    <context:component-scan base-package="{{project.packageName}}.controller"/>
    <!-- 开启注解 -->
    <mvc:annotation-driven />
    <!-- 静态资源访问     -->
    <mvc:resources mapping="/pages/**" location="/pages/**"/>

    <bean id="viewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="contentType" value="text/html"/>
        <property name="prefix" value="/pages/"/>
        <property name="suffix" value=".jsp" />
    </bean>

    <bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter">
        <property name="messageConverters">
            <list>
                <bean class="org.springframework.http.converter.json.MappingJackson2HttpMessageConverter" />
            </list>
        </property>
    </bean>

    <!-- 配置多请求数据类型，如json xml-->
	<bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
	  	<!-- 以字节为单位的最大上传文件的大小 -->
	  	<property name="maxUploadSize" value="10000000" />
	 </bean>

</beans>
