class PwshGUI {
    [string]$Title
    [int32]$Width
    [int32]$Height
    [System.Windows.Forms.Form]$GUI
    [string]$GUIType #YesNo, MultiSelection, SingleSelection    
    #Constructor
    PwshGUI ([string]$Title, [int32]$Width, [int32]$Height, [string]$GUIType) {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        $this.Title = $Title
        $this.Width = $Width
        $this.Height = $Height
        $this.GUI = New-Object System.Windows.Forms.Form
        $this.GUI.Text = $Title
        $this.GUI.Size = New-Object System.Drawing.Size($Width,$Height)
        $this.GUI.StartPosition = 'CenterScreen'
        $this.GUIType = $GUIType
    }

    [System.Object]Display() {
        $result = $this.GUI.ShowDialog()
        if ($result -eq [System.Windows.Forms.DialogResult]::OK)
        {
            switch ($this.GUIType) {
                "YesNo" { 
                    return $true
                }
                "MultiSelection" {
                    $ListBox = $this.GetListBoxResults()
                    return $ListBox.SelectedItems
                }
                "SingleSelection" {
                    $ListBox = $this.GetListBoxResults()
                    return $ListBox.SelectedItem
                }
            }
            return $null
        }
        else {
            if ($this.GUIType -eq "YesNo") {
                return $false
            }
            return $null
        }
    }

    [System.Windows.Forms.Listbox]GetListBoxResults() {
        $x = $this.GUI.Controls
        foreach ($Control in $x) {
            if ($Control.GetType().Name -eq 'ListBox') {
                return $Control
            }
        }
        return $null
    }

    #Bool passed to determine if it is an accept button. If not passed, it will be a cancel button.
    [void]AddButton([string]$Text, [int32]$BtnHeight, [int32]$BtnWidth, [int32]$BtnX, [int32]$BtnY, [bool]$AcceptButton) {
        $Button = New-Object System.Windows.Forms.Button
        $Button.Location = New-Object System.Drawing.Point($BtnX,$BtnY)
        $Button.Size = New-Object System.Drawing.Size($BtnWidth,$BtnHeight)
        $Button.Text = $Text
        if ($AcceptButton) {
            $Button.DialogResult = [System.Windows.Forms.DialogResult]::OK
            $this.GUI.AcceptButton = $Button
        }
        else {
            $Button.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
            $this.GUI.CancelButton = $Button
        }
        $this.GUI.Controls.Add($Button)
    }

    #Adds two buttons to the bottom of the form. One is the accept button, one is the cancel button.
    [void]AddOptionsButtons([string]$TextBtn1, [string]$TextBtn2, [int32]$BtnHeight, [int32]$BtnWidth) {
        $BtnX = (($this.Width - ($BtnWidth * 2))/2) #center of X Axis - width of this button and cancel button
        $BtnY = $this.Height - ($BtnHeight * 3) #Slightly above the bottom of the y axis.
        $this.AddButton($TextBtn1, $BtnHeight, $BtnWidth, $BtnX, $BtnY, $true)
        $CancelBtnCoord = $this.Gui.AcceptButton.Location.X + 70
        $this.AddButton($TextBtn2, $BtnHeight, $BtnWidth, $CancelBtnCoord, $BtnY, $false)
    }

    [void]RemoveOptionsButtons() {
        $this.GUI.Controls.Remove($this.GUI.AcceptButton)
        $this.GUI.Controls.Remove($this.GUI.CancelButton)
    }

    [void]AddTopText([string]$Text) {
        if ($this.GUI.Height -lt 175) {
            $this.GUI.Height = 175
        }
        if ($this.GUI.Width -lt 300) {
            $this.GUI.Width = 300
        }
        $LabelX = ($this.GUI.Width * 0.02) #top right
        $LabelY = ($this.GUI.Height * 0.02) #top right
        $Label = New-Object System.Windows.Forms.Label
        $Label.AutoSize = $true
        $Label.Location = New-Object System.Drawing.Point($LabelX,$LabelY)
        $LabelHeight = $this.GUI.Height * 0.08
        $LabelWidth = $this.GUI.Width * 0.96
        $Label.Size = New-Object System.Drawing.Size($LabelWidth,$LabelHeight)
        $Label.Text = $Text
        $this.GUI.Controls.Add($Label)
    }

    [void]AddTextOverOptionsButtons([string]$Text) {
        if ($this.GUI.Height -lt 100) {
            $this.GUI.Height = 100
        }
        $Label = New-Object System.Windows.Forms.Label
        $LabelHeight = $this.GUI.Height * 0.10
        $LabelWidth = $this.GUI.Width * 0.96
        $LabelX = ($this.GUI.Width * 0.02) #right aligned
        $LabelY = ($this.GUI.AcceptButton.Location.Y - $LabelHeight / 2)#middle
        $Label.Location = New-Object System.Drawing.Point($LabelX,$LabelY)
        $Label.Size = New-Object System.Drawing.Size($LabelWidth,$LabelHeight)
        $Label.Text = $Text
        $this.GUI.Controls.Add($Label)
    }

    [void]AddMultiSelectionList([System.Object]$ItemsToAdd) {
        if ($this.GUI.Height -lt 500) {
            $this.GUI.Height = 500
        }
        if ($this.GUI.Width -lt 500) {
            $this.GUI.Width = 500
        }
        $LBX = ($this.GUI.Width * 0.02) #right aligned
        $LBY = ($this.GUI.Height * 0.10)  
        $ListBox = New-Object System.Windows.Forms.Listbox
        $ListBox.Location = New-Object System.Drawing.Point($LBX,$LBY)
        $LBHeight = $this.GUI.Height * 0.65
        $LBWidth = $this.GUI.Width * 0.92
        $ListBox.Size = New-Object System.Drawing.Size($LBWidth,$LBHeight)
        $ListBox.SelectionMode = 'MultiExtended'
        foreach ($Item in $ItemsToAdd) {
            [void] $ListBox.Items.Add($Item)
        }
        $this.GUI.Controls.Add($ListBox)
        $this.GUI.Topmost = $true
    }
}
