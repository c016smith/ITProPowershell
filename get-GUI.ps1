#sourced from https://lazyadmin.nl/powershell/powershell-gui-howto-get-started/
#come back to this at some point, would be cool but have no idea what I'm doing. Also curious if VS Code works with any of that, as building GUI rather than guessing pixel heights, etc. 

# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
# Create a new form
$AzureCertForm                    = New-Object system.Windows.Forms.Form
# Define the size, title and background color
$AzureCertForm.ClientSize         = '500,300'
$AzureCertForm.text               = "CMoney - PowerShell GUI Example"
$AzureCertForm.BackColor          = "#ffffff"
# Display the form
[void]$AzureCertForm.ShowDialog() 


# Create a Title for our form. We will use a label for it.
$Titel                           = New-Object system.Windows.Forms.Label

# The content of the label
$Titel.text                      = "Generate local certificate to manage Azure and Microsoft Graph API"

# Make sure the label is sized the height and length of the content
$Titel.AutoSize                  = $true

# Define the minial width and height (not nessary with autosize true)
$Titel.width                     = 25
$Titel.height                    = 10

# Position the element
$Titel.location                  = New-Object System.Drawing.Point(20,20)

# Define the font type and size
$Titel.Font                      = 'Microsoft Sans Serif,13'

# Other elemtents
$Description                     = New-Object system.Windows.Forms.Label
$Description.text                = "Add a new construction site printer to your computer. Make sure you are connected to the network of the construction site."
$Description.AutoSize            = $false
$Description.width               = 450
$Description.height              = 50
$Description.location            = New-Object System.Drawing.Point(20,50)
$Description.Font                = 'Microsoft Sans Serif,10'

$PrinterStatus                   = New-Object system.Windows.Forms.Label
$PrinterStatus.text              = "Status:"
$PrinterStatus.AutoSize          = $true
$PrinterStatus.location          = New-Object System.Drawing.Point(20,115)
$PrinterStatus.Font              = 'Microsoft Sans Serif,10,style=Bold'

$PrinterFound                    = New-Object system.Windows.Forms.Label
$PrinterFound.text               = "Searching for printer..."
$PrinterFound.AutoSize           = $true
$PrinterFound.location           = New-Object System.Drawing.Point(75,115)
$PrinterFound.Font               = 'Microsoft Sans Serif,10'

# ADD OTHER ELEMENTS ABOVE THIS LINE

# Add the elements to the form
$LocalPrinterForm.controls.AddRange(@($Titel,$Description,$PrinterStatus,$PrinterFound))

# THIS SHOULD BE AT THE END OF YOUR SCRIPT FOR NOW
# Display the form
[void]$LocalPrinterForm.ShowDialog()

#elements to prompt for
<#

Domain name
File name/location (prompt, require .cer and autopopulate filename recommended?)
return the domain name, the tenant ID, the filename path (local)
a hyperlink to their azuread admin portal 


#>