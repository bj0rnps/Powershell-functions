
function show-wlaninterface { 
                    
                            

begin {
       
        $index_start=3
        $wlaninterface_obj=New-Object -TypeName psobject 
       }

process{

        $wlaninterface=netsh wlan show interfaces
        $index_end=$wlaninterface.count
        $wlaninerface_filtered=$wlaninterface[3..$index_end]
        $wlaninerface_filtered=$wlaninerface_filtered|where {$_ -ne ''}
        $wlaninerface_filtered=$wlaninerface_filtered -replace '\s:\s','+ '
        $wlaninerface_filtered|%{if ($_ -eq $null) {continue}
                                 $split=$_.split('+')
                                 $wlaninterface_obj| Add-Member -Value ($split[1]).trim() -Name ($split[0]).Trim() -MemberType NoteProperty -Force
                                }
       }

end{
Write-Output $wlaninterface_obj
     }
                        
                        
 } 
