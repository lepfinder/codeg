<!DOCTYPE beans PUBLIC "-//SPRING//DTD BEAN//EN" "http://www.springframework.org/dtd/spring-beans.dtd">
<beans>

    <!-- 对外remote 服务
    <bean id="feeRpcService" class="com.qding.profee.rpc.service.impl.FeeRpcServiceImpl" />
    <bean name="/feeRpc"
          class="org.springframework.remoting.caucho.HessianServiceExporter">
        <property name="service" ref="feeRpcService" />
        <property name="serviceInterface" value="com.qding.profee.rpc.service.IFeeRpcService" />
    </bean>
    -->

    <!-- imessage远程服务接口 -->
    <bean name="/imessage" class="org.springframework.remoting.caucho.HessianServiceExporter">
        <property name="service" ref="scheduleIMessageService" />
        <property name="serviceInterface" value="com.qding.imessage.common.Hessian.IScheduleMessageService" />
    </bean>

</beans>