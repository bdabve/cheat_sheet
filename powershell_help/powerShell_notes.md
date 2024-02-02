## Add new font to console

```
$key = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont'
Set-ItemProperty -Path $key -Name '000' -Value 'Courier New'
```

* Or in graphical mode

```powershell
window + r and run %windir%\fonts   # To see available font on windows

[D:\my_Folder] PS:6 > regedit.exe

# Navigate to HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont.

# Right-click in the panel on the right side and create a new string value. Name that value “0″ or “00″ or however many zeros you need to create a new key. That string’s value is the name of the font to add.
```