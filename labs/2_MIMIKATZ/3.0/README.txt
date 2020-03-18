rab Benjamin’s source code, open it up in Visual Studio, select the “Second_Release_PowerShell” target option and compile for both Win32 and x64.
Then transform the resulting powerkatz.dlls to a base64 string using base64 -w 0 powerkatz.dll in Linux. You can now replace the $PEBytes32 and $PEBytes64 strings at the bottom of Invoke-Mimikatz.ps1
