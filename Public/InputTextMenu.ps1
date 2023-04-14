function InputTextMenu {
    param (
        [parameter(Mandatory=$true)]
        [string]$Title,
        [parameter(Mandatory=$true)]
        [string]$Label,
        [parameter(Mandatory=$false)]
        [int32]$Width = 400,
        [parameter(Mandatory=$false)]
        [int32]$Height = 175,
        [parameter(Mandatory=$false)]
        [ValidateSet("BottomCenter", "MidCenter")]
        [string]$Location  = "BottomCenter"

    )
    $GUI = [PwshGUI]::new($Title, $Width, $Height, "InputBox")
    #GB stands for Group Box which is a container for other controls that is set to 95% of the total width and height of the form.
    $GBWidth = $GUI.OuterGroupBox.Width
    $GBHeight = $GUI.OuterGroupBox.Height
    $Xlocation = ($GUI.OuterGroupBox.Location.X + ($GBWidth * 0.05))
    switch ($Location) {
        "BottomCenter" {
            $YLocation = $GBHeight - 60
        }
        "MidCenter" {
            $YLocation = $GBHeight / 2 - 30
        }
    }
    $GUI.AddButton("OK", 30, 70, $GBWidth / 2 - 70, $YLocation + 25, $true)
    $GUI.AddButton("Cancel", 30, 70, $GBWidth / 2, $YLocation + 25, $false)
    $GUI.AddInputBox(30, ($GBWidth - ($GBWidth * 0.15)), $XLocation, $YLocation)
    $GUI.AddTopText($Label)
    return $GUI.Display()
}