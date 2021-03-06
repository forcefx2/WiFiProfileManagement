<#
    .SYNOPSIS
        Lists the wireless interfaces and their state.
#>
function Get-WiFiInterface
{
    [CmdletBinding()]
    [OutputType([WiFi.ProfileManagement+WLAN_INTERFACE_INFO])]
    param ()

    $interfaceListPtr = 0
    $clientHandle = New-WiFiHandle

    try
    {
        [WiFi.ProfileManagement]::WlanEnumInterfaces($clientHandle, [IntPtr]::zero, [ref]$interfaceListPtr) | Out-Null
        $wiFiInterfaceList = [WiFi.ProfileManagement+WLAN_INTERFACE_INFO_LIST]::new($interfaceListPtr)

        foreach ($wlanInterfaceInfo in $wiFiInterfaceList.wlanInterfaceInfo)
        {
            [WiFi.ProfileManagement+WLAN_INTERFACE_INFO]$wlanInterfaceInfo
        }
    }
    catch
    {
        Write-Error $_
    }
    finally
    {
        Remove-WiFiHandle -ClientHandle $clientHandle
    }
}
