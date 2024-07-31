########################################
#
# File Name:	Multiples.ps1
# Date Created:	31/07/2024
# Description:	
#	
#
########################################

# File Imports
. "$($PSScriptRoot)\lib\LocalLib.ps1"
#=======================================

# Global Varible Setting
$global:logSetting.showDebug = $true

Write-Start

Get-SumOfMultiples(20)

Write-End
