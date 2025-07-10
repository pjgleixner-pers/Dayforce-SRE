$url = "https://dog.ceo/api/breeds/list/all"
$response = Invoke-RestMethod -Uri $url -Method Get



