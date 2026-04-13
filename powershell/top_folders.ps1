param(
    [Parameter(Mandatory=$true)]
    [string]$Path,

    [int]$Top = 10
)

# Vérifie que le chemin existe
if (!(Test-Path $Path)) {
    Write-Error "Le chemin spécifié n'existe pas : $Path"
    exit
}

Write-Host "Analyse en cours pour : $Path ..." -ForegroundColor Cyan

# Récupère les dossiers
$folders = Get-ChildItem -Path $Path -Recurse -Directory -ErrorAction SilentlyContinue

$result = foreach ($folder in $folders) {
    $size = (Get-ChildItem -Path $folder.FullName -Recurse -File -ErrorAction SilentlyContinue |
        Measure-Object -Property Length -Sum).Sum

    [PSCustomObject]@{
        Folder = $folder.FullName
        SizeGB = [math]::Round($size / 1GB, 2)
    }
}

# Trie et affiche le top N
$result |
    Sort-Object SizeGB -Descending |
    Select-Object -First $Top |
    Format-Table -AutoSize
