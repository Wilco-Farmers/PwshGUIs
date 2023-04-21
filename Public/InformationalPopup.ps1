function InformationalPopup {
    param (
        [parameter(Mandatory=$true)]
        [string]$Title,
        [parameter(Mandatory=$true)]
        [string]$Message,
        [parameter(Mandatory=$false)]
        [int32]$Width = 325,
        [parameter(Mandatory=$false)]
        [int32]$Height = 200,
        [parameter(Mandatory=$false)]
        [string]$OKButtonText = "OK"

    )
    #Below line loads the XML file defining the GUI, and loads the corresponding variables into the XML
    [XML]$Form = (Get-Content -Path ($PSScriptRoot + "\..\XAML\InformationalGUI.xml")).Replace("`$OKButtonText", $OKButtonText).Replace("`$Title",$Title).Replace("`$Content",$Message).Replace("`$Height",$Height).Replace("`$Width",$Width)
    $NodeReader = (New-Object System.Xml.XmlNodeReader $Form)
    $Window = [Windows.Markup.XamlReader]::Load($NodeReader)
    $Button = $Window.FindName("OkButton")
    $Button.Add_Click({ #Action that occurs when button is clicked
        $Window.Close()
    })
    $Window.ShowDialog() | Out-Null
}