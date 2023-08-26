$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal $identity
$isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

Function cd... { Set-Location ..\.. }
Function cd! { Set-Location .. }

Function md5 { Get-FileHash -Algorithm MD5 $args }
Function sha1 { Get-FileHash -Algorithm SHA1 $args }
Function sha256 { Get-FileHash -Algorithm SHA256 $args }

Function Get-GitDotfiles {
    & git --git-dir=$HOME\.dotfiles --work-tree=$HOME $args
}

Function Remove-PrunedBranches {
git branch -vv | sls gone `
  |% { $_.ToString().Trim() -split '\s+' | select -first 1 } `
  |% { git branch -D $_ }
}

Import-Module Terminal-Icons

$script_path = Split-Path -Parent $MyInvocation.MyCommand.DeFinition
Write-Host $script_path
Update-TypeData -PrependPath $script_path\my-types.ps1xml
Update-FormatData -PrependPath $script_path\my-format.format.ps1xml

Remove-Alias cat
Remove-Alias type
If (Test-Path alias:vim) {
  Remove-Alias vim
}
If (Test-Path alias:dot) {
  Remove-Alias dot
}
If (Test-Path alias:g) {
  Remove-Alias g
}

New-Alias -Name dot -Value Get-GitDotfiles -Option AllScope
New-Alias -Name g -Value gvim.exe
New-Alias -Name cat -Value bat.exe
New-Alias -Name type -Value bat.exe
oh-my-posh --init --shell pwsh --config $HOME\.oh-my-posh\mytheme.omp.json | Invoke-Expression

#$env:TERM = "xterm-256color"
#$env:BAT_THEME = "gruvbox-light"

$ISETheme = @{
    Command                  = $PSStyle.Foreground.FromRGB(0x0000FF)
    Comment                  = $PSStyle.Foreground.FromRGB(0x006400)
    ContinuationPrompt       = $PSStyle.Foreground.FromRGB(0x0000FF)
    Default                  = $PSStyle.Foreground.FromRGB(0x0000FF)
    Emphasis                 = $PSStyle.Foreground.FromRGB(0x287BF0)
    Error                    = $PSStyle.Foreground.FromRGB(0xE50000)
    InlinePrediction         = $PSStyle.Foreground.FromRGB(0x93A1A1)
    Keyword                  = $PSStyle.Foreground.FromRGB(0x00008b)
    ListPrediction           = $PSStyle.Foreground.FromRGB(0x06DE00)
    Member                   = $PSStyle.Foreground.FromRGB(0x000000)
    Number                   = $PSStyle.Foreground.FromRGB(0x800080)
    Operator                 = $PSStyle.Foreground.FromRGB(0x757575)
    Parameter                = $PSStyle.Foreground.FromRGB(0x000080)
    String                   = $PSStyle.Foreground.FromRGB(0x8b0000)
    Type                     = $PSStyle.Foreground.FromRGB(0x008080)
    Variable                 = $PSStyle.Foreground.FromRGB(0xff4500)
    ListPredictionSelected   = $PSStyle.Background.FromRGB(0x93A1A1)
    Selection                = $PSStyle.Background.FromRGB(0x00BFFF)
}

Set-PSReadLineOption -Colors $ISETheme
