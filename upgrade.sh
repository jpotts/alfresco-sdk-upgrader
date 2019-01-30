#!/bin/bash

echo -n Please enter the absolute path of the project you want to upgrade:
read ans
echo checking that $ans exists...
if [ ! -d "$ans" ]; then
  echo sorry, does not exist. Exiting.
exit 1
else
  echo OK let\'s go! Getting current project info...
  PROJECT_PATH=$ans
  PROJECT_POM=$PROJECT_PATH/pom.xml
  PROJECT_NAME=$(echo | grep -m 1 '<artifactId' ${PROJECT_POM} | cut -f2 -d">"|cut -f1 -d"<")
  GROUP_ID=$(echo | grep -m 1 '<groupId' ${PROJECT_POM} | cut -f2 -d">"|cut -f1 -d"<")
  VERSION=$(echo | grep -m 1 '<version' ${PROJECT_POM} | cut -f2 -d">"|cut -f1 -d"<")
fi

# Get current 4.0 SDK
echo Downloading the SDK v4.0.0 into $PWD/.base-sdk-project...
. ./create_base.sh
cd ..

# BACKUP CURRENT 3.0 PROJECT
echo backing up $PROJECT_PATH to: $PWD/.backups...
BACKUP_PATH=$(basename $PROJECT_PATH).$(date +"%Y%m%d%H%M%S")
mkdir -p .backups/$BACKUP_PATH
cp -a $PROJECT_PATH/* .backups/$BACKUP_PATH

echo Replacing/Merging files...
# Remove src, run.*, debug.* from target project
rm -rf $PROJECT_PATH/src
rm -f $PROJECT_PATH/run.* $PROJECT_PATH/debug.*

# Copy files/dirs from base to target project
cp .base-sdk-project/$PROJECT_NAME/run.* $PROJECT_PATH/
chmod +x $PROJECT_PATH/run.*

cp -r .base-sdk-project/$PROJECT_NAME/docker $PROJECT_PATH/

mkdir $PROJECT_PATH/$PROJECT_NAME-platform-docker
cp -r .base-sdk-project/$PROJECT_NAME/*-platform-docker/* $PROJECT_PATH/$PROJECT_NAME-platform-docker

#If you copied a target directory from the base, remove it.
rm -rf $PROJECT_PATH/$PROJECT_NAME-platform-docker/target

#Recursively copy the *-share-docker directory into target
mkdir $PROJECT_PATH/$PROJECT_NAME-share-docker
cp -r .base-sdk-project/$PROJECT_NAME/*-share-docker/* $PROJECT_PATH/$PROJECT_NAME-share-docker

#If you copied a target directory from the base, remove it.
rm -rf $PROJECT_PATH/$PROJECT_NAME-share-docker/target

# Move over pom.xml files to get demo working. In the future, we will need to do intelligent diff/merge of these pom.xml files.
yes | cp .base-sdk-project/$PROJECT_NAME/pom.xml $PROJECT_PATH/
yes | cp .base-sdk-project/$PROJECT_NAME/*-platform-jar/pom.xml $PROJECT_PATH/$PROJECT_NAME-platform-jar/
yes | cp .base-sdk-project/$PROJECT_NAME/*-share-jar/pom.xml $PROJECT_PATH/$PROJECT_NAME-share-jar/

echo GOOD TO GO!
echo -------------
echo Try this:
echo cd $PROJECT_PATH
echo "./run.sh build_start"

# alfresco-global.properties
# pom.xml files
# hotswap-agent.properties