# fwtool v1.0 (WIP)
## Make quick inbound and outbound rules to Windows Firewall.
![fwtool](https://github.com/PyhaMarkus/fwtool/blob/master/kuvat/fwtool.PNG "FWtool")
### Installation
1. Open up Windows Powershell with Administrator privileges.
2. Make sure your Execution-Policy allows Powershell scripts to run. You check your policy with the command "**ExecutionPolicy -List**"
3. Download **.ZIP** and extract to a location of your choosing.
4. Open up **fwtool.ps1** in a text editor. (Notepad++ recommended)
5. Change the directory paths of the two pictures to the corresponding paths in your system. Found on lines 40 and 130.
6. Save changes.

### Usage
1. Right click on fwtool.ps1 and click "**Run with Powershell**". This tool is automatically run with Administrator privileges but you have to click "**Yes**" when UAC pops-up.
2. Give a rule name. This is how you identify the rule within the Windows Firewall.
3. Set the IP Address. This is the remote address that you want to block all connections to. **NOTE:** Only IPv4 supported at the moment.
4. Hit "**Apply Rules**".
5. Check Windows Firewall to see that the rules were applied.
