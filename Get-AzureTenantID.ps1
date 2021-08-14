<#
.SYNOPSIS
Retrieve a domain's Azure tenant ID anonymously

.DESCRIPTION
This function will anonymously retrieve a domain's Azure tenant ID using a provided email containing the target domain or a domain itself.

.PARAMETER Domain
The full domain of the Azure tenant.

.EXAMPLE
Get-AzureTenantID -Domain craigporteous.com
Get-AzureTenantID -Domain craigporteous.onmicrosoft.com


.NOTES
Full credit to https://github.com/cporteou/PowerShell-Tools.git for this script - I (c016smith) am brand new to using github and vscode for powershell scripts, so I got this module from him but not sure how to include it in my project while appropriately crediting this developer. Apologies in advance; would like to learn how to fork and merge other people's code into the middle of my own project that has other functionality, but I'm a total noob at the moment. : ) Thanks for understanding. 
I've removed the functionality of the -email flag and only using domain as an input, and also made this mandatory.
General notes

#>

function Get-AzureTenantId{

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateScript({$_ -notmatch "@"})]
        [string]
        $domain
    )

    Process{
        if($domain){
            Write-Verbose 'Domain provided.'
        }
        
        else{
            throw
            Write-Warning 'You must provide a valid Domain to proceed.'
        }

        Write-Verbose 'Query Azure anonymously.'
        $tenantId = (Invoke-WebRequest -UseBasicParsing https://login.windows.net/$($Domain)/.well-known/openid-configuration|ConvertFrom-Json).token_endpoint.Split('/')[3]

        return $tenantId
    }

}
