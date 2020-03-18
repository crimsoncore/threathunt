# enable clear-text passwords in memory
reg add HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest /v UseLogonCredential /t REG_DWORD /d 1 /f
reg query HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest /v UseLogonCredential 

# Query eventlogs with powershell
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" | where { $_.id -eq 12 -or $_.id -eq 13} | Select-Object -first 1 -property MachineName,Message | FL

# add new local user (event ID 4720)
# add user to local admin group (event ID 4732)

net user backdoor password /ADD
net localgroup administrators backdoor /add
net localgroup "Administrators"

Get-WinEvent -LogName "Security" | where { $_.id -eq 4732} | | Select-Object -first 1 -Property * | FL
