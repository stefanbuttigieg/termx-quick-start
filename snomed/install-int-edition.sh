#!/bin/bash

# Check if a file path is provided as an argument
if [ $# -eq 0 ]; then
    echo "Please provide the filename for import as an argument."
    exit 1
fi

# Get the file path from the argument
FILENAME="$1"

# Check if the file exists
if [ ! -f "$FILENAME" ]; then
    echo "File not found: $FILENAME"
    exit 1
fi

RESPONSE=$( curl -v -i -k -X POST \
  -H 'accept: */*' \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d '{
        "type": "SNAPSHOT",
        "branchPath": "MAIN",
        "createCodeSystemVersion": true,
        "internalRelease": false,
        "filterModuleIds": []
      }' \
  'http://localhost:8080/imports'
)

LOCATION=$(echo "$RESPONSE" | grep -i "Location:" | awk '{print $2}' | tr -d '\r')
#echo "Location: $LOCATION"

UPLOAD_URL=$(printf "%s/%s" "$LOCATION" "archive")
#echo "Upload url: $UPLOAD_URL"

echo ">>> Import of $FILENAME"
echo ">>> to $UPLOAD_URL started."
echo ">>> It may take a time."

RESPONSE=$(curl -v -i -k -X POST \
  -H "Content-Type: multipart/form-data" \
  -H "Accept: */*" \
  -F "file=@$FILENAME;type=application/zip" \
  -w "%{http_code}" \
  "$UPLOAD_URL"
)

echo "$RESPONSE"

echo "Import in progress. Execute 'docker logs -f snowstorm' for details"
