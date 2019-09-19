function find-smbshare { 
                    
                            param ([string]$server )

begin {$ct=Test-Connection  -Count 1 -Quiet  -computername $server
        
               
            }#end begin
process{if (!$ct) {Write-Error ('computer unavalible: '+$server)
                    }
        if($ct){
        $smb=net.exe view $server
        $mat=$smb -match "\s{3,}"#filter out junk
        $re=$mat -replace "\s+",";"#ready for split
        
        $re|%{$split=$_.split(';') #split and make obj if server is available
              $sharename=$split[0]
              $sharetype=$split[1]
              $smb_ob=New-Object -TypeName psobject 
              $smb_ob|Add-Member -MemberType NoteProperty -Name 'name' -Value $sharename -PassThru|
              Add-Member -MemberType NoteProperty -Name 'type' -Value $sharetype -PassThru | 
              Add-Member -MemberType NoteProperty -Name 'host' -Value $server -PassThru|
              Add-Member -MemberType NoteProperty -Name 'path' -Value ('\\'+$server+'\'+$sharename)
              Write-Output $smb_ob
             }
                

                    }


}#end process

}#end func
