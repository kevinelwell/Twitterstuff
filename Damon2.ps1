
$AppNametoRemove = "setacl"

$msi = New-Object -ComObject WindowsInstaller.Installer
#'ApplicationName, ApplicationVersion, ProductCode'| Out-File -FilePath C:\Temp\out.csv
$prodList = foreach ($p in $msi.Products()) {
    
    try {
        $name = $msi.ProductInfo($p, 'ProductName')
        $ver  = $msi.ProductInfo($p, 'VersionString')
        $guid = $p
        #[tuple]::Create($name, $ver, $guid)
        
        #$out = $name +"," + $ver + "," + $guid | Out-File -FilePath C:\Temp\out.csv -Append

    If($name -imatch $AppNametoRemove) {

    write-Host "Found an $AppNametoRemove product with $guid"

    # Run the uninstall routine
    Start-Process "C:\Windows\System32\msiexec.exe" -WindowStyle Hidden –Wait `
    -Verbose –ArgumentList ("/x $guid REBOOT=ReallySuppress /L*v C:\Windows\Logs\$AppNametoRemove.log /qn") ` 
    -ErrorAction SilentlyContinue

    }
    
    
    } catch {

    }

}


