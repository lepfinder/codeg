<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
	<modelVersion>4.0.0</modelVersion>

	<groupId>{{project.packageName}}</groupId>
	<artifactId>{{project.name}}</artifactId>
	<version>1.0-SNAPSHOT</version>
	<packaging>pom</packaging>

	<name>{{project.folder_name}}</name>
	<url>http://maven.apache.org</url>

	<modules>
		<module>{{project.name}}-admin-web</module>
		<module>{{project.name}}-remote</module>
		<module>{{project.name}}-service</module>
		<module>{{project.name}}-common</module>
	</modules>

	<properties>
		<myproject.version>0.0.1-SNAPSHOT</myproject.version>

		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
		<project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
		<spring_version>4.1.0.RELEASE</spring_version>
		<hibernate_version>4.3.4.Final</hibernate_version>
		<jetty_version>6.1.26</jetty_version>
		<cglib_version>2.2</cglib_version>
		<mysql_connector_version>5.1.31</mysql_connector_version>
		<dom4j_version>1.6.1</dom4j_version>
		<commons_logging_version>1.1.1</commons_logging_version>
		<commons_collections_version>3.2.1</commons_collections_version>
		<commons_beanutils_version>1.8.3</commons_beanutils_version>
		<antlr_version>2.7.7</antlr_version>
		<javassist_version>3.18.1-GA</javassist_version>
		<slf4j_version>1.7.6</slf4j_version>
		<log4j_version>1.2.17</log4j_version>
		<commons_lang_version>2.6</commons_lang_version>
		<commons_lang3_version>3.1</commons_lang3_version>
		<junit_version>4.11</junit_version>
		<servlet_version>3.0.1</servlet_version>
		<curator_version>1.1.16</curator_version>
		<mongo_version>2.11.3</mongo_version>
		<mongo_jongo_version>1.0</mongo_jongo_version>
		<c3p0.version>0.9.2.1</c3p0.version>
		<jackson.version>2.3.0</jackson.version>
		<jstl.version>1.2</jstl.version>
		<fileupload.version>1.3</fileupload.version>
		<poi.version>3.9</poi.version>
		<hib.validator.version>5.0.3.Final</hib.validator.version>
		<hessian_version>3.1.5</hessian_version>
		<ant_version>1.9.2</ant_version>
		<aspectjweaver.version>1.7.2</aspectjweaver.version>
		<guava_version>18.0</guava_version>
		<mybatis-spring_version>1.2.2</mybatis-spring_version>
		<mybatis_version>3.2.8</mybatis_version>
		<druid_version>1.0.8</druid_version>
		<gson.version>1.7.1</gson.version>
		<codec_version>1.9</codec_version>
		<zxing.core.version>3.1.0</zxing.core.version>
		<zxing.javase.version>3.1.0</zxing.javase.version>
		<commons-httpclient.version>4.2.1</commons-httpclient.version>
		<httpcore.version>4.3.2</httpcore.version>
		<async-http-client.version>1.7.16</async-http-client.version>
		<commons-io.version>1.3.2</commons-io.version>
		<httpmime.version>4.2.1</httpmime.version>
		<poi.version>3.9</poi.version>
		<poi-ooxml.version>3.9</poi-ooxml.version>
		<quartz.version>1.5.2</quartz.version>
		<passport.version>1.0</passport.version>
		<dictionary-client>3.0.1-SNAPSHOT</dictionary-client>
		<order-api.version>0.0.1-SNAPSHOT</order-api.version>
		<imessage.version>0.0.1-SNAPSHOT</imessage.version>
		<schedule-client.version>0.0.1-SNAPSHOT</schedule-client.version>
        <dictionary-client>3.0.2-SNAPSHOT</dictionary-client>
	</properties>



	<build>
		<resources>
			<resource>
				<directory>src/main/resources</directory>
				<filtering>true</filtering>
			</resource>
		</resources>

		<plugins>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-surefire-plugin</artifactId>
				<configuration>
					<skip>true</skip>
				</configuration>
			</plugin>

			<plugin>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>2.3.2</version>
				<configuration>
					<source>1.7</source>
					<target>1.7</target>
					<encoding>UTF-8</encoding>
				</configuration>
			</plugin>
		</plugins>
	</build>

	<dependencyManagement>
		<dependencies>
	        <dependency>
	            <groupId>com.qding.framework</groupId>
	            <artifactId>framework-common</artifactId>
	            <version>0.0.11-SNAPSHOT</version>
	        </dependency>
			<dependency>
				<groupId>commons-io</groupId>
				<artifactId>commons-io</artifactId>
				<version>${commons-io.version}</version>
			</dependency>
			<dependency>
				<groupId>commons-httpclient</groupId>
				<artifactId>commons-httpclient</artifactId>
				<version>${commons-httpclient.version}</version>
			</dependency>
			<dependency>
				<groupId>org.apache.httpcomponents</groupId>
				<artifactId>httpcore</artifactId>
				<version>${httpcore.version}</version>
			</dependency>
			<dependency>
				<groupId>org.apache.httpcomponents</groupId>
				<artifactId>httpmime</artifactId>
				<version>${httpmime.version}</version>
			</dependency>
			<dependency>
				<groupId>com.ning</groupId>
				<artifactId>async-http-client</artifactId>
				<version>${async-http-client.version}</version>
			</dependency>
			<dependency>
				<groupId>com.google.zxing</groupId>
				<artifactId>core</artifactId>
				<version>${zxing.core.version}</version>
				<scope>compile</scope>
			</dependency>
			<dependency>
				<groupId>com.google.zxing</groupId>
				<artifactId>javase</artifactId>
				<version>${zxing.javase.version}</version>
			</dependency>
			<dependency>
				<groupId>commons-codec</groupId>
				<artifactId>commons-codec</artifactId>
				<version>${codec_version}</version>
			</dependency>
			
			<dependency>
				<groupId>org.springframework</groupId>
				<artifactId>spring-core</artifactId>
				<version>${spring_version}</version>
			</dependency>
			<dependency>
				<groupId>org.springframework</groupId>
				<artifactId>spring-orm</artifactId>
				<version>${spring_version}</version>
			</dependency>
			<dependency>
				<groupId>org.springframework</groupId>
				<artifactId>spring-context</artifactId>
				<version>${spring_version}</version>
			</dependency>
			<dependency>
				<groupId>org.springframework</groupId>
				<artifactId>spring-aspects</artifactId>
				<version>${spring_version}</version>
				<exclusions>
					<exclusion>
						<groupId>org.aspectj</groupId>
						<artifactId>aspectjweaver</artifactId>
					</exclusion>
				</exclusions>
			</dependency>
			<dependency>
				<groupId>org.aspectj</groupId>
				<artifactId>aspectjweaver</artifactId>
				<version>${aspectjweaver.version}</version>
			</dependency>
			<dependency>
				<groupId>org.springframework</groupId>
				<artifactId>spring-remoting</artifactId>
				<version>2.0.8</version>
			</dependency>
			<!-- MySQL database driver -->
			<dependency>
				<groupId>mysql</groupId>
				<artifactId>mysql-connector-java</artifactId>
				<version>${mysql_connector_version}</version>
			</dependency>
			<!-- Hibernate library dependecy start -->
			<dependency>
				<groupId>dom4j</groupId>
				<artifactId>dom4j</artifactId>
				<version>${dom4j_version}</version>
			</dependency>
			<dependency>
				<groupId>commons-logging</groupId>
				<artifactId>commons-logging</artifactId>
				<version>${commons_logging_version}</version>
			</dependency>
			<dependency>
				<groupId>commons-collections</groupId>
				<artifactId>commons-collections</artifactId>
				<version>${commons_collections_version}</version>
			</dependency>
			<dependency>
				<groupId>antlr</groupId>
				<artifactId>antlr</artifactId>
				<version>${antlr_version}</version>
			</dependency>
			<dependency>
				<groupId>org.javassist</groupId>
				<artifactId>javassist</artifactId>
				<version>${javassist_version}</version>
			</dependency>
			<!-- Hibernate library dependecy end -->
			<dependency>
				<groupId>org.slf4j</groupId>
				<artifactId>slf4j-log4j12</artifactId>
				<version>${slf4j_version}</version>
			</dependency>
			<dependency>
				<groupId>log4j</groupId>
				<artifactId>log4j</artifactId>
				<version>${log4j_version}</version>
			</dependency>
			<dependency>
				<groupId>commons-lang</groupId>
				<artifactId>commons-lang</artifactId>
				<version>${commons_lang_version}</version>
			</dependency>
			<dependency>
				<groupId>org.apache.commons</groupId>
				<artifactId>commons-lang3</artifactId>
				<version>${commons_lang3_version}</version>
			</dependency>
			<dependency>
				<groupId>commons-beanutils</groupId>
				<artifactId>commons-beanutils</artifactId>
				<version>${commons_beanutils_version}</version>
			</dependency>
			<dependency>
				<groupId>junit</groupId>
				<artifactId>junit</artifactId>
				<version>${junit_version}</version>
				<scope>test</scope>
			</dependency>
			<dependency>
				<groupId>javax.servlet</groupId>
				<artifactId>javax.servlet-api</artifactId>
				<version>${servlet_version}</version>
				<scope>provided</scope>
			</dependency>
			<!-- add mongodb by mahui 2013.11.18 -->
			<dependency>
				<groupId>org.mongodb</groupId>
				<artifactId>mongo-java-driver</artifactId>
				<version>${mongo_version}</version>
			</dependency>
			<dependency>
				<groupId>org.jongo</groupId>
				<artifactId>jongo</artifactId>
				<version>${mongo_jongo_version}</version>
			</dependency>
			
			<dependency>
				<groupId>com.mchange</groupId>
				<artifactId>c3p0</artifactId>
				<version>${c3p0.version}</version>
			</dependency>
			<dependency>
				<groupId>org.springframework</groupId>
				<artifactId>spring-test</artifactId>
				<version>${spring_version}</version>
			</dependency>
			<dependency>
				<groupId>org.springframework</groupId>
				<artifactId>spring-context-support</artifactId>
				<version>${spring_version}</version>
			</dependency>
			<dependency>
				<groupId>org.springframework</groupId>
				<artifactId>spring-web</artifactId>
				<version>${spring_version}</version>
			</dependency>
			<dependency>
				<groupId>org.springframework</groupId>
				<artifactId>spring-webmvc</artifactId>
				<version>${spring_version}</version>
			</dependency>
			<dependency>
				<groupId>com.fasterxml.jackson.core</groupId>
				<artifactId>jackson-core</artifactId>
				<version>${jackson.version}</version>
			</dependency>
			<dependency>
				<groupId>com.fasterxml.jackson.core</groupId>
				<artifactId>jackson-databind</artifactId>
				<version>${jackson.version}</version>
			</dependency>
			<dependency>
				<groupId>com.fasterxml.jackson.core</groupId>
				<artifactId>jackson-annotations</artifactId>
				<version>${jackson.version}</version>
			</dependency>
			<dependency>
				<groupId>javax.servlet</groupId>
				<artifactId>jstl</artifactId>
				<version>${jstl.version}</version>
			</dependency>
			<dependency>
				<groupId>commons-fileupload</groupId>
				<artifactId>commons-fileupload</artifactId>
				<version>${fileupload.version}</version>
			</dependency>
			<!-- poi jar -->
			<dependency>
				<groupId>org.apache.poi</groupId>
				<artifactId>poi</artifactId>
				<version>${poi.version}</version>
			</dependency>
			<dependency>
				<groupId>org.apache.poi</groupId>
				<artifactId>poi-ooxml</artifactId>
				<version>${poi.version}</version>
			</dependency>
			<dependency>
				<groupId>org.apache.poi</groupId>
				<artifactId>poi-scratchpad</artifactId>
				<version>${poi.version}</version>
			</dependency>
			<dependency>
				<groupId>org.hibernate</groupId>
				<artifactId>hibernate-validator</artifactId>
				<version>${hib.validator.version}</version>
			</dependency>
			<dependency>
				<groupId>com.caucho</groupId>
				<artifactId>hessian</artifactId>
				<version>${hessian_version}</version>
			</dependency>
			<dependency>
				<groupId>org.mortbay.jetty</groupId>
				<artifactId>jetty</artifactId>
				<version>${jetty_version}</version>
			</dependency>
			<dependency>
				<groupId>org.apache.ant</groupId>
				<artifactId>ant</artifactId>
				<version>${ant_version}</version>
			</dependency>
			<dependency>
				<groupId>com.google.guava</groupId>
				<artifactId>guava</artifactId>
				<version>${guava_version}</version>
			</dependency>
			<dependency>
				<groupId>org.mybatis</groupId>
				<artifactId>mybatis-spring</artifactId>
				<version>${mybatis-spring_version}</version>
			</dependency>
			<dependency>
				<groupId>org.mybatis</groupId>
				<artifactId>mybatis</artifactId>
				<version>${mybatis_version}</version>
			</dependency>
			<dependency>
				<groupId>com.alibaba</groupId>
				<artifactId>druid</artifactId>
				<version>${druid_version}</version>
			</dependency>

			<dependency>
				<groupId>quartz</groupId>
				<artifactId>quartz</artifactId>
				<version>${quartz.version}</version>
			</dependency>

			<dependency>
                <groupId>com.baidu.disconf</groupId>
                <artifactId>disconf-client</artifactId>
                <version>2.6.25-SNAPSHOT</version>
                <exclusions>
                    <exclusion>
                        <artifactId>org.slf4j</artifactId>
                        <groupId>slf4j-log4j12</groupId>
                    </exclusion>
                    <exclusion>
                        <artifactId>ch.qos.logback</artifactId>
                        <groupId>logback-classic</groupId>
                    </exclusion>
                </exclusions>
            </dependency>
            <dependency>
				<groupId>com.qdingnet</groupId>
				<artifactId>imessage-client</artifactId>
				<version>${imessage.version}</version>
				<exclusions>
					<exclusion>
						<groupId>ch.qos.logback</groupId>
						<artifactId>logback-classic</artifactId>
					</exclusion>
				</exclusions>
			</dependency>
			<dependency>
				<groupId>com.qding.dictionary</groupId>
				<artifactId>dictionary-client</artifactId>
				<version>${dictionary-client}</version>
			</dependency>
			<dependency>
				<groupId>com.qdingnet</groupId>
				<artifactId>schedule-client</artifactId>
				<version>${schedule-client.version}</version>
			</dependency>
		</dependencies>
	</dependencyManagement>

	<distributionManagement>
		<repository>
			<id>nexus</id>
			<name>releases</name>
			<url>http://mvn2.qdingnet.com/nexus/content/repositories/releases</url>
			<uniqueVersion>true</uniqueVersion>
		</repository>
		<snapshotRepository>
			<id>nexus</id>
			<name>snapshots</name>
			<url>http://mvn2.qdingnet.com/nexus/content/repositories/snapshots</url>
		</snapshotRepository>
	</distributionManagement>
	
</project>