
export subscriptionId="1f734c56-8162-4bb8-9cd3-2bfb316ff2d0";
export resourceGroup="RG_MONITOR";
export tenantId="601b96f2-ab27-475a-a268-ed15a11eac05";
export location="westeurope";
export authType="token";
export correlationId="a0150d47-491d-499d-a233-ab635df0ca69";
export cloud="AzureCloud";

# Download the installation package
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Install the hybrid agent
bash ~/install_linux_azcmagent.sh;

# Run connect command
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --tags "Datacenter='Netlab ',City=Eindhoven,CountryOrRegion=NL,STATUS=ACTIVE,DEPT=INTERNAL" --correlation-id "$correlationId";
