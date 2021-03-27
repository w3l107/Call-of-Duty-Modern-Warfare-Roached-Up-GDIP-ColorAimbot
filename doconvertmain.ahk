#SingleInstance Force
ListLines, Off
SetBatchLines, -1

Ahk2Exe := "C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.ahk"
RoachedUpIN := "D:\Downloads\[Dev]\[COD]\RoachedUp\RoachedUp.ahk"
RoachedUpOUT := "D:\Desktop Shit\SHIIIIIIIIIT\Call of Duty MW\Roached Up.exe"
RoachedUpICON := "D:\Downloads\[Dev]\[COD]\RoachedUp\Convert\roachedup.ico"
RoachedUpBIN := "C:\Program Files\AutoHotkey\AutoHotkey.exe"
ResourceHackerEXE := "D:\Downloads\[Dev]\[COD]\RoachedUp\resource_hacker\ResourceHacker.exe"
ResourceHackerOPEN := "D:\Desktop Shit\SHIIIIIIIIIT\Call of Duty MW\Roached Up.exe"
ResourceHackerSAVE := "D:\Desktop Shit\SHIIIIIIIIIT\Call of Duty MW\Roached Up.exe"
ResourceHackerRES := "D:\Desktop Shit\SHIIIIIIIIIT\Call of Duty MW\VersionInfo1.res"

RunWait "%Ahk2Exe%" /in "%RoachedUpIN%" /out "%RoachedUpOUT%" /icon "%RoachedUpICON%" /bin "%RoachedUpBIN%" /pass "AutoHotkey" /mpress "1"
SoundPlay, C:\Windows\media\notify.wav, WAIT
RunWait "%ResourceHackerEXE%" -open "%ResourceHackerOPEN%" -save "%ResourceHackerSAVE%" -action addoverwrite -res "%ResourceHackerRES%"
SoundPlay, C:\Windows\media\chimes.wav, WAIT
