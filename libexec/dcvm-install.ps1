Param(
    [switch]$Force,
    [switch]$Help,
    [string]$Version
)

$ErrorActionPreference = "Stop"
$SelfDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$DmdDir  = Join-Path $SelfDir "..\dmd"

if((-not $Version) -or $Help)
{
    Write-Host "Usage: dcvm install [-Force] <version>"
    Write-Host ""
    Write-Host "  -force Install even if the version appears to be installed already"
    return 1
}

$Archive = Join-Path $Env:TMP "${version}.zip"
$DestDir = Join-Path $DmdDir $Version

if((Test-Path $DestDir) -and (-not $Force))
{
    Write-Host "$Version is already exists."
    exit 1
}
if((Test-Path $DestDir) -and $Force) { Remove-Item $DestDir }

if($Version -match "^dmd\.([0-9]\.[0-9]{3}(\.[0-9])?)(-.*)?$")
{
    $Ver = $MATCHES[1]
    $Release = if($MATCHES[2] -eq "") { "release" } else { "pre-release" }

    $File = if([Version]$Ver -gt "2.064") { "${Version}.windows.zip" }
            else                          { "${Version}.zip" }

    $Major = [Version]$Ver | % Major
    $Url = "http://downloads.dlang.org/releases/${Major}.x/${Ver}/${File}"
}
else
{
    Write-Host "Unsupported Version ${Version}"
    return 1
}

wget -Uri $Url -OutFile $Archive

if(-not (Test-Path $DmdDir)) { mkdir $DmdDir }

pushd $DmdDir
Expand-Archive $Archive
popd

if($Before)
{
    $Path = Compare $Before $After         |
            ?{ $_.SideIndicator -eq "=>" } |
            % InputObject                  |
            % FullName
}
else
{
    $Path = $After.FullName
}

Remove-Item $Archive
