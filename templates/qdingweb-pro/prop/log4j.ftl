log4j.rootLogger=INFO,Console

#Console
log4j.appender.Console=org.apache.log4j.ConsoleAppender
log4j.appender.Console.layout=org.apache.log4j.PatternLayout
log4j.appender.Console.layout.ConversionPattern=%d [%t] %-5p [%c] - %m%n


log4j.logger.java.sql.ResultSet=INFO
log4j.logger.org.apache=INFO
log4j.logger.java.sql.Connection=INFO
log4j.logger.java.sql.Statement=INFO
log4j.logger.java.sql.PreparedStatement=INFO

log4j.logger.com.ibatis=INFO
log4j.logger.com.ibatis.common.jdbc.SimpleDataSource=INFO
log4j.logger.com.ibatis.common.jdbc.ScriptRunner=INFO
log4j.logger.com.ibatis.sqlmap.engine.impl.SqlMapClientDelegate=INFO


log4j.logger.tracer = INFO,qdtrace
log4j.additivity.tracer = false
log4j.appender.qdtrace=org.apache.log4j.DailyRollingFileAppender
log4j.appender.qdtrace.layout=org.apache.log4j.PatternLayout
log4j.appender.qdtrace.layout.ConversionPattern=%d [%t] %-5p [%c] - %m%n
log4j.appender.qdtrace.File=${catalina.home}/logs/tracer.log