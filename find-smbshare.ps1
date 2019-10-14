function find-smbshare { 
                    
                            param ([string]$server )

begin {
        Add-Type -Language CSharp @"
        public class smbshare{
        public string name;
        public string type;
        public string host;
        public string path;
}
"@



        $ct=Test-Connection  -Count 1 -Quiet  -computername $server
        
               
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
              $smb_ob=New-Object -TypeName smbshare 
              $smb_ob.host= $server
              $smb_ob.name=$sharename
              $smb_ob.path=('\\'+$server+'\'+$sharename)
              $smb_ob.type=$sharetype
              Write-Output $smb_ob
             }
                

                    }


}#end process

}#end func
