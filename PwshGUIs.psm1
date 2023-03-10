Add-Type -AssemblyName System.Windows.Forms

#import all classes
(Get-ChildItem -Path $($PSScriptRoot + "\Classes")) | ForEach-Object {
    . $_.FullName 
}

(Get-ChildItem -Path $($PSScriptRoot + "\Public")) | ForEach-Object {
    . $_.FullName 
}

#import all private files
(Get-ChildItem -ErrorAction SilentlyContinue -Path $($PSScriptRoot + "\Private")) | ForEach-Object {
    . $_.FullName 
}

