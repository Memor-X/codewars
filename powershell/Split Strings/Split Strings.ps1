########################################
#
# File Name:	Split Strings.ps1
# Date Created:	26/07/2024
# Description:	
#	
#
########################################

# File Imports
. "$($PSScriptRoot)\lib\LocalLib.ps1"
#=======================================

Write-Start

$strings = @(
    "abc",
    "abcdef",
    "asdkjbhasdkjhasdkjhdaskjdas",
    "sd645sda564asd56"
)

for($i = 0; $i -lt $strings.Length; $i++)
{
    $global:logSetting."showLog" = $false
    $splitString = Split-String($strings[$i])
    $outputBlock = Gen-Block "Split of $($strings[$i])" $splitString
    $global:logSetting."showLog" = $true
    Write-Log $outputBlock
}

Write-End
