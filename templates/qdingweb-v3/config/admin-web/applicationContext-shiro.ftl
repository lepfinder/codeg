<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	   xsi:schemaLocation="
    http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
    ">
	<description>Shiro安全配置</description>

	<!-- Shiro's main business-tier object for web-enabled applications -->
	<bean id="securityManager" class="org.apache.shiro.web.mgt.DefaultWebSecurityManager">
		<property name="realm" ref="shiroDbRealm" />
		 <property name="cacheManager" ref="shiroRedisCacheManager" />
		<property name="sessionManager" ref="sessionManager" />
	</bean>

	<!-- 項目自定义的Realm, 所有accountService依赖的dao都需要用depends-on声明 -->
	<bean id="shiroDbRealm" class="com.qding.manager.shiro.ShiroDbRealm">
		<!-- MD5加密 -->
		<property name="credentialsMatcher">
			<bean class="org.apache.shiro.authc.credential.HashedCredentialsMatcher">
				<property name="hashAlgorithmName" value="MD5" />
			</bean>
		</property>
	</bean>

	<!-- 自定义过滤器，用来匹配URL和权限 -->
	<bean id="qdAuthFilter" class="com.qding.manager.shiro.ShiroPermissionFilter" />

	<!-- Shiro Filter -->
	<bean id="shiroFilter" class="org.apache.shiro.spring.web.ShiroFilterFactoryBean">
		<property name="securityManager" ref="securityManager" />
		<property name="loginUrl" value="/" />
		<property name="successUrl" value="/pages/ok.jsp" />
		<property name="unauthorizedUrl" value="/" />
		<property name="filters">
            <map>
                <entry key="qdfilter" value-ref="qdAuthFilter"></entry>
            </map>
        </property>
		<property name="filterChainDefinitions">
			<value>
				/** = qdfilter
			</value>
		</property>
	</bean>

	<!-- session管理器 -->
    <bean id="sessionManager"
		class="org.apache.shiro.web.session.mgt.DefaultWebSessionManager">
		<!--超时时间-->
		<property name="globalSessionTimeout" value="18000000" />
		<!--session存储的实现-->
        <property name="sessionDAO" ref="shiroSessionDao" />
	     <!-- sessionIdCookie的实现,用于重写覆盖容器默认的JSESSIONID-->
		<property name="sessionIdCookie" ref="sharesession" />
	    <!--定时检查失效的session-->
       <property name="sessionValidationSchedulerEnabled" value="true" />
		<property name="sessionIdCookie.domain" value=".qdingnet.com"/>
		<property name="sessionIdCookie.name" value="${manager.shiro.jsid}"/>
		<property name="sessionIdCookie.path" value="/"/>
    </bean>

    <!--&lt;!&ndash; sessionIdCookie的实现,用于重写覆盖容器默认的JSESSIONID &ndash;&gt;-->
	<bean id="sharesession" class="org.apache.shiro.web.servlet.SimpleCookie">
	<!--cookie的name,对应的默认是 JSESSIONID-->
    <constructor-arg name="name" value="SHAREJSESSIONID" />
    </bean>

    <!-- session存储的实现 -->
	<bean id="shiroSessionDao"
		class="com.qding.manager.shiro.ShiroRedisSessionDao">
	</bean>

	<!-- 用户授权信息Cache, 使用Redis -->
	<bean id="shiroRedisCacheManager" class="com.qding.manager.shiro.ShiroRedisCacheManager" />

	<!-- 保证实现了Shiro内部lifecycle函数的bean执行 -->
	<bean id="lifecycleBeanPostProcessor" class="org.apache.shiro.spring.LifecycleBeanPostProcessor" />


	<!-- 消息任务Redis配置和初始化 -->
	<bean id="MyRedisClient" class="com.qding.manager.cache.MyRedisClient" init-method="springInit">
		<property name="redisPath">
			<value>shiro_redis.properties</value>
		</property>
	</bean>
</beans>