# This task is scheduled on first reboot of the system - then deletes the task
##############################################################################

# Import GPO

start-sleep -s 600 

powershell -file C:\terraform\threathunt\labsetup\DC\GPOmigration\Call-GPOImport.ps1 > C:\out.txt

# Configure winrm for ansible

$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file 

#Enable Windows Eventlog Collector service and subscriptions

wecutil qc /q
wecutil.exe cs c:\terraform\threathunt\labsetup\dc\wec\ThreatHuntPOWERSHELL.xml
wecutil.exe cs c:\terraform\threathunt\labsetup\dc\wec\ThreatHuntSECURITY.xml
wecutil.exe cs c:\terraform\threathunt\labsetup\dc\wec\ThreatHuntSYSMON.xml

netsh http delete urlacl url=http://+:5985/wsman/ 
netsh http add urlacl url=http://+:5985/wsman/ sddl='D:(A; ; GX; ; ; S-1-5-80-569256582-2953403351-2909559716-1301513147-412116970)(A; ; GX; ; ; S-1-5-80-4059739203-877974739-1245631912-527174227-2996563517)'

setspn -A WSMAN/DC01 ACME\thadmin | Out-File C:\luk.txt
setspn -A WSMAN/DC01.acme.local ACME\thadmin | Out-File C:\luk.txt -append

restart-service wecsvc

gpupdate /force | Out-File C:\luk.txt -append

#Add service account and SPN for Kerberoasting
net user svc_vulnscan passw0rd /ADD /DOMAIN
net group "Domain Admins" svc_vulnscan /ADD /DOMAIN
setspn -a DC01/svc_vulnscan.acme.local:666 acme\svc_vulnscan 

Unregister-ScheduledTask -Taskname threathunt -Confirm:$false 
