#!/bin/bash
#script to kill processes and run a jar file located in the install folder
PROJECT="spring-boot-hello-world"
mvn clean package
INSTALL_FOLDER="${JENKINS_HOME}/${PROJECT}"

# delete old process
PID_FILE="${INSTALL_FOLDER}/PID"
OLD_PID=$(cat ${PID_FILE}) 
kill -9 $OLD_PID

# remove old files
rm -rf $INSTALL_FOLDER
mkdir -p $INSTALL_FOLDER

# copy in the new files
cp target/hello-world*.jar ${INSTALL_FOLDER}/${PROJECT}.jar

# run the new app
BUILD_ID=dontKillMe java -jar ${INSTALL_FOLDER}/${PROJECT}.jar &
echo $!>${PID_FILE}
disown
