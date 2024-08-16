########################################
#
# File Name:	Tests.ps1
# Date Created:	13/08/2024
# Description:	
#	Test Runner for pytest Python Unit Tests
#
########################################

# File Arguments
param (
    $suite="*"
)

function Write-Test-Log($str)
{
    Write-Host "$($str)" -Foregroundcolor Magenta
}

Write-Test-Log "Setting Up Pyunit"

#------------------------------------------------------------------

$coveragePercentTarget = 90

#------------------------------------------------------------------

Write-Test-Log "Compiling Suite"
$fullSuiteVals = @(
    "*",
    "all",
    "full"
)
$testSuite = @()
$codeCoverageSuite = @()

if($fullSuiteVals.Contains($suite) -eq $true)
{
    Write-Test-Log "Collecting all Tests for Suite"
    $files = Get-ChildItem -Path ".." -Filter "*Tests.py" -Recurse
    foreach($file in $files)
    {
        Write-Test-Log "`tAdding Test - $($file.FullName)"
        $testSuite += @($file.FullName)
        $codeCoverageSuite += @($file.FullName.Replace("Tests",""))
    }
}
else
{
    Write-Test-Log "Splitting string for Suite"
    $testSplit = $suite.split("<|>")
    foreach($file in $testSplit)
    {
        if((Test-Path $file -PathType Leaf) -eq $true)
        {
            Write-Test-Log "Adding Single File - $($file)"
            $testSuite += @($file)
            $codeCoverageSuite += @($file.Replace("Tests",""))
        }
        elseif((Test-Path $file -PathType Container) -eq $true)
        {
            Write-Test-Log "Adding Folder - $($file)"
            $files = Get-ChildItem -Path $file -Filter "*Tests.ps1" -Recurse
            foreach($subfile in $files)
            {
                Write-Test-Log "`tAdding Test from folder Folder - $($subfile.FullName)"
                $testSuite += @($subfile.FullName)
                $directoryPath = Split-Path -Path $testSuite
                $codeCoverageSuite += @($directoryPath)
            }
        }
        else
        {
            Write-Test-Log "Can not find test file $($file)"
        }
    }
}


Write-Test-Log ""

$cmd = "pytest --cov-config=coveragerc.ini --cov-report=xml --cov -v -r a --junit-xml=`"results\testResults.xml`""
$cov = " --cov=cov-start.py"
for($i = 0; $i -lt $testSuite.Length; $i++)
{
    $cmd += " $($testSuite[$i])"
    $cov += " --cov=$($codeCoverageSuite[$i])"
}
$cmd += " --cov=cov-end.py"
#$cmd += $cov

Write-Test-Log "Command = $($cmd)"
Invoke-Expression -Command "& $($cmd)"