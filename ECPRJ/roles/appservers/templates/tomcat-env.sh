#!/bin/bash
# 
# The tomcat configuration file.
# $Id: tomcat-env.sh 127 2009-06-08 07:54:12Z jasonb $

# Where this config file may be found when it's installed.
APP_ENV="/opt/tomcat/conf/tomcat-env.sh"

# Where your Java installation lives.  Unfortunately, this must be
# hard-coded here because JAVA_HOME on the build machine may not be
# the proper JAVA_HOME on the machine the webapp is deployed onto.
# Tomcat 7.0.x runs on Java 1.6.0 or higher.
JAVA_HOME="/usr/java/latest"

# Where your Tomcat installation lives.
CATALINA_HOME="/opt/tomcat"
JASPER_HOME="/opt/tomcat"
CATALINA_TMPDIR="/opt/tomcat/temp"

# The path to this application's writeable runtime Tomcat tree.
CATALINA_BASE="/opt/tomcat"

# The ID of this package's JVM.
JVM_ID="tomcat"

# Set JPDA_OPTS as shown below if you want to run the JPDA debugger (server)
# in the Tomcat JVM.  See this page for more information about JPDA options:
# http://java.sun.com/javase/6/docs/technotes/guides/jpda/conninv.html
#JPDA_OPTS="-Xdebug \
#  -Xrunjdwp:transport=dt_socket,address=8000,server=y,suspend=n"

# When using Java 1.5 ("Java 5") or higher, you may set JMX_OPTS to
# enable the built-in JMX monitoring/management agent connector.  Use
# jconsole to connect to it.
# See http://java.sun.com/j2se/1.5.0/docs/guide/management/agent.html
#
# Uncomment this block to enable localhost-only JMX:
JMX_OPTS="-Dcom.sun.management.jmxremote"

# Uncomment this block to enable remote JMX (make sure hostname -i does
# not resolve to '127.0.0.1' or it won't work.. edit /etc/hosts to fix it):
#JMX_OPTS="-Dcom.sun.management.jmxremote.port=8008 \
#  -Dcom.sun.management.jmxremote.ssl=false \
#  -Dcom.sun.management.jmxremote.authenticate=false \
#  -Dcom.sun.management.jmxremote.password.file=/path/to/password/file"
#  -Dcom.sun.management.jmxremote.access.file=/path/to/access/file"

# You can pass extra JVM startup parameters to java here if you wish.
#
# Single Processor
#
#JAVA_OPTS="-server -Djvm=$JVM_ID -Xms1024m -Xmx1024m -Xmn512m -XX:PermSize=256m -XX:MaxPermSize=512m \
#   -Xss256k -XX:+DisableExplicitGC -XX:SurvivorRatio=1 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC \
#   -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:CMSFullGCsBeforeCompaction=5 \
#   -XX:+CMSClassUnloadingEnabled -XX:LargePageSizeInBytes=128M -XX:+UseFastAccessorMethods -XX:SurvivorRatio=4 \
#   -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 -XX:SoftRefLRUPolicyMSPerMB=0 \
#   -XX:+CMSIncrementalMode -XX:MaxTenuringThreshold=31 -Djava.awt.headless=true $JPDA_OPTS $JMX_OPTS"
#
# Multiprocessor
#
JAVA_OPTS="-server -Djvm=$JVM_ID -Xms{{ jvm_min }} -Xmx{{ jvm_max }} -Xmn512m -XX:NewSize=256m -XX:MaxPermSize=512m \
   -Xss256k -XX:+DisableExplicitGC -XX:SurvivorRatio=8 -XX:+UseConcMarkSweepGC -XX:+UseParNewGC \
   -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:CMSFullGCsBeforeCompaction=5 \
   -XX:+CMSClassUnloadingEnabled -XX:LargePageSizeInBytes=128M -XX:+UseFastAccessorMethods \
   -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 -XX:SoftRefLRUPolicyMSPerMB=0 \
   -XX:ParallelGCThreads=20 -XX:MaxTenuringThreshold=31 -Djava.awt.headless=true -Dsun.net.inetaddr.ttl=60 \
   -Dcom.longkey.eboss.serverMode=test \
   -Dcom.longkey.eboss.deploymentId=P -Dcom.longkey.eboss.deploymentType=slave:8080/ec/services/RemoteCall -Dcom.longkey.eboss.deploymentMaster=172.16.0.61:8080/ec/services/RemoteCall \
   -XX:TargetSurvivorRatio=90 $JPDA_OPTS $JMX_OPTS"
CATALINA_OPTS="-Djava.library.path=/usr/lib64"
#CATALINA_OPTS="-Djava.library.path=/usr/lib"

# This option makes the JVM's default character encoding UTF-8, which  
# usually helps with internationalization/localization.
JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8 -DjavaEncoding=UTF-8"

# Uncomment this option to turn on the Java SecurityManager, and set the
# security policy file.  If you do not set the policy file path here, the
# default is to use $CATALINA_BASE/conf/catalina.policy.  NOTE: these
# options should be commented out in nearly all Tomcat installations!
# Note that the double equals on the security policy setting is required.
#JAVA_OPTS="$JAVA_OPTS -Djava.security.manager \
#  -Djava.security.policy==$CATALINA_BASE/conf/catalina.policy"

# Uncomment this option to get JVM debug info from the SecurityManager and
# also other security libraries such as JSSE.  By enabling this, you can
# debug HTTPS and X.509 certificate problems -- gives verbose debug log data!
#JAVA_OPTS="$JAVA_OPTS -Djava.security.debug=all"

# Uncomment this option to make the JVM log network stack debugging info.  See:
# http://java.sun.com/javase/6/docs/technotes/guides/security/jsse/JSSERefGuide.html#Debug
#JAVA_OPTS="$JAVA_OPTS -Djava.net.debug=all"

# Uncomment this option to set the security manager implementation.
#JAVA_OPTS="$JAVA_OPTS -Djava.security.manager=[put-class-name-here]"

# Uncomment this option to make the JVM print some detailed information
# about what's in the heap if it throws an OutOfMemoryError. Another
# way to inspect the heap is to use this command:
# jmap -dump:format=b,file=heap.hprof 17470
# .. where 17470 is the process ID of the Tomcat JVM.  Use the command:
# jhat -J-Xmx800M heap.hprof
# .. to analyze the heap dump.
#JAVA_OPTS="$JAVA_OPTS -XX:+HeapDumpOnOutOfMemoryError \
#  -XX:HeapDumpPath=/opt/TcatServer7/logs/tomcat-oome-heap-dump.hprof"

# Uncomment this option to set the SMTP relay server that JavaMail should
# use when sending emails.  Use -Dmail.debug to turn on debugging.
# If this is unset, Javamail defaults to using localhost's SMTP server.
#JAVA_OPTS="$JAVA_OPTS -Dmail.smtp.host=mail.host.example.com"

# USER must be set here because the regular user's shell setting is not
# passed through to the init script by the "service" command.
USER="`id -u -n`"

# What user should run tomcat.
TOMCAT_USER="tomcat"

# You can change your Tomcat locale here.  The default is your OS's default
# locale that you specified at OS installation time.
#LANG=en_US

# Time to wait in seconds before sending signals to stop the JVM process.
# The total maximum wait time is three times the number you set here!
# One SHUTDOWN_WAIT duration waiting for a Tomcat shutdown command to
# bring down the JVM, another SHUTDOWN_WAIT duration waiting for a
# SIGTERM signal to bring it down if the shutdown command failed to, and
# one last SHUTDOWN_WAIT duration after sending a SIGKILL if the SIGTERM
# failed to bring it down.
let SHUTDOWN_WAIT=4

# If you wish to further customize your tomcat environment, put your own
# definitions here (i.e. LD_LIBRARY_PATH for the APR connector's lib
# directory, some jdbc driver libs, etc).  Just do not forget to export them.
#
# If you wish to use the APR connector, point LD_LIBRARY_PATH to the
# directory that contains the libtcnative-1.so.0 shared library file
# (possibly with newer numbers on the file name).
#export LD_LIBRARY_PATH=/opt/tomcat/apr-connector/lib
