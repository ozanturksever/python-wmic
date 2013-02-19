#!/bin/bash
self="prepare"
dst_dist="10.04"

function log {
    line=`date`" :${self}: $@"
    echo $line
#    echo $line >> $log_file
}

function die_with_error {
    if [ "$1" != "0" ]; then
        log $2
        exit 1
    fi
}


function start {
    log "--------------------------------------------start------------------------------------------------------------"
}

function finish {
    log "--------------------------------------------finish-----------------------------------------------------------"
}

function usage {
    echo "release.sh -n projectname -v 0.0.0 -p path_to_package_dir -r path_to_repository -t dst_dist"
    echo " -n : project_name"
    echo " -v : version"
    echo " -p : package path"
    echo " -r : repository path"
    echo " -t : dst dist"
    exit 1
}

while getopts "n:v:r:p:t:" OPTION
do
     case $OPTION in
         h)
             usage
             ;;
         n)
             project_name=$OPTARG
             ;;
         v)
             version=$OPTARG
             ;;
         d)
             dependency_file=$OPTARG
             ;;
         r)
             repository_directory=$OPTARG
             ;;
         p)
             package_directory=$OPTARG
             ;;
         t)
             dst_dist=$OPTARG
             ;;
         ?)
             usage
             ;;
     esac
done

if [ "$project_name"x == "x" ] || [ "$version"x == "x" ] || [ "$repository_directory"x == "x" ] || [ "$package_directory"x == "x" ]; then
    usage
fi

log "Starting to prepare ${package_directory} directory"
rm -rf ${package_directory}
mkdir -p ${package_directory}/usr/local/lib/samba4
mkdir -p ${package_directory}/usr/local/lib/python2.7/dist-packages/pysamba
mkdir -p ${package_directory}/usr/local/lib/python2.7/dist-packages/zenoss_utils
rsync -a --exclude=.git --exclude=debian/ --exclude=.idea --exclude=.DS_Store ${repository_directory}/bin/shared/ ${package_directory}/usr/local/lib/samba4/
rsync -a --exclude=.git --exclude=debian/ --exclude=.idea --exclude=.DS_Store ${repository_directory}/pysamba/ ${package_directory}/usr/local/lib/python2.7/dist-packages/pysamba
rsync -a --exclude=.git --exclude=debian/ --exclude=.idea --exclude=.DS_Store ${repository_directory}/zenoss_utils/ ${package_directory}/usr/local/lib/python2.7/dist-packages/zenoss_utils
