<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE log4j:configuration SYSTEM "log4j.dtd">
<log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">

	<appender name="consoleAppender" class="org.apache.log4j.ConsoleAppender">
		<layout class="org.apache.log4j.PatternLayout">
			<param name="ConversionPattern" value="%d{yyyy-MM-dd HH:mm:ss}:%5p %c{1}:%L - %m%n" />
		</layout>
	</appender>
	<appender name="RollingFileAppender" class="org.apache.log4j.RollingFileAppender">
		<param name="Append" value="true" />
		<param name="MaxFileSize" value="5MB" />
		<!-- <param name="File" value="${log4j.path}"/> -->
		<param name="MaxBackupIndex" value="3" />
		<layout class="org.apache.log4j.PatternLayout">
			<param name="ConversionPattern" value="%d{yyyy-MM-dd HH:mm:ss}:%5p %c{1}:%L - %m%n" />
		</layout>
	</appender>
 <logger name="org.apache.ibatis" additivity="true">  
        <level value="DEBUG"/>
        <appender-ref ref="consoleAppender"/>  
    </logger>  
  
    <logger name="org.mybatis.spring" additivity="true">  
        <level value="ERROR"/>  
        <appender-ref ref="consoleAppender"/>  
    </logger>  
    <logger name="java.sql" additivity="true">  
        <level value="DEBUG"/>  
        <appender-ref ref="consoleAppender"/>  
    </logger>  
  
    <logger name="java.sql.Connection" additivity="true">  
        <level value="DEBUG"/>  
        <appender-ref ref="consoleAppender"/>  
    </logger>  
  
    <logger name="java.sql.Statement" additivity="true">  
        <level value="DEBUG"/>  
        <appender-ref ref="consoleAppender"/>  
    </logger>  
  
    <logger name="java.sql.PreparedStatement" additivity="true">  
        <level value="DEBUG"/>  
        <appender-ref ref="consoleAppender"/>  
    </logger>  
  
    <!-- Spring -->  
    <logger name="org.springframework" additivity="true">  
        <level value="ERROR"/>  
        <appender-ref ref="consoleAppender"/>  
    </logger> 
 	<root>
		<priority value="DEBUG" />
		<appender-ref ref="consoleAppender" />
	</root>

</log4j:configuration> 