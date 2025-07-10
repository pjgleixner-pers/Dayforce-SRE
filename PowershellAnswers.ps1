# Using Dog API (https://dog.ceo/dog-api/documentation/)
# Write a script that does the following tasks:
# 1. Retrieves a list of all dog breeds from the API
# 2. flattens the array of subreeds into a new list consisting of 
# dictionaries for each breed and sub_breed
# Example: 
# {
#  "affenpinscher": [],
#  "australian"   : [
#                    "kelpie",
#                    "shepherd"
#                   ]
#    
# }
# would be flattened into ->
# [
#  {'breed_name': 'affenpinscher', 'sub_breed_name': None},
#  {'breed_name': 'australian', 'sub_breed_name': "kelpie"},
#  {'breed_name': 'australian', 'sub_breed_name': "shepherd"},
#]

$url = "https://dog.ceo/api/breeds/list/all"
$response = Invoke-RestMethod -Uri $url -Method Get