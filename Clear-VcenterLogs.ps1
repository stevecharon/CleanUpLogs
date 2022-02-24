$Log="C:\logs\powershell\"
Start-transcript -Path "$($Log)Clear-VcenterLogs_$(get-date -f "yyyyMMdd")_ps1.log" -append
$days=30
$VCLogging="C:\Programdata\VMWare\vCenterServer\logs\"
$VCenterLogvpx="$($VCLogging)vmware-vpx\"
$VCenterLogiiad="$($VCLogging)iiad\"
$VCenterLogvpx3="$($VCLogging)vmware-vpx\vpxd-alert-*.log.gz"
$VCenterLogperf="$($VCLogging)perfcharts\"
$VCenterLogeam="$($VCLogging)eam\"
$VCenterLoginvsvc="$($VCLogging)invsvc\"
$VCenterLognetdump="$($VCLogging)netdump\"
$VCenterLogvapi="$($VCLogging)vapi\"
$VCenterLogvmdird="$($VCLogging)vmdird\"
$VCenterLogsyslog="$($VCLogging)vmsyslogcollector\"
$VCenterLogsps="$($VCLogging)vmware-sps\"
$VCenterLogvpostgres="$($VCLogging)vpostgres\"
$VCenterLogvclient="$($VCLogging)vsphere-client\"
$VCenterLogvws="$($VCLogging)vws\"
$VCenterLogworkflow="$($VCLogging)workflow\"
$VCenterLogSSO="$($VCLogging)SSO\"
$VCenterLogcm="$($VCLogging)cm\"
$VCenterLogvdcs="$($VCLogging)vdcs\"
$VCenterLogSTS="$($VCLogging)..\runtime\VMwareSTSService\logs\"


#((get-variable VCenterLog*).Value)|%{ write-host "Cleaning... ($_)"; Get-ChildItem $_}
#exit
$script:ByteCount=0

Function CleanLogfiles($TargetFolder)
{
  write-host -debug -ForegroundColor Blue -BackgroundColor Yellow $TargetFolder
  if ($TargetFolder){
    if (Test-Path $TargetFolder) {
        $Now = Get-Date
        $LastWrite = $Now.AddDays(-$days)
        $Files = Get-ChildItem $TargetFolder -Include *.log.*,*.gz,*.txt,*.hprof -Recurse -Force -ea silentlycontinue| Where {$_.LastWriteTime -le "$LastWrite"}
        $ByteCount = ($files|measure -Property Length -Sum).Sum
            foreach ($File in $Files)
            {
               $FullFileName = $File.FullName  
               Write-Host "Deleting file $FullFileName" -ForegroundColor "yellow"; 
               Remove-Item $FullFileName -force -ErrorAction SilentlyContinue | out-null
            }
    return $ByteCount
    }Else {
    Write-Host "The folder $TargetFolder doesn't exist! Check the folder path!" -ForegroundColor "yellow"
    }
  }
}

((get-variable VCenterLog*).Value)|%{ write-host "Cleaning... ($_)"; $result=CleanLogFiles($_);$script:ByteCount = $script:ByteCount + $result }
write-host "Anzahl an Bytes:  $Script:ByteCount"
Stop-Transcript
