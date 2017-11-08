<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:dubbo="http://code.alibabatech.com/schema/dubbo"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans-3.1.xsd
    http://code.alibabatech.com/schema/dubbo
    http://code.alibabatech.com/schema/dubbo/dubbo.xsd"
        >

    <dubbo:provider filter="tracelog">
        <dubbo:parameter key="loglevel" value="10"/>
    </dubbo:provider>

    <dubbo:consumer filter="agent">
        <dubbo:parameter key="loglevel" value="10"/>
    </dubbo:consumer>

    <bean id="dataHubService" class="com.qding.knight.service.impl.DataHubServiceImpl" />
    <bean id="knightConfService" class="com.qding.knight.service.impl.KnightConfServiceImpl" />
    <bean id="knightDataSourceService" class="com.qding.knight.service.impl.KnightDataSourceServiceImpl" />

    <dubbo:service interface="com.qding.knight.service.IDataHubService" ref="dataHubService" timeout="1800000" retries="0"/>

    <dubbo:service interface="com.qding.knight.service.IKnightConfService" ref="knightConfService" timeout="15000" retries="0"/>

    <dubbo:service interface="com.qding.knight.service.IKnightDataSourceService" ref="knightDataSourceService" timeout="15000" retries="0"/>

</beans>
