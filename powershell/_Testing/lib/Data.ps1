########################################
#
# File Name:	Data.ps1
# Date Created:	08/02/2024
# Description:	
#	Function library for Data Types
#
########################################

# file imports
. "$($PSScriptRoot)\Logging.ps1"

########################################
# Data Type Checking
########################################
########################################
#
# Name:		Is-Digit
# Input:	$char <String>
# Output:	<Boolean>
# Description:	
#	checks if the supplied character is a digit
#
########################################
Function Is-Digit($char)
{
    if($char.GetType().Name -ne "String")
    {
        return $false
    }
    if($char.Length -gt 1)
    {
        return $false
    }
    return ($char -match "^\d+$")
}

########################################
# Data Convertion
########################################
########################################
#
# Name:		Hash-To-Array
# Input:	$hash <Hash Object>
# Output:	$returnArr <Array>
# Description:	
#	converts a Hash object into an Array of Strings formatted as "key = value"
#
########################################
Function Hash-To-Array($hash)
{
    $returnArr = @()
    foreach($key in ($hash.Keys | Sort-Object))
    {
        $returnArr += @("$($key) = $($hash[$key])")
    }

    return $returnArr
}

########################################
#
# Name:		String-To-Int
# Input:	$str <String>
# Output:	$retunVal <Intenger>
# Description:	
#	Converts String to Integer
#
########################################
function String-To-Int($str)
{
    #Write-Debug "String to convert - $($str)"
    [int64]$retunVal = [convert]::ToInt64($str, 10)
    return $retunVal 
}

########################################
#
# Name:		JsonObj-To-Hash
# Input:	$jsonObj <Object>
# Output:	$returnHash <Hash Object>
# Description:	
#	converts a JSON object into an Hash Object
#
########################################
Function JsonObj-To-Hash($jsonObj)
{
    $returnHash = @{}
    foreach ($property in $jsonObj.PSObject.Properties) 
    {
        $returnHash[$property.Name] = $property.Value
    }
    return $returnHash
}

########################################
#
# Name:		NameValueCollection-To-Array
# Input:	$coll <Object - NameValueCollection>
# Output:	$returnArr <Array>
# Description:	
#	converts a NameValueCollection object into an Array of Strings formatted as "key = value"
#
########################################
Function NameValueCollection-To-Array($coll)
{
    $returnArr = @()

    foreach($key in $coll.Keys)
    {
        # checks if an array and if so loops through all the elements of it
        if($coll.GetValues($key).GetType().BaseType.Name -eq "Array")
        {
            foreach($arrItem in $coll.GetValues($key))
            {
                $returnArr += @("$($key) = $($arrItem)")
            }
        }
    }

    return $returnArr
}

########################################
#
# Name:		String-to-TimeSpan
# Input:	$timeString <String>
# Output:	$timeSpan <Object - Timespan>
# Description:	
#	converts a : seperated string to be a Timespan Object
#
########################################
Function String-to-TimeSpan($timeString)
{
    # splits the string into time components
    $split = $timeString -split ":"

    # checks how many time components we are working with assuming order will always be Days > Hours > Minuites > Seconds
    switch ($split.Count)
    {
        1 {
            $timespan = New-TimeSpan -Seconds ([int]($split[0]))
            Break
        }
        2 {
            $timespan = New-TimeSpan -Minutes ([int]($split[0])) -Seconds ([int]($split[1]))
            Break
        }
        4 {
            $timespan = New-TimeSpan -Days ([int]($split[0])) -Hours ([int]($split[1])) -Minutes ([int]($split[2])) -Seconds ([int]($split[3]))
            Break
        }
        default {
            $timespan = New-TimeSpan -Hours ([int]($split[0])) -Minutes ([int]($split[1])) -Seconds ([int]($split[2]))
            Break
        }
    }

    return $timeSpan
}

########################################
#
# Name:		Timestamp-to-DateTime
# Input:	$unixTimestamp <String>
# Output:	$dateObj <Object - DateTime>
# Description:	
#	Converts a Unix Timestamp into a Date Time Object
#
########################################
function Timestamp-to-DateTime($unixTimestamp)
{
    $dateObj = New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0
    $dateObj = $dateObj.AddSeconds($unixTimestamp)
    return $dateObj 
}