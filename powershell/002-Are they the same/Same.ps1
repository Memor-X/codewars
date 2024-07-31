########################################
#
# File Name:	Same.ps1
# Date Created:	29/07/2024
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

$scenarios = @{
    "basic" = @{
        "a1" = @(121, 144, 19, 161, 19, 144, 19, 11 )
        "a2" = @(14641, 20736, 361, 25921, 361, 20736, 361, 121 )
    }

    "2ndHash" = @{
        "a1" = @(121, 144, 19, 161, 19, 144, 19, 11 )
        "a2" = @{
            1 = 14641
            3 = 20736
            9 = 361
            4 = 25921
            5 = 361
            6 = 20736
            7 = 361
            8 = 121}
    }

    "2Hashes" = @{
        "a1" = @{
            1 = 121 
            2 = 144
            3 = 19
            4 = 161
            7 = 19
            8 = 144
            6 = 19
            10 = 11}
        "a2" = @{
            1 = 14641
            3 = 20736
            9 = 361
            4 = 25921
            5 = 361
            6 = 20736
            7 = 361
            8 = 121}
    }

    "Codewars Fixed Case 4" = @{
        "a1" = @()
        "a2" = @()
    }
}
$scenario = "Codewars Fixed Case 4"

$compare = comp $scenarios."$($scenario)"."a1" $scenarios."$($scenario)"."a2"

Write-Log $compare

Write-End
