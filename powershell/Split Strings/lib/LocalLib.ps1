########################################
#
# File Name:	LocalLib.ps1
# Date Created:	26/07/2024
# Description:	
#	Local Functions for Unit Testing
#
########################################

# File Imports
. "$($PSScriptRoot)\..\..\lib\Common.ps1"
#=======================================

# Global Variables

#=======================================
function Split-String($string)
{
    Write-Log "Splitting '$($string)'"
    $returnArr = @()
	for($i = 0; $i -lt $string.Length; $i += 2)
    {
        Write-Log "Getting char $($i) & $($i+1)"
        $split = $string[$i]
        if(($i+1) -ge $string.Length)
        {
            Write-Log "No Second Char, adding _"
            $split += "_"
        }
        else
        {
            $split += $string[$i+1]
        }

        Write-Log "Adding $($split)"
        $returnArr += @($split)
    }

    return $returnArr
}