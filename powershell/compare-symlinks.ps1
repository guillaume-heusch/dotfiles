# Define your directories
#$dirA = "C:\Users\Guillaume\Documents\work\deepfake-detection\my-laa-net\test_datasets\train\aligned_faces"
#$dirB = "C:\Users\Guillaume\Documents\work\deepfake-detection\my-laa-net\test_datasets_copy\train\aligned_faces"
$dirA = "C:\Users\Guillaume\Documents\work\deepfake-detection\my-laa-net\experiment_data\test"
$dirB = "C:\Users\Guillaume\Documents\work\deepfake-detection\my-laa-net\experiment_data_2\test"

# Function to get symlink targets as a sorted list
function Get-SymlinkMap($path) {
    Get-ChildItem -Path $path -Recurse -Force | 
        Where-Object { $_.LinkType -eq "SymbolicLink" } | 
        Select-Object -Property Name, @{Name="Target"; Expression={$_.Target}} |
        Sort-Object Target
}

$linksA = Get-SymlinkMap $dirA
$linksB = Get-SymlinkMap $dirB

# Compare the 'Target' property of both lists
$comparison = Compare-Object -ReferenceObject $linksA.Target -DifferenceObject $linksB.Target

if ($null -eq $comparison) {
    Write-Host "✅ Success: Both directories contain links to the exact same files." -ForegroundColor Green
} else {
    Write-Host "❌ Mismatch found:" -ForegroundColor Red
    $comparison | ForEach-Object {
        $side = if ($_.SideIndicator -eq "<=") { "Only in $dirA" } else { "Only in $dirB" }
        Write-Host "$($side): $($_.InputObject)"
    }
}
