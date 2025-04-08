
Invoke-Expression (&starship init powershell)

Import-Module -Name Terminal-Icons

fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
