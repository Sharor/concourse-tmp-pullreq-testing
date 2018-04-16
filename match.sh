#!/bin/bash
fullversion=$1
echo $fullversion
counter=$((0))
major=$(($( echo $1|cut -d. -f1 )))
minor=$(($( echo $1|cut -d. -f2 )))
patch=$(($( echo $1|cut -d. -f3 )))

IFS=$'\n'
for version in $(git log master..HEAD --format=%B); do 
  echo "$version"; 
  if [[ $version =~ .[0-9]*major.* ]] ; then 
    let major=major+1
    let minor=0 
    let patch=0
    echo "$major.$minor.$patch"
    exit 0
  fi  

  if [[ $version =~ .[0-9]*minor.* ]] ; then 
    let counter=counter+1
  fi  
done

if [[ $counter -gt 0]] ; then     
    let minor=minor+1 
    let patch=0
else 
  let patch=patch+1
fi  
echo "$major.$minor.$patch"