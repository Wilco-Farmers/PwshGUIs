function InputTextMenu {
    param (
        [parameter(Mandatory=$true)]
        [string]$Title,
        [parameter(Mandatory=$true)]
        [string]$LabelPrompt,
        [parameter(Mandatory=$false)]
        [int32]$Width = 525,
        [parameter(Mandatory=$false)]
        [int32]$Height = 300,
        [parameter(Mandatory=$true)]
        [string]$MainContent,
        [parameter(Mandatory=$false)]
        [string]$OKButtonText = "OK",
        [parameter(Mandatory=$false)]
        [string]$CancelButtonText = "Cancel"

    )
    #Below line loads the XML file defining the GUI, and loads the corresponding variables into the XML
    [XML]$Form = (Get-Content -Path ($PSScriptRoot + "\..\XAML\InputTextGUI.xml")).Replace("`$OKButtonText",$OKButtonText).Replace("`$CancelButtonText",$CancelButtonText).Replace("`$Title",$Title).Replace("`$LabelPrompt",$LabelPrompt).Replace("`$Height",$Height).Replace("`$Width",$Width).Replace("`$MainContent",$MainContent)
    $NodeReader = (New-Object System.Xml.XmlNodeReader $Form)
    $Window = [Windows.Markup.XamlReader]::Load($NodeReader)
    $OKButton = $Window.FindName("OkButton")
    $OKButton.Add_Click({ #Action that occurs when button is clicked
        $Window.Close()
    })
    $CancelButton = $Window.FindName("CancelButton")
    $CancelButton.Add_Click({
        $Window.Close()
        $CancelButton.IsCancel = $true
    })
    $Window.ShowDialog() | Out-Null
    if ($CancelButton.IsCancel -eq $true) {
        return
    }
    else {
        $TextBox = $Window.FindName("TextBox")
        return $TextBox.Text
    }
}