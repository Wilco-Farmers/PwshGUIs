class PwshGUI {
    [string]$Title
    [int32]$Width
    [int32]$Height
    [string]$StartPostion
    #Constructor
    PwshGUI ([string]$Title, [int32]$Width, [int32]$Height, [string]$StartPostion) {
        $this.Title = $Title
        $this.Width = $Width
        $this.Height = $Height
        $this.StartPostion = $StartPostion
        Add-Type -AssemblyName System.Windows.Forms
        Add-Type -AssemblyName System.Drawing
    }
}