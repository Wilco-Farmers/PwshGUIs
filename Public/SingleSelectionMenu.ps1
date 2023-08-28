<#
.SYNOPSIS
Creates a MultiSelectionMenu with a top text, bottom text, OK and Cancel buttons
.DESCRIPTION
Uses WinForms to create a MultiSelectionMenu with a top text, bottom text, OK and Cancel buttons. Returns the selected items in an array.
.PARAMETER Title
Title of the form displayed on the top of the form
.PARAMETER ItemsInMenu
List of items to be displayed in the menu
.PARAMETER OKButtonText
Text to be displayed on the OK button. This is the button that acts as the "Proceed" "OK" "Accept" "Continue" "Yes" button.
.PARAMETER CancelButtonText
Text to be displayed on the Cancel button. This is the button that acts as the "Cancel" "No" "Exit" "Stop" button.
.PARAMETER TopText
Text to be displayed at the top of the form
.PARAMETER BottomText
Text to be displayed above the OK and Cancel buttons. This takes up 96% of the width of the form. If it needs to be centered, it may have to be padded with whitespace.
.PARAMETER Width
Width of the form. Default is 500. Minimum is 500.
.PARAMETER Height
Height of the form. Default is 500. Minimum is 500.
.EXAMPLE
$SelectedItems = SelectionMenu -Title "My PWSH GUI!" -ItemsInMenu @("Item1", "Item2", "Item3", "Item4", "Item5") -OKButtonText "Yes" -CancelButtonText "No" -TopText "Select from the following Options" -BottomText "Ctrl + Click to select multiple items"
.OUTPUTS
An ArrayList of the selected items. This only occurs if the OK button is pressed. If the Cancel button is pressed, the output is $null.
.NOTES
In the PwshGUI Class, the minimum height and width of the form is 500x500. If the provided Height and Width are less than 500, the form will be set to 500x500.
#>
function SingleSelectionMenu {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Title,
        [Parameter(Mandatory=$true)]
        [string[]]$ItemsInMenu,
        [Parameter(Mandatory=$true)]
        [string]$OKButtonText,
        [Parameter(Mandatory=$true)]
        [string]$CancelButtonText,
        [Parameter(Mandatory=$true)]
        [string]$TopText
    )
    [XML]$Form = Get-Content -Path ($PSScriptRoot + "\..\XAML\SingleSelectionGUI.xml")
    $NodeReader = (New-Object System.Xml.XmlNodeReader $Form)
    $Window = [Windows.Markup.XamlReader]::Load($NodeReader)
    $Window.Title = $Title
    $OKButton = $Window.FindName("SubmitButton")
    $OKButton.Content = $OKButtonText
    $OKButton.Add_Click({ #Action that occurs when button is clicked
        $Window.Close()
    })
    $CancelButton = $Window.FindName("CancelButton")
    $CancelButton.Content = $CancelButtonText
    $CancelButton.Add_Click({
        $Window.Close()
        $CancelButton.IsCancel = $true
    })
    $Window.FindName("TextBlockContent").Text = $TopText
    foreach ($item in $ItemsInMenu) {
        $Window.FindName("ListItems").Items.Add($item) | Out-Null
    }
    $Window.ShowDialog() | Out-Null
    if ($CancelButton.IsCancel) {
        return $null
    }
    else {
        return $Window.FindName("ListItems").SelectedItem
    }
}