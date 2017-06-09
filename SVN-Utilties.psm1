# if the content in a file contains a certain character, rename it with our suffix
function Rename-SvnFileContent {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ValueFromPipeline)]
        [string] $FullName,
        [hashtable] $Characters = @{"å" = "a"; "ä" = "a";"ö" = "o"},
        [string] $Svn = "C:\Program Files\TortoiseSVN\bin\svn.exe",
        [string] $Suffix = "1"
    )

    Process {
        $i = 0
         (Get-Content $FullName) | % {
            $line = $_
            $Characters.Keys | % {
		if ($line -match "$_") { $i = 1 }
                $line -replace $_, $Characters.Item($_) | Set-Content $FullName
            }
	} 
	
	if ($i -eq 1) {
	        Write-Output "$Svn rename $FullName ${FullName}${Suffix}"
        	# & $Svn rename $FullName ${FullName}${Suffix}
	}
    }

}

# If a filename contains a certain character, change it, and run svn rename
function Rename-SvnFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ValueFromPipeline)]
        [string] $Name,
        [hashtable] $Characters = @{"å" = "a"; "ä" = "a";"ö" = "o"},
        [string] $Svn = "C:\Program Files\TortoiseSVN\bin\svn.exe",
        [string] $Suffix = "1"        
    )

    Process {
        foreach ($char in $Characters.Keys) {
            if ($Name -match $char) {
                $newName = $Name -replace $char, $Characters.Item($char)
                Write-Output "$Svn rename $Name $newName"
		# & $Svn rename $Name $newName
            }
        }
    }

}
