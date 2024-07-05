# Lithuanian Edition
1. Create the code system

curl -v -X POST --header 'Content-Type: application/json' \
--header 'Accept: application/json' -d '{
  "branchPath": "MAIN/SNOMEDCT-LT",
  "shortName": "SNOMEDCT-LT",
  "name": "Lithuanian Edition",
  "countryCode": "lt",
  "owner": "Lithuanian Medical Library"
}' 'http://localhost:8080/codesystems'

2. Create the import

curl -v -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{
  "branchPath": "MAIN/SNOMEDCT-LT",
  "createCodeSystemVersion": true,
  "type": "SNAPSHOT"
}' 'http://localhost:8080/imports'

3. Import the national extension

curl -v -X POST --header 'Content-Type: multipart/form-data' --header 'Accept: application/json' \
-F file=@SnomedCT_ManagedServiceEE_PRODUCTION_EE1000181_20200530T120000Z.zip \
'http://localhost:8080/imports/<importid>/archive'


curl -v -X POST --header 'Content-Type: multipart/form-data' --header 'Accept: application/json' \
-F file=@SNOMED-LT-20151228-and-20190603.zip \
'http://localhost:8080/imports/efe2b1a2-d5fb-4acd-9ede-e380989526a2/archive'



# Estonian Edition

1. Create the code system

curl -v -X POST --header 'Content-Type: application/json' \
--header 'Accept: application/json' -d '{
  "branchPath": "MAIN/SNOMEDCT-EE",
  "shortName": "SNOMEDCT-EE",
  "name": "Estonian Edition",
  "countryCode": "ee",
  "owner": "Estonia Health and Welfare Information Systems Centre"
}' 'http://localhost:8080/codesystems'

2. Create the import

curl -v -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{
  "branchPath": "MAIN/SNOMEDCT-EE",
  "createCodeSystemVersion": true,
  "type": "SNAPSHOT"
}' 'http://localhost:8080/imports'

3. Import the national extension

curl -v -X POST --header 'Content-Type: multipart/form-data' --header 'Accept: application/json' \
-F file=@SnomedCT_ManagedServiceEE_PRODUCTION_EE1000181_20200530T120000Z.zip \
'http://localhost:8080/imports/<importid>/archive'


curl -v -X POST --header 'Content-Type: multipart/form-data' --header 'Accept: application/json' \
-F file=@xSnomedCT_ManagedServiceEE_PREPRODUCTION_EE1000181_20240530T120000Z_version2.zip \
'http://localhost:8080/imports/2d966a64-5c76-4ee9-9281-d67b60f4f3d1/archive'

# Belgium Edition

1. Create the code system

curl -v -X POST --header 'Content-Type: application/json' \
--header 'Accept: application/json' -d '{
  "branchPath": "MAIN/SNOMEDCT-BE",
  "shortName": "SNOMEDCT-BE",
  "name": "Belgian Edition",
  "countryCode": "be",
  "owner": "Belgian Federal Public Service Health, Food Chain Safety and Environment"
}' 'http://localhost:8080/codesystems'

2. Create the import

curl -v -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{
  "branchPath": "MAIN/SNOMEDCT-BE",
  "createCodeSystemVersion": true,
  "type": "SNAPSHOT"
}' 'http://localhost:8080/imports'

3. Import the national extension

curl -v -X POST --header 'Content-Type: multipart/form-data' --header 'Accept: application/json' \
-F file=@SnomedCT_ManagedServiceBE_PRODUCTION_BE1000172_20231115T120000Z.zip \
'http://localhost:8080/imports/b9c66a92-2376-48eb-8861-42f59f3e820f/archive'
