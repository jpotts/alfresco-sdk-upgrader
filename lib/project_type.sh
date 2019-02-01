#!/usr/bin/env bash

# Returns true if the specified directory contains a pom.xml that depends on
# the alfresco-repository.
is_repo_project() {
  if grep -q "<artifactId>alfresco-repository<\/artifactId>" $1; then
      echo "This is an alfresco repo project"
      true
  else
      false
  fi
}

# Returns true if the specified directory contains a pom.xml that depends on
# share.
is_share_project() {
  if grep -q "<artifactId>share<\/artifactId>" $1; then
      echo "This is an alfresco share project"
      true
  else
      false
  fi
}

# Returns true if the specified directory contains a pom.xml that is a repo
# project and is also a share project.
is_aio_project() {
  if is_repo_project $1 == true && is_share_project $1 == true ; then
    echo "This is an all-in-one project"
    true
  else
    false
  fi
}

echo "Is this a repo project?"
is_repo_project $1/pom.xml

echo "Is this a share project?"
is_share_project $1/pom.xml

echo "Is this an AIO project?"
is_aio_project $1/pom.xml
