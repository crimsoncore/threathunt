# This task is scheduled on first reboot of the system - then deletes the task
##############################################################################

# Configure winrm for ansible

$url = "https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
$file = "$env:temp\ConfigureRemotingForAnsible.ps1"

(New-Object -TypeName System.Net.WebClient).DownloadFile($url, $file)

powershell.exe -ExecutionPolicy ByPass -File $file 

# remove schedued task

Unregister-ScheduledTask -Taskname threathunt -Confirm:$false 


# Enable SMBv1 on Windows 10 workstations - for net view etc...
Enable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol

# Add NETWORK SERVICE to local eventlogreaders group on workstations
net localgroup "Event Log Readers" "NT Authority\Network Service" /add
gpupdate /force | out-file c:\gpupdate.txt

