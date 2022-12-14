$msi = New-Object -ComObject WindowsInstaller.Installer
'ApplicationName, ApplicationVersion, ProductCode'| Out-File -FilePath C:\Temp\out.csv
$prodList = foreach ($p in $msi.Products()) {
    try {
        $name = $msi.ProductInfo($p, 'ProductName')
        $ver  = $msi.ProductInfo($p, 'VersionString')
        $guid = $p
        #[tuple]::Create($name, $ver, $guid)
        
        $out = $name +"," + $ver + "," + $guid | Out-File -FilePath C:\Temp\out.csv -Append
    } catch {}
}


notepad C:\Temp\out.csv
