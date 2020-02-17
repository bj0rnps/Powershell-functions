<#

installstate posible values:
Enabled (1)


Disabled (2)


Absent (3)


Unknown (4)
#>
function Get-Smb1status{


begin{
Add-Type -Language CSharp @"
public class smb_1{
public string SMB1Protocol ;
public string SMB1Protocol_Client;
public string SMB1Protocol_Server;
public string SMB1Protocol_Deprecation;
                  }
"@
}



process{


$obj=New-Object -TypeName smb_1
$smb=Get-WmiObject -query "select * from win32_optionalfeature where name like '%smb1%' "|select name,installstate


$smb.foreach{
                                                                          
           
               $name=($_.name).replace('-','_').trim() 
               $state=$_.installstate
               
               switch ($state)
                            {
                            1 {$state='Enabled'; Break}
                            2 {$state="Disabled" ; Break }
                            3 {$state="Absent" ; Break }
                            4 {$state="Unknown" ; Break }
                            
                             }#end switch    
          
                 $obj.$name=$state
                 
              }#end foreach smb
              Write-Output $obj                                                            



}
}#end func
