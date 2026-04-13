# oh-my-posh init pwsh | Invoke-Expression
# oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\themes\custom.yaml" | Invoke-Expression

# =========================
# PSReadLine configuration
# =========================

Import-Module PSReadLine

Set-PSReadLineOption -EditMode Emacs

# --- History behavior ---
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionSource History

# --- Visuals ---
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -BellStyle None

# --- Smart behavior ---
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -MaximumHistoryCount 10000

# --- Colors (works well with Oh My Posh) ---
Set-PSReadLineOption -Colors @{
    Command            = 'Cyan'
    Parameter          = 'DarkCyan'
    String             = 'DarkYellow'
    Operator           = 'Gray'
    Variable           = 'Green'
    Number             = 'Magenta'
    Type               = 'DarkGray'
    Comment            = 'DarkGreen'
}

# Move by words (camelCase & paths friendly)
Set-PSReadLineKeyHandler -Key 'Ctrl+LeftArrow'  -Function BackwardWord
Set-PSReadLineKeyHandler -Key 'Ctrl+RightArrow' -Function ForwardWord

# Delete whole line safely
Set-PSReadLineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine

# Insert last argument of previous command (like Bash)
Set-PSReadLineKeyHandler -Key 'Alt+.' -Function YankLastArg

# Accept prediction word-by-word
Set-PSReadLineKeyHandler -Key 'Alt+RightArrow' -Function AcceptNextSuggestionWord

# Accept full prediction
# Set-PSReadLineKeyHandler -Key Tab -Function AcceptSuggestion

Import-Module posh-git

oh-my-posh init pwsh --config "$HOME\.config\oh-my-posh\themes\custom.yaml" | Invoke-Expression

# function to recursively list file with a specific extension and count the # of occurences
# i.e. equivalent to ls -R | grep *.png | wc
function count-ext {
    param(
        [Parameter(Mandatory)]
        [string]$ext,

        [string]$path = "."
    )

    (fd -e $ext . $path).Count
}

# function to count the occurences of a string in a file
function count-in-file {
    param(
        [Parameter(Mandatory=$true)]
        [string]$FilePath,

        [Parameter(Mandatory=$true)]
        [string]$SearchString
    )

    if (!(Test-Path $FilePath)) {
        Write-Host "File not found: $FilePath"
        return
    }

    $count = (Select-String -Path $FilePath -Pattern $SearchString -AllMatches |
              ForEach-Object { $_.Matches.Count } |
              Measure-Object -Sum).Sum

    if ($null -eq $count) { $count = 0 }

    Write-Host "Occurrences of '$SearchString' in '$FilePath': $count"
}


