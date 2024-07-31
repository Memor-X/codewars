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

    function testing($a1, $a2, $expect) 
    {
        $ans = comp $a1 $a2
        $ans | Should -Be $expect
    }

    function fixed()
    {
        $a1 =  121, 144, 19, 161, 19, 144, 19, 11 
        $a2 =  14641, 20736, 361, 25921, 361, 20736, 361, 121 
        testing $a1 $a2 $true
        $a1 =  121, 144, 19, 161, 19, 144, 19, 11 
        $a2 =  231, 20736, 361, 25921, 361, 20736, 361, 121
        testing $a1 $a2 $false   
        
    }
}

# Tests
Describe 'comp' {
    BeforeEach {
            $global:outputBuffer = @{}
            $outputBuffer."screen" = @()
        }
    
    Context "Codewars Tests" {
        Context "Fixed Tests" {
            It "Should Pass Fixed Tests" {
                fixed
            } 
        }

        It "Attempt Data - Case: <case> should be <expect>" -TestCases @(
            @{
                case = 1;
                a1 = 121, 144, 19, 161, 19, 144, 19, 11;
                a2 = 14641, 20736, 361, 25921, 361, 20736, 361, 121;
                expect = $true;
            }
            @{
                case = 2;
                a1 = 121, 144, 19, 161, 19, 144, 19, 11;
                a2 = 231, 20736, 361, 25921, 361, 20736, 361, 121;
                expect = $false;
            }
            @{
                case = 3;
                a1 = 121, 144, 19, 161, 19, 144, 19, 11;
                a2 = 14641, 20736, 3610, 25921, 361, 20736, 361, 121;
                expect = $false;
            }
            @{
                case = 4;
                a1 = @();
                a2 = @();
                expect = $true;
            }
            @{
                case = 5;
                a1 = 258, 290, 101, 111, 173, 296, 239, 176, 51, 198, 73, 176, 251, 133, 166;
                a2 = 66564, 84100, 10201, 12321, 29929, 87616, 57121, 30976, 2601, 39204, 5329, 30976, 63001, 17689, 27556;
                expect = $true;
            }
            @{
                case = 6;
                a1 = 11, 32, 9, 290, 52, 97, 150, 245, 277, 151, 191, 144, 248, 258, 29, 142, 42, 230;
                a2 = 122, 1024, 81, 84100, 2704, 9409, 22500, 60025, 76729, 22801, 36481, 20736, 61504, 66564, 841, 20164, 1764, 52900;
                expect = $false;
            }
            @{
                case = 7;
                a1 = 138, 39, 22, 45, 28, 235, 272, 127, 84, 58, 132, 213, 166, 63;
                a2 = 19044, 1521, 484, 2026, 784, 55225, 73984, 16129, 7056, 3364, 17424, 45369, 27556, 3969;
                expect = $false;
            }
            @{
                case = 8;
                a1 = 220, 293, 175, 107, 187, 174, 179, 226, 245, 251, 53, 104, 281, 287;
                a2 = 48400, 85849, 30625, 11449, 34969, 30276, 32041, 51076, 60025, 63001, 2809, 10816, 78961, 82369;
                expect = $true;
            }
            @{
                case = 9;
                a1 = 106, 21, 203, 115, 268, 136, 249, 222, 173, 47, 169, 289, 177, 193, 159, 263, 204, 20, 68;
                a2 = 11236, 441, 41209, 13225, 71824, 18496, 62001, 49284, 29929, 2209, 28561, 83521, 31329, 37249, 25281, 69169, 41616, 400, 4624;
                expect = $true;
            }
            @{
                case = 10;
                a1 = 123, 248, 287, 190, 240, 282, 257, 251, 4, 196, 270, 168, 104;
                a2 = 15129, 61504, 82369, 36100, 57600, 79524, 66049, 63001, 16, 38416, 72900, 28224, 10816;
                expect = $true;
            }
            @{
                case = 11;
                a1 = 205, 139, 15, 22, 85, 233, 184, 258, 119;
                a2 = 42025, 19321, 225, 484, 7225, 54289, 33856, 66564, 14161;
                expect = $true;
            }
            @{
                case = 12;
                a1 = 187, 237, 158, 53, 138, 192, 224, 68, 110, 47, 272, 209;
                a2 = 34969, 56169, 24964, 2809, 19044, 36864, 50176, 4624, 12100, 2210, 73984, 43681;
                expect = $false;
            }
            @{
                case = 13;
                a1 = 14, 129, 63, 133, 63, 140, 184, 7, 176, 205, 200, 288, 162, 39, 113, 298, 219, 9, 158;
                a2 = 196, 16641, 3969, 17689, 3969, 19600, 33856, 49, 30976, 42025, 40000, 82944, 26244, 1521, 12769, 88804, 47961, 81, 24964;
                expect = $true;
            }
            @{
                case = 14;
                a1 = 207, 18, 269, 195, 50, 67, 171, 37, 46, 224, 191, 224, 235, 147, 26, 82, 25;
                a2 = 42849, 324, 72361, 38025, 2500, 4489, 29241, 1369, 2116, 50176, 36481, 50176, 55225, 21609, 676, 6724, 625;
                expect = $true;
            }
            @{
                case = 15;
                a1 = 173, 151, 156, 191, 292, 260, 15, 35, 51, 192, 297;
                a2 = 29929, 22801, 24336, 36481, 85264, 67600, 226, 1225, 2601, 36864, 88209;
                expect = $false;
            }
            @{
                case = 16;
                a1 = 196, 114, 281, 163, 10, 41, 104, 111, 295, 16;
                a2 = 38416, 12996, 78961, 26569, 100, 1681, 10817, 12321, 87025, 256;
                expect = $false;
            }
            @{
                case = 17;
                a1 = 70, 263, 188, 21, 101, 79, 45, 102, 14, 288, 134, 34;
                a2 = 4900, 69169, 35344, 441, 10201, 6241, 2025, 10404, 196, 82944, 17956, 1156;
                expect = $true;
            }
            @{
                case = 18;
                a1 = 63, 258, 231, 83, 214, 168, 114, 94, 284, 194, 12, 190, 264, 108, 146, 115;
                a2 = 3969, 66564, 53361, 6889, 45796, 28224, 12996, 8836, 80656, 37636, 144, 36100, 69696, 11664, 21316, 13225;
                expect = $true;
            }
            @{
                case = 19;
                a1 = 240, 261, 150, 12, 68, 140, 81, 149, 149, 116, 64, 241;
                a2 = 57600, 68121, 22500, 144, 4624, 19600, 6561, 22201, 22201, 13456, 4096, 58081;
                expect = $true;
            }
            @{
                case = 20;
                a1 = 141, 226, 293, 134, 144, 101, 123, 150;
                a2 = 19881, 51076, 85849, 17956, 20736, 10201, 15129, 22500;
                expect = $true;
            }
            @{
                case = 21;
                a1 = 45, 226, 82, 178, 23, 204, 106, 72, 100;
                a2 = 2025, 51076, 6724, 31684, 529, 41616, 11236, 5184, 10000;
                expect = $true;
            }
            @{
                case = 22;
                a1 = 4, 63, 273, 138, 136, 208, 165, 244, 166, 256, 39, 61, 107, 132, 135, 32;
                a2 = 16, 3969, 74529, 19044, 18496, 43264, 27225, 59536, 27556, 65536, 1521, 3721, 11449, 17424, 18225, 1024;
                expect = $true;
            }
            @{
                case = 23;
                a1 = 110, 88, 55, 126, 17, 60, 93, 291, 284, 39;
                a2 = 12100, 7744, 3025, 15876, 289, 3600, 8650, 84681, 80656, 1521;
                expect = $false;
            }
            @{
                case = 24;
                a1 = 246, 51, 159, 178, 63, 140, 10, 87, 245, 61, 293, 186, 249, 93;
                a2 = 60516, 2601, 25281, 31684, 3969, 19600, 100, 7569, 60025, 3721, 85849, 34596, 62001, 8649;
                expect = $true;
            }
        ){
            $compare = comp $a1 $a2
            $compare | Should -Be $expect
        }
    }

    Context "Hash Input" {
        It "Should return true with matched data if first argument is a Hash Object" {
            $arg1 = @{
                1 = 121 
                2 = 144
                3 = 19
                4 = 161
                7 = 19
                8 = 144
                6 = 19
                10 = 11}
            $arg2 = @(14641, 20736, 361, 25921, 361, 20736, 361, 121)
            $compare = comp $arg1 $arg2
            $compare | Should -Be $true
        }
        It "Should return true with matched data if second argument is a Hash Object" {
            $arg1 = @(121, 144, 19, 161, 19, 144, 19, 11)
            $arg2 = @{
                1 = 14641
                3 = 20736
                9 = 361
                4 = 25921
                5 = 361
                6 = 20736
                7 = 361
                8 = 121}
            $compare = comp $arg1 $arg2
            $compare | Should -Be $true
        }

        It "Should return true with matched data if both arguments are Hash Object" {
            $arg1 = @{
                1 = 121 
                2 = 144
                3 = 19
                4 = 161
                7 = 19
                8 = 144
                6 = 19
                10 = 11}
            $arg2 = @{
                1 = 14641
                3 = 20736
                9 = 361
                4 = 25921
                5 = 361
                6 = 20736
                7 = 361
                8 = 121}
            $compare = comp $arg1 $arg2
            $compare | Should -Be $true
        }
        It "Should return false with mismatched data if both arguments are Hash Object" {
            $arg1 = @{
                1 = 121 
                2 = 144
                3 = 19
                4 = 161
                7 = 19
                8 = 144
                6 = 19
                10 = 11}
            $arg2 = @{
                1 = 14641
                3 = 20736
                9 = 361
                4 = 25921
                5 = 361
                6 = 20736
                7 = 361
                8 = 9999999999999999999999999999999999}
            $compare = comp $arg1 $arg2
            $compare | Should -Be $false
        }
    }

    Context "Empty Arguments" {
        Context "Arrays" {
            It "Should return false with empty array as first argument" {
                $arg1 = @()
                $arg2 = @(14641, 20736, 361, 25921, 361, 20736, 361, 121)
                $compare = comp $arg1 $arg2
                $compare | Should -Be $false
            }
            It "Should return false with empty array as second argument" {
                $arg1 = @(121, 144, 19, 161, 19, 144, 19, 11)
                $arg2 = @()
                $compare = comp $arg1 $arg2
                $compare | Should -Be $false
            }
            It "Should return true with empty array as both arguments" {
                $arg1 = @()
                $arg2 = @()
                $compare = comp $arg1 $arg2
                $compare | Should -Be $true
            }
        }
        Context "Hash" {
            It "Should return false with empty hash as first argument" {
                $arg1 = @{}
                $arg2 = @{
                    1 = 14641
                    3 = 20736
                    9 = 361
                    4 = 25921
                    5 = 361
                    6 = 20736
                    7 = 361
                    8 = 121}
                $compare = comp $arg1 $arg2
                $compare | Should -Be $false
            }
            It "Should return false with empty hash as second argument" {
                $arg1 = @{
                    1 = 121 
                    2 = 144
                    3 = 19
                    4 = 161
                    7 = 19
                    8 = 144
                    6 = 19
                    10 = 11}
                $arg2 = @{}
                $compare = comp $arg1 $arg2
                $compare | Should -Be $false
            }
            It "Should return true with empty hash as both arguments" {
                $arg1 = @{}
                $arg2 = @{}
                $compare = comp $arg1 $arg2
                $compare | Should -Be $true
            }
        }
        Context "Null" {
            It "Should return false with null as first argument" {
                $arg1 = $null
                $arg2 = @(14641, 20736, 361, 25921, 361, 20736, 361, 121)
                $compare = comp $arg1 $arg2
                $compare | Should -Be $false
            }
            It "Should return false null as second argument" {
                $arg1 = @(121, 144, 19, 161, 19, 144, 19, 11)
                $arg2 = $null
                $compare = comp $arg1 $arg2
                $compare | Should -Be $false
            }
        }
    }

    Context "Different Sizes" {
        It "Should return false arguments are not the same size arrays" {
            $arg1 = @(121, 144, 19, 161, 19, 144, 19, 11, 1)
            $arg2 = @(14641, 20736, 361, 25921, 361, 20736, 361, 121)
            $compare = comp $arg1 $arg2
            $compare | Should -Be $false
        }
        It "Should return false arguments are not the same size hashes" {
            $arg1 = @{
                1 = 121 
                2 = 144
                3 = 19
                4 = 161
                7 = 19
                8 = 144
                6 = 19
                10 = 11
                999 = 1}
            $arg2 = @{
                1 = 14641
                3 = 20736
                9 = 361
                4 = 25921
                5 = 361
                6 = 20736
                7 = 361
                8 = 121}
            $compare = comp $arg1 $arg2
            $compare | Should -Be $false
        }
    }

    It "Should return false when argument 1 macthes more than there are intsances of itself" {
        $arg1 = @(2, 2, 3)
        $arg2 = @(4, 9, 9)
        $compare = comp $arg1 $arg2
        $compare | Should -Be $false
    }
}
