########################################
#
# File Name:	LocalLib.ps1
# Date Created:	31/07/2024
# Description:	
#	Local Functions for Unit Testing
#
########################################

# File Imports
. "$($PSScriptRoot)\..\..\lib\Common.ps1"
#=======================================

# Global Variables

#=======================================

function Get-SumOfMultiples($Value)
{
    $total = 0
	for($i = 1; $i -lt ($Value); $i++)
    {
        Write-Debug "$($i) Mod 3 = $($i % 3)"
        Write-Debug "$($i) Mod 5 = $($i % 5)"
        if(($i % 3) -eq 0 -or ($i % 5) -eq 0)
        {
            Write-Log "Adding $($i)"
            $total += $i
        }
    }
    return $total
}
