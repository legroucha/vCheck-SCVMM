$Title = "Hyper-V emulated VM NIC Adapters"
$Header ="Hyper-V emulated VM NIC Adapters"
$Comments = "Due to performance emulated VM NIC Adapters should only be used when Integration Components is not available for the guest Operating System. VMware VMs is excluded since they are listed with emulated NICs in SC VMM."
$Display = "Table"
$Author = "Jan Egil Ring"
$PluginVersion = 1.0
$PluginCategory = "Hyper-V"

switch -wildcard ($VMMServer.ProductVersion) 
    { 
        "2.*" {$VMs | Where-Object {$_.VirtualizationPlatform -eq "HyperV"} | Get-VirtualNetworkAdapter | Where-Object {$_.VirtualNetworkAdapterType -ne 'Synthetic'} | Select-Object @{Name="VM";Expression={$_.Name}},@{Name="VMHost";Expression={(Get-VM $_.Name -ea silentlycontinue).VMHost.Name}},VirtualNetworkAdapterType,PhysicalAddress,VirtualNetwork | Sort-Object VM} 
        "3.*" {$VMs | Where-Object {$_.VirtualizationPlatform -eq "HyperV"} | Get-SCVirtualNetworkAdapter | Where-Object {$_.VirtualNetworkAdapterType -ne 'Synthetic'} | Select-Object @{Name="VM";Expression={$_.Name}},@{Name="VMHost";Expression={(Get-SCVirtualMachine $_.Name -ea silentlycontinue).VMHost.Name}},VirtualNetworkAdapterType,PhysicalAddress,VirtualNetwork | Sort-Object VM} 
        default {break}
    }
