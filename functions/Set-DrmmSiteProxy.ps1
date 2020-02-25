function Set-DrmmSiteProxy {

	<#
	.SYNOPSIS
	Updates the proxy settings for the site identified by the given site Uid.

	.PARAMETER siteUid
	Provide site uid which will be used to update proxy settings.

	.PARAMETER host
	Proxy host name (IP Address or URL).

	.PARAMETER port
	Proxy port. 

	.PARAMETER type
	Proxy type (http, socks4, or socks5). 

	.PARAMETER username
	Proxy username.

	.PARAMETER password
	Proxy password.

	#>

	# Function Parameters
    Param (
        [Parameter(Mandatory=$True)] 
        $siteUid,

        [Parameter(Mandatory=$True)] 
        $proxyHost,

        [Parameter(Mandatory=$True)] 
        $proxyPort,

	    [Parameter(Mandatory=$True)]
		[ValidateSet('http','socks4','socks5')]
        $proxyType,

        [Parameter(Mandatory=$False)] 
        $username,

		[Parameter(Mandatory=$False)] 
        $password

    )

	# Declare Variables
	$apiMethod = 'PUT'
	$Results = @()
	$proxySettings = @{}
	
	# Add proxy details
	$proxySettings.Add('host',$proxyHost)
	$proxySettings.Add('port',$proxyPort)
	$proxySettings.Add('type',$proxyType)
	If ($PSBoundParameters.ContainsKey('username')) {$proxySettings.Add('username',$username)}
	If ($PSBoundParameters.ContainsKey('password')) {$proxySettings.Add('password',$password)}


	# Convert to JSON
	$Body = $proxySettings | ConvertTo-Json


	# Update UDFs
	$Results = New-ApiRequest -apiMethod $apiMethod -apiRequest "/v2/site/$siteUid/setting/proxy" -apiRequestBody $Body | ConvertFrom-Json
	return $Results

}