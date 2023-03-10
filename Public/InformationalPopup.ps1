function InformationalPopup {
    param (
        [parameter(Mandatory=$true)]
        [string]$Title,
        [parameter(Mandatory=$true)]
        [string]$Message,
        [parameter(Mandatory=$false)]
        [int32]$Width = 300,
        [parameter(Mandatory=$false)]
        [int32]$Height = 200

    )
    $GUI = [PwshGUI]::new($Title, $Width, $Height, "Informational")
    $GUI.AddButton("OK", 30, 70, $Height - 30 * 2 , $Width / 2 - 70, $true)
    $GUI.AddTopText($Message)
    $Gui.Display() | Out-Null
}
