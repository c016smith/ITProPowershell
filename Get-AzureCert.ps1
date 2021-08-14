<#
.SYNOPSIS
Retrieve a domain's Azure tenant ID anonymously
Takes input from function and creates a local certificate which can be used for future powershelling with Certificate-Based Authentication (CBA) of certain powershell modules, as well as getting tokens for making REST calls to Graph API (or other APIs)


.DESCRIPTION
This function will anonymously retrieve a domain's Azure tenant ID using a provided email containing the target domain or a domain itself.

.PARAMETER Domain
The full domain of the Azure tenant.

.PARAMETER 

.EXAMPLE
Get-AzureCert contoso.com
Get-AzureCert contoso.onmicrosoft.com
Get-AzureCert -domain contoso.com -folderpath 'c:\temp\cert\'


.NOTES
HUGE credit to https://github.com/cporteou/PowerShell-Tools.git for the start of this script - I (c016smith) am brand new to using github and vscode for powershell scripts, so I got this module from him but not sure how to include it in my project while appropriately crediting this developer. Apologies in advance; would like to learn how to fork and merge other people's code into the middle of my own project that has other functionality, but I'm a total noob at the moment. : ) Thanks for understanding. 
I've removed the functionality of the -email flag and only using domain as an input, and also made this mandatory.
General notes - taking this function and expanding it to produce the full certificate and export (prompting for path). 

#>

function Get-AzureCert{

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [ValidateScript({$_ -notmatch "@"})]
        [string]
        $domain, 
        [Parameter()]
        [ValidateScript({Test-path $_ })]
        [string[]]$folderpath
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

        #personal notes //remove later// - this was from powershell repo with localsecretcertificate.ps1 on onedrive
        # Your tenant name (can something more descriptive as well)

if (!($folderpath)) {[ValidateScript({Test-path $_ })]$folderpath = read-host "What folder location?"}



FolderBrowserDialog diag = new FolderBrowserDialog();  
if (diag.ShowDialog() == System.Windows.Forms.DialogResult.OK)  
{  
    string folder = diag.SelectedPath;  //selected folder path
  
}  

$SaveChooser = New-Object -TypeName System.Windows.Forms.SaveFileDialog
$SaveChooser.ShowDialog()
Get-iLPHighCPUProcess | Out-File $SaveChooser.Filename



# Where to export the certificate without the private key
$CerOutputPath     = "C:\Temp\AzureCert.cer"

# What cert store you want it to be in
$StoreLocation     = "Cert:\CurrentUser\My"

# Expiration date of the new certificate
$ExpirationDate    = (Get-Date).AddYears(2)


# Splat for readability
$CreateCertificateSplat = @{
    FriendlyName      = "AzureApp"
    DnsName           = $TenantName
    CertStoreLocation = $StoreLocation
    NotAfter          = $ExpirationDate
    KeyExportPolicy   = "Exportable"
    KeySpec           = "Signature"
    Provider          = "Microsoft Enhanced RSA and AES Cryptographic Provider"
    HashAlgorithm     = "SHA256"
}

# Create certificate
$Certificate = New-SelfSignedCertificate @CreateCertificateSplat

# Get certificate path
$CertificatePath = Join-Path -Path $StoreLocation -ChildPath $Certificate.Thumbprint

# Export certificate without private key
Export-Certificate -Cert $CertificatePath -FilePath $CerOutputPath | Out-Null

        return $tenantId
    }

}