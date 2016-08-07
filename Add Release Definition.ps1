<#
    .TITLE
        Add Release Manager definition.

    .CREATED_BY
        Bleddyn Richards

    .CREATED_DATE
        12/07/2016

    .DESCRIPTION
        Updates a Release Manager definition within TFS 2015 using the REST API.
        The Release Manager definition must be in JSON format.

    .PARAMETERS
        .filePath
            The full path to the release definition.

    .EXAMPLE
        '.\Add Release Manager.ps1' "C:\Dev-Team.Deploy"
#>

# Command Arguments
param (
    [string]$filePath
)

# Check a file path is supplied
if([string]::IsNullOrEmpty($filePath)) {
    Write-Host "The -filePath parameter is required e.g .C:\Dev-Team.Deploy"
    Exit
}

# set local variables
$username =  'DOMAIN\USRNAME'
$password  =  'PASSWORD'
$body = Get-Content $filePath
$resource = "http://TFS_URL/_apis/release/definitions`?api-version=2.2-preview.1"
$cred = New-Object System.Management.Automation.PSCredential($username, (ConvertTo-SecureString -String $password -AsPlainText -Force))

#Write-Host $filePath
#Write-Host $body
#Write-Host $resource

Invoke-RestMethod -Method Post -Uri "$resource" -Credential $cred -ContentType "application/json" -Body $body
