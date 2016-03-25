#!/bin/bash

KMLS=$(find . -name "*.kml")

for kml in ${KMLS}; do
    echo "-- Formatting"
    echo ${kml}
    xmllint --format ${kml} > test.kml
    mv test.kml ${kml}
done