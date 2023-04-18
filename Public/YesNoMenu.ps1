<#
.SYNOPSIS
A Simple GUI for Yes/No questions
.DESCRIPTION
Uses PwshGUI class to create a Yes/No simple user interface Returns True if Yes is selected, False if No is selected.
.PARAMETER Title
Title of the form displayed on the top of the form
.PARAMETER Text
Text to display above the Yes and No buttons
.PARAMETER Width
This parameter is optional, default value is 300
.PARAMETER Height
This parameter is optional, default value is 175
.PARAMETER YesButtonText
Text to display on the yes button
.PARAMETER NoButtonText
Text to display on the no button
.EXAMPLE
$Proceed = YesNoMenu -Title "My PWSH GUI!" -TopText "Do you want to proceed?" -YesButtonText "Yes" -NoButtonText "No"
.OUTPUTS
Returns True if Yes is selected, False if No is selected
#>
function YesNoMenu {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Title,
        [Parameter(Mandatory=$true)]
        [string]$Text,
        [Parameter(Mandatory=$false)]
        [int32]$Width = 375,
        [Parameter(Mandatory=$false)]
        [int32]$Height = 225,
        [Parameter(Mandatory=$false)]
        [string]$YesButtonText = "Yes",
        [Parameter(Mandatory=$false)]
        [string]$NoButtonText = "No"
    )
    #Below line loads the XML file defining the GUI, and loads the corresponding variables into the XML
    [XML]$Form = (Get-Content -Path ($PSScriptRoot + "\..\XAML\YesNoGUI.xml")).Replace("`$YesButtonText",$YesButtonText).Replace("`$NoButtonText",$NoButtonText).Replace("`$Title",$Title).Replace("`$Height",$Height).Replace("`$Width",$Width).Replace("`$MainContent",$Text)
    $NodeReader = (New-Object System.Xml.XmlNodeReader $Form)
    $Window = [Windows.Markup.XamlReader]::Load($NodeReader)
    $OKButton = $Window.FindName("YesButton")
    $OKButton.Add_Click({ #Action that occurs when button is clicked
        $Window.Close()
    })
    $CancelButton = $Window.FindName("NoButton")
    $CancelButton.Add_Click({
        $Window.Close()
        $CancelButton.IsCancel = $true
    })
    $Window.ShowDialog() | Out-Null
    if ($CancelButton.IsCancel -eq $true) {
        return $false
    }
    else {
        return $true
    }
}