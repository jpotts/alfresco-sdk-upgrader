#!/usr/bin/env bash

# Use the existing group, artifact, and version instead of these dummy values
# so that the base will match the project we are upgrading
GROUP_ID=com.metaversant
ARTIFACT_ID=aio-400
VERSION=1.0-SNAPSHOT

# Removes the hidden "base" directory
function remove_base() {
  if [ -d .base-sdk-project ] ; then
    rm -rf .base-sdk-project
  fi
}

# Creates a hidden "base" directory and generates a project using the SDK to
# use as a source for files to copy into the target project
function setup_base() {
  # Remove the base if it exists
  remove_base

  # Make a hidden directory to hold our "base" project
  mkdir .base-sdk-project

  # Change into the directory
  cd .base-sdk-project

  # Generate a base 4.0.0 project
  echo `mvn archetype:generate \
    -DinteractiveMode=false \
    -DarchetypeGroupId=org.alfresco.maven.archetype \
    -DarchetypeArtifactId=alfresco-allinone-archetype \
    -DarchetypeVersion=4.0.0-beta-1 \
    -DgroupId=$1 \
    -DartifactId=$2 \
    -Dversion=$3`

}

setup_base $GROUP_ID $ARTIFACT_ID $VERSION
