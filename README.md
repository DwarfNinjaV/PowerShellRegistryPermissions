
#Pre Reqs
This Script requires the Get-AdComputer cmdlet.
You will have to install it if not already installed.

Windows 10

	PS> Get-WindowsCapability -Name RSAT.ActiveDirectory* -Online | Add-WindowsCapability -Online

Windows Server

	Expand Remote Server Administration Tools, expand Role Administration Tools, 
	expand AD DS and AD LDS Tools and select the Active Directory module for Windows PowerShell. 

# Execution

Update the information in the script to your desire and then run with powershell to execute

If you need to you may have to allow execution see below.

Enable execution of PowerShell scripts:

	PS> Set-ExecutionPolicy Unrestricted -Scope CurrentUser

Unblock PowerShell scripts and modules within this directory:

	PS> ls -Recurse *.ps*1 | Unblock-File

# Liability

All scripts are provided as-is and you use them at your own risk.

# Donations
Buy me a Soda

Bitcoin:
bc1qa0rqlh3p3mxd6g3ud0vupc4kxl5sn3z69dnla0

SOL Network:
2FTBkiF8fptxMoeWMxBjvbwcv46Te24E4uPL92Qze6Fy

Ethereum Network: (Also Matic, RSK, BSC, Avalanche, Fantom)
0x86d00bEaaF6f2FC9703066b6A8FF39D179D4c86b


## License

Inclluded in the License.md on our GitHub