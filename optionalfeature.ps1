function Enable-Optionalfeature {

Get-WmiObject -query "select * from win32_optionalfeature "|select name,installstate|Out-GridView -OutputMode Multiple |%{
$fname=$_.name
Dism /Online /Enable-Feature /FeatureName:$fname

}
}


function Disable-Optionalfeature {
Get-WmiObject -query "select * from win32_optionalfeature "|select name,installstate|Out-GridView -OutputMode Multiple |%{
 $fname=$_.name
 Dism /Online /disable-Feature /FeatureName:$fname

 }             
 
 }                                         
