function Enable-OptionalFeature ($name){

 foreach($entry in $input){
 $feature=$entry.name


Dism /Online /Enable-Feature  /FeatureName:$feature /NoRestart #/quiet
}

}


function Disable-OptionalFeature ([string]$name){
 foreach($entry in $input){
 $feature=$entry.name
 Dism /Online /disable-Feature  /FeatureName:$feature /NoRestart #/quiet
 }
 
 
 }


function Get-OptionalFeature {
$win32_optionalfeature_out=@()
$win32_optionalfeature= Get-WmiObject -query "select * from win32_optionalfeature "|Select-Object name,installstate
$win32_optionalfeature|ForEach-Object{
               $state=$_.installstate
               switch ($state)
                            {
                            1 {$state='Enabled'; Break}
                            2 {$state="Disabled" ; Break }
                            3 {$state="Absent" ; Break }
                            4 {$state="Unknown" ; Break }
                            
                             }#end switch    

$_.installstate=$state
$win32_optionalfeature_out+=$_          
} 
 
$win32_optionalfeature_out|Where-Object {$_.installstate -ne [int]}
 
 
 }                               
