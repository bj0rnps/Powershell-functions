function Get-OfficeAddin(){
Add-Type -Language CSharp @"
public class office_addin{
public string Name ;
public string office_app;
public string load_behavior;
public string last_loadstate;
public bool disabled_addinlist;
public string office_version;
public bool donot_disable;
public string FriendlyName;


                  }
"@




$office_programs='Outlook','PowerPoint','Excel','Word'
$addin_col=@()
#function Get-OfficeAddin{

$office_programs|ForEach-Object{
$program=$_


$addins=Get-ChildItem ('HKCU:\SOFTWARE\Microsoft\office\'+$program+'\Addins')

$addins|ForEach-Object {

$addin_obj=New-Object -TypeName office_addin

$addin=$_.Name.replace('HKEY_CURRENT_USER','HKCU:')|%{(Get-ItemProperty $_)}
$addin|ForEach-Object{ 

#load behavior
$loadbehavior=$_.loadbehavior
 switch($loadbehavior)
{
   0 {$loadbehavior='Do not load automatically'           ; $lastloadstate='unloaded'  } #0 ;unloaded ;Do not load automatically
                                                                                       
   1 {$loadbehavior='Do not load automatically'           ; $lastloadstate='Loaded'    }#1  ;	Loaded;	Do not load automatically
                                                                                     
   2 {$loadbehavior='Load at startup'                     ;$lastloadstate='Unloaded'   }#2  ;	Unloaded ;	Load at startup
                                                                                     
   3 {$loadbehavior='Load at startup'                     ;$lastloadstate='Loaded'     }#3  ;	Loaded	;Load at startup
                                                                                     
   8 {$loadbehavior='Load on demand'                      ; $lastloadstate='Unloaded'  }#8  ;	Unloaded ;	Load on demand
                                                                                     
   9 {$loadbehavior='Load on demand'                      ;$lastloadstate='Loaded'     }#9  ;	Loaded ;	Load on demand
                                                                                     
   16{$loadbehavior='Load first time, then load on demand'; $lastloadstate='Loaded'    } #16 ;	Loaded ;	Load first time, then load on demand


}#remove foreach


#$DoNotDisableAddinListPath="hkcu:\SOFTWARE\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList" to be added

if  ( (Get-ItemProperty "hkcu:\SOFTWARE\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList").($addin.PSChildName)) { 
                                                                                                                                $donotdisable=$true
                                                                                                                                  }
if  ( !((Get-ItemProperty "hkcu:\SOFTWARE\Microsoft\Office\16.0\Outlook\Resiliency\DoNotDisableAddinList").($addin.PSChildName))) {$donotdisable=$false}  





$addin_obj.load_behavior=$loadbehavior
$addin_obj.office_app=$program
$addin_obj.Name=$addin.PSChildName
$addin_obj.last_loadstate=$lastloadstate
$addin_obj.FriendlyName=$addin.FriendlyName
$addin_obj.donot_disable=$donotdisable
$addin_col+=$addin_obj


}
}

Write-Output $addin_col
}
}
