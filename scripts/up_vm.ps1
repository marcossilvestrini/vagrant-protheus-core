# Modules - Execute with Administrator privilegies
# Install-Module -Name vmxtoolkit

# Variables
$vmware = "E:\VMware\vmware.exe"
$vmrun = "E:\VMWare\vmrun.exe"
$port = "22"
$putty = "E:\Apps\Putty\putty.exe"
$vmPath = "E:\Servers\Linux\vagrant-ansible"
$vm = "$($vmPath)\vagrant-ansible.vmx"
$ip = "192.168.0.33"
$vmxName = "vagrant-ansible"
$memoryMB = "16000"
$processors = "3"

# Up vmware
Write-Host "Up Vmware Workstation in path: [$($vmware)]" -BackgroundColor White -ForegroundColor Black
& $vmware

# Up VM srv-devops

## Power Off Virtual Machine if On
Write-Host "Power Off Virtual Machine: [$($vm)]" -BackgroundColor White -ForegroundColor Black
& $vmrun stop $vm >$null

## Set Memory
# SYNTAX: Set-VMXmemory [-VMXName <Object>] [-config <Object>] -MemoryMB <Int32> [<CommonParameters>]
$vmxConfig = (Get-VMX -Path $vmPath -VMXName $vmxName).Config
Set-VMXmemory -VMXName $vmxName -config $vmxConfig -MemoryMB $memoryMB

# Set CPU
Set-VMXprocessor  -VMXName $vmxName -config $vmxConfig -Processorcount $processors

## Power On Virtual Machine
Write-Host "Power On Virtual Machine: [$($vm)]" -BackgroundColor White -ForegroundColor Black
& $vmrun start $vm

## Check Status for SHH Connection
$tcp_test = $false
Write-Host "Check VM Status ..." -BackgroundColor White -ForegroundColor Black
While (!$tcp_test) {
    $tcp_test = (Test-NetConnection -ComputerName $ip -RemotePort $port).TcpTestSucceeded
    if ($tcp_test) {
        Write-Host "VM is Running!!!" -BackgroundColor White -ForegroundColor Green
        Start-Sleep 2
        break;
    }
    Else {
        Write-Host "VM in process of initialization...Waiting" -BackgroundColor White -ForegroundColor Black
        Start-Sleep 1
    }
}

# Close SHH connectio
Write-Host "Kill SSH Connections" -BackgroundColor White -ForegroundColor Black
Get-Process -name putty -ErrorAction SilentlyContinue |
Stop-Process -ErrorAction SilentlyContinue >$null

# Open session SSH
Write-Host "Open SSH Connection" -BackgroundColor White -ForegroundColor Black
& $putty -load "vagrant-protheus-core"