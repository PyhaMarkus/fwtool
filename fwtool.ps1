###### Main Function ######

### Make sure to run as an Administrator ###

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))

{   
$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process powershell -Verb runAs -ArgumentList $arguments
Break
}

### Adds rules to Windows Firewall ###

function NewFirewallRule{

	$RuleDisplayName = $DisplayNameBox.text;
	$RemoteAddress = $AddressBox.text;

	#Inbound
	New-NetFirewallRule -DisplayName $RuleDisplayName -Description "Created with FW Tool" -Direction Inbound -Protocol Any -LocalPort Any -RemotePort Any -RemoteAddress $RemoteAddress -Action Block
	#Outbound
	New-NetFirewallRule -DisplayName $RuleDisplayName -Description "Created with FW Tool" -Direction Outbound -Protocol Any -LocalPort Any -RemotePort Any -RemoteAddress $RemoteAddress -Action Block

	$OutputBox.text = "Finished applying rules. Inbound/Outbound rules added for $RemoteAddress with the name of $RuleDisplayName."
}

###### GUI Starts Here ######

[void]
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void]
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

### Main Form ###

$Form = New-Object System.Windows.Forms.Form
$Form.Text = "FW Tool v1.0"
$Form.Size = New-Object System.Drawing.Size(555,310)
$Form.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon('C:\Users\markus\Desktop\fwtool-master\kuvat\fw_icon.ico')
$Form.FormBorderStyle = 'Fixed3D' #Fixed window
$Form.MaximizeBox = $False #Fixed window


### Heading ###

$Heading = New-Object System.Windows.Forms.Label
$Heading.Text = "Apply new FW rules"
$Heading.AutoSize = $True
$Heading.Location = New-Object System.Drawing.Point(3,10)
$Heading.Font = "Microsoft Sans Serif,16,style=Bold"
$Heading.ForeColor = "black"
$Form.Controls.Add($Heading)

### Paragraph ###

$Paragraph = New-Object System.Windows.Forms.Label
$Paragraph.Text = "Deny all connections to and from a remote address"
$Paragraph.AutoSize = $True
$Paragraph.Location = New-Object System.Drawing.Point(5,45)
$Paragraph.Font = "Microsoft Sans Serif,11"
$Paragraph.ForeColor = "black"
$Form.Controls.Add($Paragraph)

### Paragraph2 ###

$Paragraph2 = New-Object System.Windows.Forms.Label
$Paragraph2.Text = "Rule name:"
$Paragraph2.AutoSize = $True
$Paragraph2.Location = New-Object System.Drawing.Point(5,90)
$Paragraph2.Font = "Microsoft Sans Serif,11"
$Paragraph2.ForeColor = "black"
$Form.Controls.Add($Paragraph2)

### Paragraph3 ###

$Paragraph3 = New-Object System.Windows.Forms.Label
$Paragraph3.Text = "IP Address:"
$Paragraph3.AutoSize = $True
$Paragraph3.Location = New-Object System.Drawing.Point(5,130)
$Paragraph3.Font = "Microsoft Sans Serif,11"
$Paragraph3.ForeColor = "black"
$Form.Controls.Add($Paragraph3)

### InputBox for DisplayName ###

$DisplayNameBox = New-Object System.Windows.Forms.TextBox
$DisplayNameBox.Location = New-Object System.Drawing.Size(100,90)
$DisplayNameBox.Size = New-Object System.Drawing.Size(150,20)
$DisplayNameBox.Font = "Microsoft Sans Serif,11"
$DisplayNameBox.MaxLength = "24"
$DisplayNameBox.TextAlign = "left"
$Form.Controls.Add($DisplayNameBox)

### InputBox for Remote Address ###

$AddressBox = New-Object System.Windows.Forms.TextBox
$AddressBox.Location = New-Object System.Drawing.Size(100,130)
$AddressBox.Size = New-Object System.Drawing.Size(150,20)
$AddressBox.Font = "Microsoft Sans Serif,11"
$AddressBox.MaxLength = "15"
$AddressBox.TextAlign = "left"
$Form.Controls.Add($AddressBox)


### Button ###

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(260,130)
$Button.Size = New-Object System.Drawing.Size(90,23)
$Button.Text = "Apply rules"
$Button.Font = "Microsoft Sans Serif,10,style=bold"
$Button.Add_Click({NewFirewallRule})
$Form.Controls.Add($Button)

### OutputBox ###

$OutputBox = New-Object System.Windows.Forms.TextBox
$OutputBox.Location = New-Object System.Drawing.Size(7,180)
$OutputBox.Size = New-Object System.Drawing.Size(525,80)
$OutputBox.Font = "consolas,8"
$OutputBox.MultiLine = $True
$OutputBox.ScrollBars = "Vertical"
$OutputBox.Enabled = $True
$OutputBox.ReadOnly = $True #User input disabled
$Form.Controls.Add($OutputBox)

### Picture ###

$File = (Get-Item 'C:\Users\markus\Desktop\fwtool-master\kuvat\denied.png')
$img = [System.Drawing.Image]::Fromfile($File)


$PictureBox = New-Object System.Windows.Forms.PictureBox
$PictureBox.Location = New-Object System.Drawing.Size(380,15)
$PictureBox.Width = $img.Size.Width;
$PictureBox.height = $img.Size.Height;

$PictureBox.Image = $img;
$Form.Controls.Add($PictureBox)




$Form.Add_Shown({$Form.Activate()})
[void] $Form.ShowDialog() #Activates the form

###### GUI Ends Here ######

