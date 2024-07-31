########################################
#
# File Name:	LocalLib.ps1
# Date Created:	29/07/2024
# Description:	
#	Local Functions for Unit Testing
#
########################################

# File Imports
. "$($PSScriptRoot)\..\..\lib\Common.ps1"
#=======================================

# Global Variables

#=======================================

function comp($a1, $a2)
{
    if($null -eq $a1 -or $null -eq $a2)
    {
        Write-Warning "Null value passed, exiting"
        return $false
    }

    Write-Log "Checking for Hash"
    Write-Debug "a1 Type = $(($a1.GetType()).Name)"
    Write-Debug "a2 Type = $(($a2.GetType()).Name)"
    if(($a1.GetType()).Name -eq "Hashtable")
    {
        $a1 = @($a1.Values)
    }
    if(($a2.GetType()).Name -eq "Hashtable")
    {
        $a2 = @($a2.Values)
    }

    Write-Debug "a1 count = $($a1.Count)"
    Write-Debug "a2 count = $($a2.Count)"
    if($a1.Count -eq 0 -and $a2.Count -eq 0)
    {
        Write-Warning "both arguments are sizes 0, exiting with true"
        return $true
    }
    elseif($a1.Count -ne $a2.Count)
    {
        Write-Warning "Size Mismatch, exiting"
        return $false
    }

    $calcArray = $a1 | ForEach-Object {[int][Math]::Pow($_, 2)}
    $matched = $false
    if($a1.Count -gt 0 -and $a2.Count -gt 0)
    {
        for($i = 0; $i -lt $a2.Count; $i++)
        {
            Write-Log "$($calcArray) contains $($a2[$i]) = $($calcArray.Contains($a2[$i]))"
            Write-Debug "$($calcArray[0].GetType()) = $($a2[$i].GetType())"
            if($calcArray.Contains($a2[$i]) -eq $false)
            {
                $matched = $false
                break
            }
            else
            {
                $calcArray[$calcArray.IndexOf($a2[$i])] = ""
                $matched = $true
            }
        }
    }

    return $matched
}