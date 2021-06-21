$Today = [string]::Format( "{0:dd-MM-yyyy}", [datetime]::Now.Date )
# This collects todays date, then creates a variable called $today

new-item -ItemType Directory "C:\users\$env:username\Documents\Archive Logs" -ErrorAction SilentlyContinue

Start-Transcript "C:\users\$env:username\Documents\Archive Logs\$today.txt"
# This starts the logging process, using the previously created $today variable

$days = -30

$path = "C:\users\$env:username\Documents"
$Destination = "C:\users\$env:username\Documents\move test"
Foreach($file in (Get-ChildItem $path))
{
	If($file.LastWriteTime -lt (Get-Date).adddays($days).date)
	{
		Move-Item -Path $file.fullname -Destination $Destination -exclude " " -verbose
    }
}
# This creates two variables, $path for server path, and $Destination. It then specifies "for each file within $path, if the files last write time was after 30 days
# move the folder to $destination, excluding the folders specified. -verbose enables deeper logging

Stop-Transcript
# This stops the logging process