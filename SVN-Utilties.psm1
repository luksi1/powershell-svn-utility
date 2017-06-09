function Rename-SvnFileContent {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ValueFromPipeline)]
        [string] $Name,
        [hashtable] $Characters = @{"å" = "a"; "ä" = "a";"ö" = "o"},
        [string] $Repo = "http://foo/svn/testrepo",
        [string] $Svn = "C:\Program Files\TortoiseSVN\bin\svn.exe",
        [string] $Suffix = "1"
    )

    Process {
        $content = Get-Content $Name
        $content | ForEach-Object {
            $line = $_
            $Characters.Keys | ForEach-Object {
                $line -replace $Characters.Item($_)
            }
            Set-Content $FileName
        }
        Write-Output "$Svn rename $Name ${Name}${Suffix}"
        # & $Svn rename $Name ${Name}${Suffix}
    }

}

function Rename-SvnFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ValueFromPipeline)]
        [string] $Name,
        [hashtable] $Characters = @{"å" = "a"; "ä" = "a";"ö" = "o"},
        [string] $Repo = "http://foo/svn/testrepo",
        [string] $Svn = "C:\Program Files\TortoiseSVN\bin\svn.exe",
        [string] $Suffix = "1"
        
    )

    Process {
        $encoding = [system.Text.Encoding]::UTF8
        $originalName = $Name
        foreach ($char in $Characters.Keys) {
            Write-Output $encoding.GetBytes($Name)
            Write-Output "å"
            Write-Output $char
            Write-Output $Characters.Item($char)
            if ($Name -match $char) {
                Write-Output $char
                $Name -replace $Characters.Item($char)
                Write-Output "svn rename $OriginalName $Name"
            }
        }
    }

}



