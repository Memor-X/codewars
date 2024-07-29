BeforeAll {
    # Dyanmic Link to file to test
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')

    # Variables
    $global:outputBuffer = @{}
    $outputBuffer."screen" = @()

    # Function Mocking
    Mock Add-Content {
        $file = (Out-String -InputObject $PesterBoundParameters.Path).Trim()
        if($outputBuffer.ContainsKey($file) -eq $false)
        {
            $outputBuffer.$file = @()
        }
        $outputBuffer.$file += @($PesterBoundParameters.Value)
    }
    Mock Set-Content {
        $file = (Out-String -InputObject $PesterBoundParameters.Path).Trim()
        $outputBuffer.$file = @($PesterBoundParameters.Value)
    }
    Mock Write-Host {
        $outputBuffer."screen" += @(@{
            "msg" = (Out-String -InputObject $PesterBoundParameters.Object).Trim()
            "color" = (Out-String -InputObject $PesterBoundParameters.ForegroundColor).Trim()
        })
    }
    Mock Get-Date {
        $returnVal = ""
        switch($PesterBoundParameters.UFormat)
        {
            "%m-%d-%Y" {
                $returnVal = "01-01-2000"
                break
            }
            "%R"{
                $returnVal = "11:10"
                break
            }
            "%m/%d/%Y %R"{
                $returnVal = "01/01/2000 11:10"
                break
            }
            default {
                $returnVal = New-Object DateTime 2000, 1, 1, 11, 10, 0
                break
            }
        }
        return $returnVal
    }
}

# Tests
Describe 'Codewars Tests' {
    BeforeEach {
            $global:outputBuffer = @{}
            $outputBuffer."screen" = @()
        }

    Context "Basic Tests" {
        It "Should pass"{
            $expected = @("ab","c_")
            $actual = Split-String("abc")
            Compare-Object $expected $actual| Should -BeNullOrEmpty
        }
        
        It "Should pass"{
            $expected = @("ab", "cd", "ef")
            $actual = Split-String("abcdef")
            Compare-Object $expected $actual | Should -BeNullOrEmpty
        }
    }
    
    Context "Extended Tests" {
        BeforeEach {
            $testOne = Split-String("cdabefg")
            $testTwo = Split-String("abcd")
        }
        
        It "Should not be null"{
            $testOne| Should -Not -BeNullOrEmpty
        }
        
        It "Should return 4 pairs"{
            $testOne.Length | Should -Be 4
        }
        
        It "Should have cd in position 0"{
            $testOne[0] | Should -Be "cd"
        }
        
        It "Should have g_ in position 3"{
            $testOne[3] | Should -Be "g_"
        }
        
        It "Should not be null"{
            $testTwo | Should -Not -BeNullOrEmpty
        }
        
        It "Should return 2 pairs"{
            $testTwo.Length | Should -Be 2
        }
        
        It "Should have cd in position 1"{
            $testTwo[1] | Should -Be "cd"
        }
    }
}
