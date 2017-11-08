<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <groupId>{{project.packageName}}</groupId>
        <artifactId>{{project.name}}</artifactId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>{{project.name}}-admin-web</artifactId>
    <packaging>war</packaging>
    <name>{{project.name}}-admin-web</name>
    <description>{{project.name}}-admin-web</description>


    <properties>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
    </properties>

    <dependencies>
        <dependency>
            <groupId>{{project.packageName}}</groupId>
            <artifactId>{{project.name}}-service</artifactId>
            <version>1.0-SNAPSHOT</version>
        </dependency>
         <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
        </dependency> 
        
         <dependency>
            <groupId>com.qdingnet</groupId>
            <artifactId>manager-shiro</artifactId>
        </dependency>
    </dependencies>
    <build>
        <finalName>adminbg</finalName>
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

        </plugins>
    </build>
    <profiles>
        <profile>
            <id>{{project.name}}-dev</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <qding.log.leval>INFO</qding.log.leval>
                <qding.log.path>D:/output/{{project.name}}</qding.log.path>
                <qding.conf.path>D:/platform/{{project.name}}/</qding.conf.path>
            </properties>
        </profile>

        <profile>
            <id>online</id>
            <properties>
                <qding.log.leval>INFO</qding.log.leval>
                <qding.log.path>/data/logs/{{project.name}}</qding.log.path>
                <qding.conf.path>/data/qdconf/{{project.name}}/</qding.conf.path>
            </properties>
        </profile>
    </profiles>
</project>