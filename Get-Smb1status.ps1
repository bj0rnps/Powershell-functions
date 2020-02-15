
#
#
#
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
$smb=Dism /online /Get-Features /format:table |where {$_ -like "*smb1P*"}
                                                            
$smb.foreach{
                                                                          
              $split=($_.split('|')).trim().replace('-','_') #remove whitespace replace char to match class prop
              $obj.($split[0])=$split[1]
              
              }#end foreach smb
              Write-Output $obj                                                            



}
}#end func
