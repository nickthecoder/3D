#!/bin/bash

# Creates stl files from scad files

PROFILE="low"

while [[ $# -gt 1 ]]
do
    key="$1"

    case $key in
        -p|--profile)
        PROFILE="$2"
        shift # past argument
        ;;

        *)
        break;
    esac

    shift # past argument or value

done

if [ ! -f "${PROFILE}" ]
then
    PROFILE=~/etc/cura/${PROFILE}.ini
fi

if [ ! -f "${PROFILE}" ]
then
    echo "Cura profile not found. ${PROFILE}"
    exit
fi

echo "Using cura profile : ${PROFILE}"

for in in "$@"
do
    path="${in%.*}"
    name=$(basename "${path}")

    stl="${path}.stl"
    gcode="/gidea/tmp/print/${name}.gcode"
    profile=
    
    echo "Converting ${in} to ${out} then to ${gcode}"
    
    /media/home/gidea/projects/openscad/20150-03-03/openscad/openscad -o "${stl}" "${in}"
    cura -s -p "${profile}" -o "${gcode}" "${stl}"
    echo

done

echo Done

