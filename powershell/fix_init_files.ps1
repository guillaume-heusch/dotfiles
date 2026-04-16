Get-ChildItem -Path "src" -Recurse -Directory | ForEach-Object {
    $pyFiles = Get-ChildItem -Path $_.FullName -Filter "*.py"
    $initFile = Join-Path $_.FullName "__init__.py"
    
    if ($pyFiles.Count -gt 0 -and -not (Test-Path $initFile)) {
        Write-Host "Creating $initFile"
        "'''Init file for $($_.Name) package.'''" | Out-File -FilePath $initFile -Encoding utf8
    }
}
