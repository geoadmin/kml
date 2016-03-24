#!/bin/bash


# Colors
RESET=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)


function is_schema {
   local schema=$1
   local file=$2
   local status
   
   status=$(grep -cim1 ${schema} ${file})

   return $status

}



function status_code {
    "$@" 2>&-
    local status=$?

    #echo "status=${status}"
    if [ $status -ne 0 ]; then
      #echo "error with $1" >&2
      echo "${RED}  -->FAIL${RESET}" 
    else
      echo "${GREEN}  --> OK${RESET}"
    fi
    return $status
}

KMLS=$(find . -name "*.kml")

## XSD Schemas

# Google extensions to OGC KML 2.2
#KML22GX='https://developers.google.com/kml/schema/kml22gx.xsd'
KML22GX='schemas/kml22gx.xsd'
# OGC KML 2.2 obviously
OGCKML22='http://schemas.opengis.net/kml/2.2.0/ogckml22.xsd'
# OGC KML 2.3
OGCKML23="http://schemas.opengis.net/kml/2.3/ogckml23.xsd"

#http://earth.google.com/kml/2.2



for kml in ${KMLS}; do
    echo "-----"
    echo ${kml}
    status=$(grep -cim1 $(basename ${KML22GX}) ${kml})
    echo "  XML well-formed " $(status_code xmllint --noout "${kml}")
    echo "  KML2GX schema   " $(status_code xmllint --noout   --schema ${KML22GX} "${kml}")
    echo "  OGCKML22 schema " $(status_code xmllint --noout   --schema ${OGCKML22} "${kml}") 
    echo "  OGCKML23 schema " $(status_code xmllint --noout   --schema ${OGCKML23} "${kml}") 

done
