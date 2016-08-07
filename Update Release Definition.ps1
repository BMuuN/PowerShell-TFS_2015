<#
    .TITLE
        Update Release Manager definition.

    .CREATED_BY
        Bleddyn Richards

    .CREATED_DATE
        13/06/2016

    .DESCRIPTION
        Updates a Release Manager definition within TFS 2015 using the REST API.
        The Release Manager definition must be in JSON format.

    .PARAMETERS
        .filePath
            The full path to the release definition.

        .definitionId
            The unique id of the release definition to update.

    .EXAMPLE
        '.\Update Release Manager.ps1' "C:\Dev-Team.Deploy" "3"
#>

# Command Arguments
param (
    [string]$filePath,
    [string]$definitionId
)

# Check a file path is supplied
if([string]::IsNullOrEmpty($filePath)) {
    Write-Host "The -filePath parameter is required e.g .C:\Dev-Team.Deploy"
    Exit
}

# Check if a definition id is supplied
if([string]::IsNullOrEmpty($definitionId)) {
    Write-Host "The -definitionId parameter is required e.g 8"
    Exit
}

# set local variables
$username =  'DOMAIN\USRNAME'
$password  =  'PASSWORD'
$body = Get-Content $filePath
$resource = "http://TFS_URL/_apis/release/definitions/$definitionId`?api-version=2.2-preview.1"
$cred = New-Object System.Management.Automation.PSCredential($username, (ConvertTo-SecureString -String $password -AsPlainText -Force))

#Write-Host $filePath
#Write-Host $body
#Write-Host $resource

Invoke-RestMethod -Method Put -Uri "$resource" -Credential $cred -ContentType "application/json" -Body $body
