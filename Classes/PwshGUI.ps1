class PwshGUI {
    [string]$Title
    [int32]$Width
    [int32]$Height
    $GUI
    #Constructor
    PwshGUI ([string]$Title, [int32]$Width, [int32]$Height) {
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
        $this.Title = $Title
        $this.Width = $Width
        $this.Height = $Height
        $this.GUI = New-Object System.Windows.Forms.Form
        $this.GUI.Text = $Title
        $this.GUI.Size = New-Object System.Drawing.Size($Width,$Height)
        $this.GUI.StartPosition = 'CenterScreen'
    }

    [void]Display() {
        $this.GUI.ShowDialog()
    }

    #Bool passed to determine if it is an accept button. If not passed, it will be a cancel button.
    [void]AddButton([string]$Text, [int32]$BtnHeight, [int32]$BtnWidth, [int32]$BtnX, [int32]$BtnY, [bool]$AcceptButton) {
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

    #Creates a List and centers it above the buttons.
    [void]AddListBox([string]$Text) {
        # $ListBox = New-Object System.Windows.Forms.Listbox
        # $ListBox.Location = New-Object System.Drawing.Point(10,40)
        # $ListBox.Size = New-Object System.Drawing.Size(260,20)
        
        # $listBox.SelectionMode = 'MultiExtended'
        
        # [void] $listBox.Items.Add('Item 1')
        # [void] $listBox.Items.Add('Item 2')
        # [void] $listBox.Items.Add('Item 3')
        # [void] $listBox.Items.Add('Item 4')
        # [void] $listBox.Items.Add('Item 5')
        
        # $listBox.Height = 70
        # $this.GUI.Controls.Add($listBox)
        # $this.GUI.Topmost = $true

        # $ListBox = New-Object System.Windows.Forms.ListBox
        # $ListBox.Location = New-Object System.Drawing.Point($ListX,$ListY)
        # $ListBox.Size = New-Object System.Drawing.Size($ListWidth,$ListHeight)
        # $ListBox.Text = $Text
        # $this.GUI.Controls.Add($ListBox)
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
        $Label.Location = New-Object System.Drawing.Point($LabelX,$LabelY)
        $LabelHeight = $this.GUI.Height * 0.10
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
        $LabelY = ($this.GUI.AcceptButton.Location.Y - $LabelHeight)#middle
        $Label.Location = New-Object System.Drawing.Point($LabelX,$LabelY)
        $Label.Size = New-Object System.Drawing.Size($LabelWidth,$LabelHeight)
        $Label.Text = $Text
        $this.GUI.Controls.Add($Label)
    }

    [void]AddMultiSelectionList([System.Object]$ItemsToAdd, $Label) {
        # $this.AddListBox($Label)

        # $listBox.SelectionMode = 'MultiExtended'

        # [void] $listBox.Items.Add('Item 1')
        # [void] $listBox.Items.Add('Item 2')
        # [void] $listBox.Items.Add('Item 3')
        # [void] $listBox.Items.Add('Item 4')
        # [void] $listBox.Items.Add('Item 5')

        # $listBox.Height = 70
        # $this.GUI.form.Controls.Add($listBox)
        # $this.GUI.form.Topmost = $true
    }

    [void]Show() {
        $this.GUI.ShowDialog()
    }
}


$GUI = [PwshGUI]::new("Test", 300,200)
$GUI.AddOptionsButtons("Accept", "Cancel", 30, 70)
$GUI.AddTextOverOptionsButtons("              Ctrl + Click to select multiple items.")
$GUI.AddTopText("Select from the list of available user changes:")
$GUI.Show()
