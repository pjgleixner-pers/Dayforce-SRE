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

#interview answer
<# 
$url = "https://dog.ceo/api/breeds/list/all"
$response = Invoke-RestMethod -Uri $url -Method Get

Write-Host $response
 #>
#Post interview answer
#1. 
$uri = "https://dog.ceo/api/breeds/list/all"
try {
    $response = Invoke-RestMethod -Uri $uri -Method Get
    $breedsData = $response.message
    Write-Host "Successfully retrieved dog breeds data" -ForegroundColor Green
}
catch {
    Write-Host "Failed to fetch dog breeds: $_" -ForegroundColor Red
    exit 1
}

#2. 
$flattenedBreeds = @()

foreach ($breed in $breedsData.PSObject.Properties) {
    $breedName = $breed.Name
    $subBreeds = $breed.Value

    if ($subBreeds.Count -eq 0) {
        $flattenedBreeds += [PSCustomObject]@{
            breed_name = $breedName
            sub_breed_name = $null
        }
    }
    else {
        foreach ($subBreed in $subBreeds) {
            $flattenedBreeds += [PSCustomObject]@{
                breed_name = $breedName
                sub_breed_name = $subBreed
            }
        }
    }
}

# Output the results
Write-Host "`nFlattened breeds list:" -ForegroundColor Cyan
$flattenedBreeds | Format-Table -AutoSize