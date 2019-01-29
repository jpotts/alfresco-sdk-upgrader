#!/bin/bash
echo -n Please enter the absolute path of the project you want to upgrade:
read ans
echo checking that $ans exists
if [ ! -d "$ans" ]; then
  echo sorry, does not exist. Exiting.
exit 1
else
  PROJECT_PATH=$ans
  PROJECT_POM=$PROJECT_PATH/pom.xml
  PROJECT_NAME=$(echo | grep -m 1 '<artifactId' ${PROJECT_POM} | cut -f2 -d">"|cut -f1 -d"<")
fi

# Get current 4.0 SDK
./create_base.sh

# BACKUP CURRENT 3.0 PROJECT
echo backing up $PROJECT_PATH to: $PWD/.backups
BACKUP_PATH=$(basename $PROJECT_PATH).$(date +%F)
mkdir -p .backups/$BACKUP_PATH
cp -a $PROJECT_PATH/* .backups/$BACKUP_PATH

# Removing src, run.*, debug.* from target project
echo Remove the root src directory from the root of the target project.
rm -rf $PROJECT_PATH/src
echo  Remove run.* and debug.* from the root of the target project.
rm -f $PROJECT_PATH/run.* $PROJECT_PATH/debug.*

cp .base-sdk-project/aio-400/run.* $PROJECT_PATH/

# Clean up the references in the copied scripts
# TODO

#Copy the docker directory from base into target

# Recursively copy the docker directory from base into target.
cp -r .base-sdk-project/aio-400/docker $PROJECT_PATH/

# Clean up references in the docker-compose.yml file.
# TODO


#Recursively copy the *-platform-docker directory into target
#Rename the directory. 
mkdir $PROJECT_PATH/$PROJECT_NAME-platform-docker
cp -r .base-sdk-project/aio-400/*-platform-docker/* $PROJECT_PATH/$PROJECT_NAME-platform-docker

#Clean up references in the platform-docker directory in target
#If you copied a target directory from the base, remove it.
rm -rf $PROJECT_PATH/$PROJECT_NAME-platform-docker/target
#Change references in alfresco-global.properties from the base project name to the target.
#Change references in pom.xml from the base project name to the target.
#Change references in hotswap-agent.properties from the base project name to the target.

#Recursively copy the *-share-docker directory into target
mkdir $PROJECT_PATH/$PROJECT_NAME-share-docker
cp -r .base-sdk-project/aio-400/*-platform-docker/* $PROJECT_PATH/$PROJECT_NAME-share-docker
#Clean up references in the platform-docker directory in target
#If you copied a target directory from the base, remove it.
rm -rf $PROJECT_PATH/$PROJECT_NAME-share-docker/target
#Change references in alfresco-global.properties from the base project name to the target.
#Change references in pom.xml from the base project name to the target.
#Change references in hotswap-agent.properties from the base project name to the target.

