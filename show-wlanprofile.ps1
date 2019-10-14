

 
function show-wlanprofile { 
                    
                           # param ([string]$server )

begin {
        $ErrorActionPreference='silentlycontinue'
        $profiles=@()
               
            }#end begin
process{

        $wlanprofiles=netsh wlan show profiles key=clear
        $index_count=$wlanprofiles.count-2
        $wlanprofiles_filterd=$wlanprofiles[9..$index_count]
        $wlanprofiles_filterd|foreach {$key='N/A'
                                       $split=$_.split(':')
                                       $user_profiles=$split[0]
                                       $profile_name=$split[1]
                        
                                       $profile_info=netsh wlan show profile ($profile_name.Trim())  key=clear
                                       $authentication=(((($profile_info -match 'Authentication')[0]).Split(':'))[1]).trim()
                                       $key=(((($profile_info -match 'Key con')[0]).Split(':'))[1]).trim()
                                       $networktype= (((($profile_info -match 'network type')[0]).Split(':'))[1]).trim()
                                       $connectionmode= (((($profile_info -match 'Connection mode')[0]).Split(':'))[1]).trim() 
                                       $SSIDName= ((((($profile_info -match 'SSID name')[0]).Split(':'))[1]).trim()).replace('"','')
                                       $profile_obj=New-Object -TypeName psobject #-Property $wlanprofile_prop 
                        
                                       $profile_obj| 
                                       Add-Member -Value $SSIDName  -Name 'SSID name' -MemberType NoteProperty -PassThru |
                                       Add-Member -Value $networktype  -Name 'Network Type' -MemberType NoteProperty -PassThru|
                                       Add-Member -value $key -Name 'Key Content' -MemberType NoteProperty -PassThru |
                                       Add-Member -Value $connectionmode -Name 'Connection mode' -MemberType NoteProperty -PassThru|
                                       Add-Member -Value $authentication -Name 'Authentication' -MemberType NoteProperty 
                        
                        
                                       $profiles+=$profile_obj
                        }

                        $profiles
                        

}#end process

}#end func
