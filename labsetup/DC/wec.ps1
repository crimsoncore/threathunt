#Enable Windows Eventlog Collector service and subscriptions

wecutil qc /q
wecutil.exe cs c:\terraform\threathunt\labsetup\dc\wec\ThreatHuntPOWERSHELL.xml
wecutil.exe cs c:\terraform\threathunt\labsetup\dc\wec\ThreatHuntSECURITY.xml
# wecutil.exe cs c:\terraform\threathunt\labsetup\dc\wec\ThreatHuntSYSMON.xml

netsh http delete urlacl url=http://+:5985/wsman/ 
netsh http add urlacl url=http://+:5985/wsman/ sddl='D:(A; ; GX; ; ; S-1-5-80-569256582-2953403351-2909559716-1301513147-412116970)(A; ; GX; ; ; S-1-5-80-4059739203-877974739-1245631912-527174227-2996563517)'

setspn -A WSMAN/DC01 ACME\thadmin
setspn -A WSMAN/DC01.acme.local ACME\thadmin
setspn -t ACME -q */*

restart-service wecsvc

gpupdate /force | Out-File C:\gpupdate.txt
