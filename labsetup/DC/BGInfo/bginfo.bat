timeout /t 10 /nobreak

reg add HKU\.DEFAULT\Software\Sysinternals\BGInfo /v EulaAccepted /t REG_DWORD /d 1 /f

\\bigteclab.be\NETLOGON\Bginfo\Bginfo.exe \\bigteclab.be\NETLOGON\Bginfo\bigteclab.bgi /TIMER:00 /nolicprompt