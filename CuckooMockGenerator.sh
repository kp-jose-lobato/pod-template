#!/bin/bash

# While building, XCode might start indexing which would trigger this task and fail the build due to files being regenerated
# We exit early while indexing to avoid this issue
# https://stackoverflow.com/a/69481200
if [ $ACTION == "indexbuild" ]; then
 exit 0
fi

find ${POD_NAME}/${POD_NAME}/Sources \
 -name '*.swift' -exec echo -n '"{}" ' \; | grep -v '/generated\.' | xargs ${PODS_ROOT}/Cuckoo/run generate --testable '${POD_NAME}' --output "${POD_NAME}/${POD_NAME}/Tests/Mocks/${POD_NAME}-Mocks.generated.swift"

