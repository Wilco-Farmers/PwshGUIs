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
        [int32]$Width = 300,
        [Parameter(Mandatory=$false)]
        [int32]$Height = 175,
        [Parameter(Mandatory=$false)]
        [string]$YesButtonText = "Yes",
        [Parameter(Mandatory=$false)]
        [string]$NoButtonText = "No"
    )
    $GUI = [PwshGUI]::new($Title, $Width, $Height, "YesNo")
    $GUI.AddOptionsButtons($YesButtonText, $NoButtonText, 30, 70)
    $GUI.AddTopText($Text)
    return $GUI.Display()
}