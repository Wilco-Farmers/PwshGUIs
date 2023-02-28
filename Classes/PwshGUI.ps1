class PwshGUI {
    [string]$Title
    [int32]$Width
    [int32]$Height
    [System.Windows.Forms.Form]$GUI
    #Constructor
    PwshGUI ([string]$Title, [int32]$Width, [int32]$Height) {
        $this.Title = $Title
        $this.Width = $Width
        $this.Height = $Height
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        $this.GUI = New-Object System.Windows.Forms.Form
        $this.GUI.Text = $Title
        $this.GUI.Size = New-Object System.Drawing.Size($Width,$Height)
        $this.GUI.StartPosition = 'CenterScreen'
    }

    [void]Display() {
        $this.GUI.ShowDialog()
    }

    #Bool passed to determine if it is an accept button. If not passed, it will be a cancel button.
    [void]AddAcceptButton([string]$Text, [int32]$BtnHeight, [int32]$BtnWidth, [int32]$XCoord, [int32]$YCoord, [bool]$AcceptButton) {
        $BtnX = (($this.Width - ($BtnWidth * 2))/2) #center of X Axis - width of this button and cancel button
        $BtnY = $this.Height - ($BtnHeight * 3) #Slightly above the bottom of the y axis.
        $Button = New-Object System.Windows.Forms.Button
        $Button.Location = New-Object System.Drawing.Point($BtnX,$BtnY)
        $Button.Size = New-Object System.Drawing.Size($BtnWidth,$BtnHeight)
        $Button.Text = $Text
        if ($AcceptButton) {
            $this.GUI.AcceptButton = $Button
        }
        else {
            $this.GUI.CancelButton = $Button
        }
        $this.GUI.Controls.Add($Button)
    } 
}