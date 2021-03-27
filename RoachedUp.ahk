;---------------------------------------------------------------------------------------------------------
; RoachedUp by Mike
; Copyright (c) 2021
;---------------------------------------------------------------------------------------------------------

#SingleInstance Force
#Persistent
#KeyHistory 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127
SetWorkingDir %A_ScriptDir%
ListLines, Off
SetBatchLines, -1
SetKeyDelay,-1, 1
SetControlDelay, -1
SetWinDelay,-1
SendMode, InputThenPlay


;-------------------------------------------Variables Start-----------------------------------------------
Global PID := DllCall("GetCurrentProcessId")
Process, Priority, %PID%, RealTime

DllCall("dwmapi\DwmEnableComposition", "uint", 0)

Global programName := "RoachedUp"
Global programVersion := 1.23



; Global UpdateFileV2	:= (A_Temp "\pictest1.png")
Global UpdateFileV2	:= (A_ScriptDir "\Pictures\pictest1.png")
; Global UpdateFileV3	:= (A_Temp "\pictestgun.png")


Global CenterX := (A_ScreenWidth / 2) ; 960
Global CenterY := (A_ScreenHeight / 2) ; 540

Global iTick := 0
Global TestV := ""
Global TestV2 := ""
Global bNowX := 0
Global bTestPos := ""
Global TestTitle := ""
Global ElapsedTime := ""


Global bTick := 0
; Global loops := 25
Global threads := []



bRapidFire = 0
bRecoilControl = 0
bFovCircle = 0
bFovCircle2 = 0
bFovCircleGun = 0
bSearchGun = 0
bTriggerBot1 = 0
bTriggerBot2 = 0
bTriggerBot3 = 0
bAimBot1 = 0
bAimBot2 = 0
bAimBot3 = 0
bAimBot4 = 0
tTriggerBot = 0
doCrossHair = 0
bAutoAimVisual = 0
bSmooth = 1
Global bSmoothV2 := 0
Global bSmoothV3 := 0


AAVrunning := false

bDoFOV = 0
GUIWinShow = 0



; t360 = 0
; t180 = 0




DefaultKeyBindRFK = F1
DefaultRFDelay = 25
DefaultKeyBindRCK = F2
DefaultRCDelayX = -1
DefaultRCDelayY = 1
DefaultKeyBind360Spin = 9
Default360SpinD = 10
DefaultKeyBind180Spin = 0
Default360DPI = 6
Default360SpinS = 0
DefaultAimColorS = 0x8A150D
DefaultColorVariationS = 100 
DefaultZeroXS = 960
DefaultZeroYS = 500
DefaultCFovXS = 150
DefaultCFovYS = 110
DefaultAimOffsetS = -1
DefaultAimSpeedS = 7
DefaultCrossHairSize = 15
DefaultCrossHairColor = Aqua
DefaultCrossHairGap = 1
DefaultCrossHairStyle = Cross
DefaultTBOffset = 0
DefaultSmoothSpeed = 2.5
DefaultbSmooth = 1


ini1 = 0
ini2 = 0
ini3 = 0
ini4 = 0
ini5 = 0
ini6 = 0
ini7 = 0
ini8 = 0
ini9 = 0
ini10 = 0
ini11 = 0
ini12 = 0
ini13 = 0
ini14 = 0
ini15 = 0
ini16 = 0
ini17 = 0
ini18 = 0
ini19 = 0
ini20 = 0
ini21 = 0
ini22 = 0
ini23 = 0
ini24 = 0
ini25 = 0

Black 	= 000000
White 	= FFFFFF
Red		= FF0000
Green 	= 008000
Blue	= 0000FF
Silver 	= C0C0C0
Lime 	= 00FF00
Gray	= 808080
Olive 	= 808000
Yellow 	= FFFF00
Maroon 	= 800000
Navy 	= 000080
Purple 	= 800080
Teal 	= 008080
Fuchsia = FF00FF
Aqua 	= 00FFFF


MouseGetPos, mx, my
spin180Degrees := (A_ScreenWidth // 2)
PI := 4 * ATan(1)


OnMessage(0x14, "WM_ERASEBKGND")
;-------------------------------------------Variables End-------------------------------------------------




;-------------------------------------------TrayIcon Start------------------------------------------------
Menu, Tray, Tip, %programName% v%programVersion%
Menu, Tray, NoStandard 
Menu, Tray, Add, RealTime Priority, RealTimePriority 
Menu, Tray, Add, High Priority , HighPriority 
Menu, Tray, Add, Normal Priority, NormalPriority
Menu, Tray, Default, RealTime Priority
Menu, Tray, Disable, RealTime Priority
Menu, Tray, Add
Menu, Tray, Add, ShowMenu, ShowProgram
Menu, Tray, Add
Menu, Tray, Add, Reload, Reload
Menu, Tray, Add, Exit, QuitMessageL
;-------------------------------------------TrayIcon End--------------------------------------------------


;-------------------------------------------StartUp Start-------------------------------------------------
RunAsAdmin()
FixMem()
showStartingLogo()
StartMessage()
OnGUI()
;-------------------------------------------StartUp End---------------------------------------------------


OnGUI() 
{
	Global
	Gui 1:Color, Silver
	; Gui 1:-Caption
	; Gui 1:Margin, 0, 0
	; Gui 1:Font, s7, Comic Sans MS
	
		

	UpdateFile:=(A_ScriptDir "\Pictures\pic1.gif")
		
	Gui 1:Add, Tab3,x10 y30 cBlue, Rapid Fire|Recoil Control|Extra Shit|Aim Assist||
	
	Gui 1:Add, Text, x20 y60 cRed vRapid gRapidFireToggle, Rapid Fire: OFF
	Gui 1:Add, Text, x20 y80 cBlack, Rapid Fire Delay :
	Gui 1:Add, Edit, w120 vRapidFire, %iniRFDelay%
	Gui 1:Add, Button, x150 y98 gSetRF, SET

	Gui 1:Add, Text, x20 y125 cBlack, Rapid Fire Key :
	Gui 1:Add, Hotkey, x20 y140 vRFK, %iniKeyBindRFK%
	Gui 1:Add, Button, x150 y139 gClearKeyRF, SET KEY
	GuiControlGet, RFK
	Hotkey, ~$*%RFK%, RapidFireToggle, on


	Gui 1:Tab, 2
	Gui 1:Add, Text, x20 y60 cRed vRecoil gRecoilToggle, Recoil Control: OFF
	Gui 1:Add, Text, x100 y80 cGreen, Negative=Left | Positive=Right
	Gui 1:Add, Text, x20 y80 cBlack, Recoil X Speed :
	Gui 1:Add, Edit, w120 vRecoilCX, %iniRCDelayX%
	Gui 1:Add, Button, x150 y98 gSetRCX, SET

	Gui 1:Add, Text, x100 y125 cGreen, Negative=Up | Positive=Down
	Gui 1:Add, Text, x20 y125 cBlack, Recoil Y Speed :
	Gui 1:Add, Edit, w120 vRecoilCY, %iniRCDelayY%
	Gui 1:Add, Button, x150 y143 gSetRCY, SET

	Gui 1:Add, Text, x20 y175 cBlack, Recoil Control Key :
	Gui 1:Add, Hotkey, x20 y190 vRCK, %iniKeyBindRCK%
	Gui 1:Add, Button, x150 y189 gClearKeyRC, SET KEY
	GuiControlGet, RCK
	Hotkey, ~$*%RCK%, RecoilToggle, on
	
	
	Gui 1:Tab, 3
	Gui 1:Add, Text, x20 y60 cPurple, Search Direction :
	Gui 1:Add, Edit, w50 v360SpinDPI, %ini360SpinDPI%
	Gui 1:Add, Button, x95 y78 gSet360SpinDPI, SET
	
	Gui 1:Add, Text, x150 y60 cPurple, Instances :
	Gui 1:Add, Edit, w50 v360SpinSens, %ini360SpinS%
	Gui 1:Add, Button, x215 y78 gSet360SpinS, SET
	
	Gui 1:Add, Text, x20 y110 cPurple, PictureX Offset :
	Gui 1:Add, Edit, w50 v360SpinDelay, %ini360SpinD%
	Gui 1:Add, Button, x85 y128 gSet360SpinDelay, SET
	
	; Gui 1:Add, Text, x150 y110 cPurple, Extra 4 :
	Gui 1:Add, Text, x150 y110 cPurple, SmoothV3 XOffset :
	Gui 1:Add, Edit, w50 vTBOffset, %iniTBOffset%
	Gui 1:Add, Button, x215 y128 gSetTBOffset, SET
	
	Gui 1:Add, Text, x20 y180 cPurple, CrossHair Color :
	Gui 1:Add, ComboBox, w65 vCHColor gSetCHColor, Black|White|Red|Green|Blue|Silver|Lime|Gray|Olive|Yellow|Maroon|Navy|Purple|Teal|Fuchsia|Aqua
	GuiControl, ChooseString, CHColor, %iniCHColor% ;Submit
	
	; Gui 1:Add, Text, x150 y180‬ cPurple, CrossHair Size :
	Gui 1:Add, Text, x150 y180‬ cPurple, SmoothV3 Speed Reduce :
	Gui 1:Add, Edit, w65 vCHSize, %iniCHSize%
	Gui 1:Add, Button, x225 y198 gSetCHSize, SET
	
	Gui 1:Add, Text, x20 y230‬ cPurple, CrossHair Style :
	Gui 1:Add, ComboBox, w65 vCHStyle gSetCHStyle, Cross ;|Gap
	GuiControl, ChooseString, CHStyle, %iniCHStyle% ;Submit
	
	; Gui 1:Add, Text, x150 y230‬ cPurple, CrossHair Thickness :
	Gui 1:Add, Text, x150 y230‬ cPurple, SmoothV3 InnerBox Size :
	Gui 1:Add, Edit, w65 vCHGap, %iniCHGap%
	Gui 1:Add, Button, x225 y248 gSetCHGap, SET
	
	/*
	Gui 1:Add, Text, x20 y60 cPurple, 360 Spin Key :
	Gui 1:Add, Hotkey, x20 y80 w30 v360Spin, %iniKeyBind360Spin%
	Gui 1:Add, Button, x60 y80 gClearKey360Spin, SET
	GuiControlGet, 360Spin
	Hotkey, ~$*%360Spin%, 360SpinToggle, on
	
	Gui 1:Add, Text, x150 y60 cPurple, 180 Spin Key :
	Gui 1:Add, Hotkey, x150 y80 w30 v180Spin, %iniKeyBind180Spin%
	Gui 1:Add, Button, x190 y80 gClearKey180Spin, SET
	GuiControlGet, 180Spin
	Hotkey, ~$*%180Spin%, 180SpinToggle, on
	
	Gui 1:Add, Text, x20 y110 cPurple, 360 Spin :
	Gui 1:Add, Edit, w50 v360SpinDPI, %ini360SpinDPI%
	Gui 1:Add, Button, x80 y128 gSet360SpinDPI, SET	
	
	Gui 1:Add, Text, x150 y110 cPurple, 180 Spin :
	Gui 1:Add, Edit, w50 v360SpinSens, %ini360SpinS%
	Gui 1:Add, Button, x210 y128 gSet360SpinS, SET		
	
	Gui 1:Add, Text, x20 y160 cPurple, 360 SpinDelay :
	Gui 1:Add, Edit, w50 v360SpinDelay, %ini360SpinD%
	Gui 1:Add, Button, x80 y178 gSet360SpinDelay, SET	
	
	Gui 1:Add, Text, x150 y160 cPurple, TriggerBot Offset :
	Gui 1:Add, Edit, w60 vTBOffset, %iniTBOffset%
	Gui 1:Add, Button, x215 y178 gSetTBOffset, SET	
	*/
	
	Gui 1:Tab, 4
	Gui 1:Add, Text, x20 y60 cPurple, Aim Color :
	Gui 1:Add, Edit, w65 vAimColor, %iniAimColor%
	Gui 1:Add, Button, x95 y78 gSetAimColor, SET
	
	Gui 1:Add, Text, x150 y60 cPurple, Color Variation :
	Gui 1:Add, Edit, w60 vColorVariation, %iniColorVariation%
	Gui 1:Add, Button, x215 y78 gSetColorVariation, SET
	
	Gui 1:Add, Text, x20 y110 cPurple, Zero X :
	Gui 1:Add, Edit, w60 vZeroX, %iniZeroX%
	Gui 1:Add, Button, x85 y128 gSetZeroX, SET
	
	Gui 1:Add, Text, x150 y110 cPurple, Zero Y :
	Gui 1:Add, Edit, w60 vZeroY, %iniZeroY%
	Gui 1:Add, Button, x215 y128 gSetZeroY, SET
	
	Gui 1:Add, Text, x20 y160 cPurple, CFov X :
	Gui 1:Add, Edit, w60 vCFovX, %iniCFovX%
	Gui 1:Add, Button, x85 y178 gSetCFovX, SET
	
	Gui 1:Add, Text, x150 y160 cPurple, CFov Y :
	Gui 1:Add, Edit, w60 vCFovY, %iniCFovY%
	Gui 1:Add, Button, x215 y178 gSetCFovY, SET
	
	Gui 1:Add, Text, x20 y210 cPurple, Aim Offset :
	Gui 1:Add, Edit, w60 vAimOffset, %iniAimOffset%
	Gui 1:Add, Button, x85 y228 gSetAimOffset, SET
	Gui 1:Add, Text, x20 y252 cGreen, (-) = Up | (+) = Down
	
	Gui 1:Add, Text, x150 y210 cPurple, Aim Speed :
	Gui 1:Add, Edit, w60 vAimSpeed, %iniAimSpeed%
	Gui 1:Add, Button, x215 y228 gSetAimSpeed, SET

	Gui 1:Add, CheckBox, x20 y280 vbSmooth gSetSmooth Checked%inibSmooth%, Smooth
	
	Gui 1:Add, Text, x150 y260 cPurple, Smooth :
	Gui 1:Add, Edit, w60 vSmoothSpeed, %iniSmoothSpeed%
	Gui 1:Add, Button, x215 y278 gSetSmoothSpeed, SET	
	

	Gui 1:Tab
	Gui 1:Add, Text, w250 x10 y10 h16 cPurple gProgramLockInfo, Locked To :
	Gui 1:Add, Text, w180 x80 y10 h16 cBlack vProgramLock, %iniProgramLock%
	GuiControlGet, ProgramLock
	GroupAdd("AW", "ahk_exe " ProgramLock)
	GroupTranspose("AW")
	
	Gui 1:Add, Button, x20 y320 w80 h20 gCloseMenu, CloseMenu
	Gui 1:Add, Button, x140 y320 w100 h20 gQuitMessageL, ForceQuitProgram
	; Gui 1:Add, Text, +center w106 x70 yp+30 h16 cGray +Border vUpdateInfo gOpenUpdate, Not Checked...

	Gui 1:Add, GroupBox, x10 y370 w235 h50 cPurple, By: Mike
	


	AGif := AddAnimatedGIF(UpdateFile, , 0, 50, 50, 1)
	GuiControl, Show, %AGif%
	
	Sleep 3200
	GuiControl, Hide, %startLogo%
	Gui 3:Destroy
	; coordmode, mouse, window
	Sleep 100
	
	GUIWinShow = 1
	;Gui 1:Show, Restore
	Gui 1:Show, Restore ;, StartTitle
	InitRV1 := new AimRoach()
	Sleep 50
	InitRV2 := new AimRoach()
	Sleep 50
	InitRV3 := new AimRoach()
	Sleep 50
	InitRV4 := new AimRoach()
	Sleep 50	
	InitTB := new TriggerRoach()
	Sleep 50
	; InitSG := new GunSearchRoach()
	Sleep 50
	

	Sleep 300
	
	
	; RemovedDownload
	
	
	Sleep 100
	StartSpawn()
	Sleep 250	
}


;-------------------------------------------MainLoop Start------------------------------------------------

Loop
{
	Global StartTime := A_TickCount
	

	
	MouseGetPos, curPosX, curPosY

	GuiControlGet, ProgramLock
	Global ProgramLockV := ProgramLock
	
	GuiControlGet, RapidFire
	Global RapidFireV := RapidFire

	GuiControlGet, RecoilCX
	Global RecoilCXV := RecoilCX
	
	GuiControlGet, RecoilCY	
	Global RecoilCYV := RecoilCY
	
	GuiControlGet, 360Spin
	Global 360SpinV := 360Spin

	GuiControlGet, 360SpinDelay
	Global 360SpinDelayV := 360SpinDelay

	GuiControlGet, 180Spin
	Global 180SpinV := 180Spin

	GuiControlGet, 360SpinDPI
	Global 360SpinDPIV := 360SpinDPI

	GuiControlGet, 360SpinSens
	Global 360SpinSensV := 360SpinSens

	GuiControlGet, AimColor
	Global AimColorV := AimColor

	GuiControlGet, ColorVariation
	Global ColorVariationV := ColorVariation

	GuiControlGet, ZeroX
	Global ZeroXV := ZeroX

	GuiControlGet, ZeroY
	Global ZeroYV := ZeroY

	GuiControlGet, CFovX
	Global CFovXV := CFovX

	GuiControlGet, CFovY
	Global CFovYV := CFovY
	
	GuiControlGet, AimOffset
	Global AimOffsetV := AimOffset
	
	GuiControlGet, AimSpeed
	Global AimSpeedV := AimSpeed
	
	GuiControlGet, CHColor
	Global CHColorV := CHColor
	
	GuiControlGet, CHSize
	Global CHSizeV := CHSize
	
	GuiControlGet, CHStyle
	Global CHStyleV := CHStyle
	
	GuiControlGet, CHGap
	Global CHGapV := CHGap

	GuiControlGet, TBOffset
	Global TBOffsetV := TBOffset
	
	GuiControlGet, bSmooth
	Global bSmoothV = bSmooth
	
	GuiControlGet, SmoothSpeed
	Global SmoothSpeedV := SmoothSpeed
	
	
	Global ScanLV := ZeroXV - CFovXV 
	Global ScanTV := ZeroYV - CFovYV
	Global ScanRV := ZeroXV + CFovXV
	Global ScanBV := ZeroYV + CFovYV
	
	
	Global GunX := (A_ScreenWidth - 380)
	Global GunY := (A_ScreenHeight - 50)
	Global GunScanLV := (GunX - 100)
	Global GunScanTV := (GunY - 50)
	Global GunScanRV := (GunX + 100)
	Global GunScanBV := (GunY + 50)
	
	
	

	if (bAimBot1 = 1)
	{
		if GroupActive("AW")
		{
			if ( InitRV1.FiringKey("LButton") )
			{	
				InitRV1.DoTheBot("LButton")	
			}			
		}
	}
	
	if (bAimBot2 = 1)
	{
		if GroupActive("AW")
		{
			if ( InitRV2.FiringKey("RButton") )
			{	
				InitRV2.DoTheBot("RButton")	
			}
		}
	}
	
	if (bAimBot3 = 1)
	{
		if GroupActive("AW")
		{
			if ( InitRV3.FiringKey("-") )
			{	
				InitRV3.DoTheBot("-")	
			}
		}
	}
	
	if (bAimBot4 = 1)
	{
		if GroupActive("AW")
		{
			if ( InitRV4.FiringKey("Shift") )
			{	
				InitRV4.DoTheBot("Shift")	
			}
		}
	}
	
	if (bTriggerBot1 = 1)
	{
		if GroupActive("AW")
		{
			if ( InitTB.FiringKey("-") )
			{	
				InitTB.DoTheTrigger("-")
			}
		}
	}
	
	if (bTriggerBot2 = 1)
	{
		if GroupActive("AW")
		{
			if ( InitTB.FiringKey("RButton") )
			{	
				InitTB.DoTheTrigger("RButton")
			}
		}
	}
	
	/*
	if (bSearchGun = 1)
	{
		if GroupActive("AW")
		{
			if ( InitSG.FiringKey("Q") )
			{	
				InitSG.DoTheBotGun("Q")
			}
		}
	}
	*/
	

	/*
	if (bTriggerBot = 1)
	{
		if GroupActive("AW")
		{
			if ( FiringKey("-") )
			{	
				DoTheTrigger("-")
			}
		}
	}
	*/


/*
	if(bAutoAimVisual = 1)
	{
		GoSub doAimVisual
	}
	else
	{
		SetTimer, doAimVisual, Off
		Gui 6:Cancel
		bAutoAimVisual = 0
		tooltipN("AutoAimVisual: OFF", 720, 10, 1000, 17)	
	}
*/	
	
	if(ThreadIsRunningV1)
	{
		ahkV1.ahkassign.bActiveLock := GroupActive("AW")
		ahkV1.ahkassign.bRapidFire := bRapidFire
		ahkV1.ahkassign.iRapidFireDelay := RapidFireV
	}
	if(ThreadIsRunningV2)
	{
		ahkV2.ahkassign.bActiveLock := GroupActive("AW")
		ahkV2.ahkassign.bRecoilControl := bRecoilControl
		ahkV2.ahkassign.RecoilCXV := RecoilCXV
		ahkV2.ahkassign.RecoilCYV := RecoilCYV	
	}
	if(ThreadIsRunningV3)
	{
		threadV3.ahkassign.iProgramLockV := ProgramLockV
		threadV3.ahkassign.iUpdateFileV2 := UpdateFileV2
		threadV3.ahkassign.iScanLV := ScanLV
		threadV3.ahkassign.iScanTV := ScanTV
		threadV3.ahkassign.iScanRV := ScanRV
		threadV3.ahkassign.iScanBV := ScanBV
		threadV3.ahkassign.iColorVariationV := ColorVariationV
		threadV3.ahkassign.iAimColorV := AimColorV
		threadV3.ahkassign.i360SpinDPIV := 360SpinDPIV
		threadV3.ahkassign.i360SpinSensV := 360SpinSensV
		; threadV3.ahkassign.ixL := xL
		; threadV3.ahkassign.iyT := yT
		; threadV3.ahkassign.ixR := xR
		; threadV3.ahkassign.iyB := yB
		; threadV3.ahkassign.iw2 := w2
		; threadV3.ahkassign.ih2 := h2
	}
	
	
	
	/*
	if(ThreadIsRunningV4)
	{
		ahkV4.ahkassign.iProgramLockV := ProgramLockV
		ahkV4.ahkassign.iUpdateFileV3 := UpdateFileV3
		ahkV4.ahkassign.iGunScanLV := GunScanLV
		ahkV4.ahkassign.iGunScanTV := GunScanTV
		ahkV4.ahkassign.iGunScanRV := GunScanRV
		ahkV4.ahkassign.iGunScanBV := GunScanBV
		ahkV4.ahkassign.iColorVariationV := ColorVariationV
		ahkV4.ahkassign.iAimColorV := AimColorV
		ahkV4.ahkassign.i360SpinDPIV := 360SpinDPIV
		ahkV4.ahkassign.i360SpinSensV := 360SpinSensV	
	}
	*/

}
return



;-------------------------------------------MainLoop End--------------------------------------------------


generateScriptV1()
{
scriptV1 = 
(	%
#SingleInstance Force
#Persistent
#NoTrayIcon
#KeyHistory 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127
SetWorkingDir %A_ScriptDir%
ListLines, Off
SetBatchLines, -1
SetKeyDelay,-1, 1
SetControlDelay, -1
SetWinDelay,-1
SendMode, InputThenPlay

Global PIDV1 := DllCall("GetCurrentProcessId")
Process, Priority, %PIDV1%, RealTime

DllCall("dwmapi\DwmEnableComposition", "uint", 0)
;Menu, Tray, Tip, RoachThread v1

FixMem()

FixMem()
{
    h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", PIDV1)
    DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
    DllCall("CloseHandle", "Int", h)
	;MsgBox,,, Memory Fixed! %PIDV1% RoachThread v1, 0.5
}


~$*LButton::
if(bActiveLock)
{
	Loop
	{
		GetKeyState, var, LButton, P
		If var = U
		{
			Break
		}
		
		if (bRapidFire = 1)
		{
			if (FiringKey("LButton"))
			{
				doLeftMouseClick()
				RandomSleep(iRapidFireDelay - 10, iRapidFireDelay + 5)
			}
		}
	}	
}
return

FiringKey(FireKey)
{
	Return GetKeyState(FireKey, "P")
}

RandomSleep(Between1, Between2)
{
	Random, RandomizedSleepTime, Between1, Between2
	Sleep, RandomizedSleepTime
}

doLeftMouseClick()
{
	local INPUT := "", Size := A_PtrSize + 4*4 + A_PtrSize*2
	VarSetCapacity(INPUT, Size, 0 )
	NumPut(0x0002, INPUT, A_PtrSize + 4*3, "UInt" )
	DllCall("SendInput", "UInt", 1, "UPtr", &INPUT, "Int", Size, "UInt")
	RandomSleep(25, 45)
	NumPut(0x0004, INPUT, A_PtrSize + 4*3, "UInt" )
	DllCall("SendInput", "UInt", 1, "UPtr", &INPUT, "Int", Size, "UInt")
}

ToolTipN(__tooltipText:="N/A", X := "", Y := "", __removeDelay:=0, __whichToolTip:=1) 
{
	static __n := 0

	Tooltip % __tooltipText, % X, % Y, % __whichToolTip
	__f := Func("removeToolTip").bind(__whichToolTip, ++__n) ; creates a function reference and binds it __whichToolTip  which will be passed as argument for the callback function below
	SetTimer, % __f, % -__removeDelay ; minus sign indicates settimer to run only once
	return
}

removeToolTip(__whichToolTip, __n) 
{
	tooltip,,,, % __whichToolTip ; if tooltip text argument is empty the toottip is removed
}

)
	return scriptV1
}


generateScriptV2()
{
scriptV2 = 
(	%
#SingleInstance Force
#Persistent
#NoTrayIcon
#KeyHistory 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127
SetWorkingDir %A_ScriptDir%
ListLines, Off
SetBatchLines, -1
SetKeyDelay,-1, 1
SetControlDelay, -1
SetWinDelay,-1
SendMode, InputThenPlay

Global PIDV2 := DllCall("GetCurrentProcessId")
Process, Priority, %PIDV2%, RealTime

DllCall("dwmapi\DwmEnableComposition", "uint", 0)
;Menu, Tray, Tip, RoachThread v2

FixMem()

FixMem()
{
    h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", PIDV2)
    DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
    DllCall("CloseHandle", "Int", h)
	;MsgBox,,, Memory Fixed! %PIDV2% RoachThread v2, 0.5
}

~$*LButton::
if(bActiveLock)
{
	Loop
	{
		GetKeyState, var, LButton, P
		If var = U
		{
			Break
		}
		
		if (bRecoilControl = 1)
		{
			if ( FiringKey("LButton") )
			{
				MouseMoveRoachV2(RecoilCXV, RecoilCYV)
				Sleep 15
				MouseMoveRoachV2(RecoilCXV, RecoilCYV)
				Sleep 5
			}
		}
	}	
}	
return

MouseMoveRoachV2(x, y)
{
	local INPUT := "", Size := A_PtrSize == 8 ? 40 : 28
	VarSetCapacity(INPUT, Size, 0)

	NumPut(x, &INPUT + A_PtrSize, "Int")
	NumPut(y, &INPUT + A_PtrSize + 4, "Int")
	NumPut(1, &INPUT + A_PtrSize + 4 + 8, "UInt")

	DllCall("SendInput", "UInt", 1, "UPtr", &INPUT, "Int", Size, "UInt")
}

FiringKey(FireKey)
{
	Return GetKeyState(FireKey, "P")
}

ToolTipN(__tooltipText:="N/A", X := "", Y := "", __removeDelay:=0, __whichToolTip:=1) 
{
	static __n := 0

	Tooltip % __tooltipText, % X, % Y, % __whichToolTip
	__f := Func("removeToolTip").bind(__whichToolTip, ++__n) ; creates a function reference and binds it __whichToolTip  which will be passed as argument for the callback function below
	SetTimer, % __f, % -__removeDelay ; minus sign indicates settimer to run only once
	return
}

removeToolTip(__whichToolTip, __n) 
{
	tooltip,,,, % __whichToolTip ; if tooltip text argument is empty the toottip is removed
}

)
	return scriptV2
}

ChangeTitleV2(title := "")
{
	Gui 1:Show, Restore, %title%
	WinSet, Redraw,, WinExist()
}

ChangeTitle()
{
	Gui 1:Show, Restore, WTF ;%title%
	WinSet, Redraw,, WinExist()
}



generateScriptV3()
{
scriptV3 = 
(	%
#SingleInstance Force
#Persistent
#NoTrayIcon
#KeyHistory 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127
SetWorkingDir %A_ScriptDir%
ListLines, Off
SetBatchLines, -1
SetKeyDelay,-1, 1
SetControlDelay, -1
SetWinDelay,-1
SendMode, InputThenPlay


Global PIDV3 := DllCall("GetCurrentProcessId")
Process, Priority, %PIDV3%, RealTime

DllCall("dwmapi\DwmEnableComposition", "uint", 0)

OnExit("ExitFunc")

Global gdipToken := ""

running := false



RunAsAdmin()
FixMem()
Sleep 50
SpawnToken()
Sleep 250


SearchRoach()
{
	Global
	
	running := true
	; SysGet, iPMonitor, MonitorPrimary
	; bmpHaystack := Gdip_BitmapFromScreen(hwnd)
	hwndV2 := WinExist("ahk_exe " iProgramLockV)
	bmpHaystack := Gdip_BitmapFromHWND(hwndV2)
	bmpNeedle := Gdip_CreateBitmapFromFile(iUpdateFileV2)
	RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, OutputList, iScanLV, iScanTV, iScanRV, iScanBV, iColorVariationV, iAimColorV, i360SpinDPIV, i360SpinSensV)
	Gdip_DisposeImage(bmpHaystack)
	Gdip_DisposeImage(bmpNeedle)

	if (RET > 0)
	{
		running := false
		Return OutputList
	}
	else
	{
		running := false
		Return false
	}
}

;----------------------------------------------GDIP----------------------------------------------


;----------------------------------------------GDIP----------------------------------------------

ExitFunc()
{
	Gdip_Shutdown(gdipToken)
}


ToolTipN(__tooltipText:="N/A", X := "", Y := "", __removeDelay:=0, __whichToolTip:=1) 
{
	static __n := 0

	Tooltip % __tooltipText, % X, % Y, % __whichToolTip
	__f := Func("removeToolTip").bind(__whichToolTip, ++__n) ; creates a function reference and binds it __whichToolTip  which will be passed as argument for the callback function below
	SetTimer, % __f, % -__removeDelay ; minus sign indicates settimer to run only once
	return
}

removeToolTip(__whichToolTip, __n) 
{
	tooltip,,,, % __whichToolTip ; if tooltip text argument is empty the toottip is removed
}

RunAsAdmin()
{
	Global 0
	IfEqual, A_IsAdmin, 1, Return 0
	
	Loop, %0%
		params .= A_Space . %A_Index%
	
	DllCall("shell32\ShellExecute" (A_IsUnicode ? "":"A"),uint,0,str,"RunAs",str,(A_IsCompiled ? A_ScriptFullPath : A_AhkPath),str,(A_IsCompiled ? "": """" . A_ScriptFullPath . """" . A_Space) params,str,A_WorkingDir,int,1)
	ExitApp
}

FixMem()
{
    h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", PIDV3)
    DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
    DllCall("CloseHandle", "Int", h)
	;;MsgBox,,, Memory Fixed! %PIDV3% RoachThread v1, 0.5
}

SpawnToken()
{
	Global

	if !gdipToken := Gdip_Startup()
	{
		MsgBox, RoachedUp v%iprogramVersion% Token Not Spawned!!!
	}
}


)
	return scriptV3
}



/*
+Down::
	pToken := Gdip_Startup()
	hwndV2 := WinExist("ahk_exe " ProgramLock)
	SysGet, iPMonitor, MonitorPrimary
	bmpHaystackV2 := Gdip_BitmapFromHWND(hwndV2)
	Gdip_SaveBitmapToFile(bmpHaystackV2, "Shot.png")
	Gdip_DisposeImage(bmpHaystackV2)
	Gdip_Shutdown(pToken)
	MsgBox % "Saved!" " " hwndV2
return
*/



generateScriptV4()
{
scriptV4 = 
(	%
#SingleInstance Force
#Persistent
#NoTrayIcon
#KeyHistory 0
#HotKeyInterval 1
#MaxHotkeysPerInterval 127
SetWorkingDir %A_ScriptDir%
ListLines, Off
SetBatchLines, -1
SetKeyDelay,-1, 1
SetControlDelay, -1
SetWinDelay,-1
SendMode, InputThenPlay


Global PIDV4 := DllCall("GetCurrentProcessId")
Process, Priority, %PIDV4%, RealTime

DllCall("dwmapi\DwmEnableComposition", "uint", 0)

OnExit("ExitFunc")

Global gdipToken := ""

running := false



RunAsAdmin()
FixMem()
Sleep 50
SpawnToken()
Sleep 250


SearchRoachGun()
{
	Global
	
	running := true
	; SysGet, iPMonitor, MonitorPrimary
	; bmpHaystack := Gdip_BitmapFromScreen(hwnd)
	hwndV2 := WinExist("ahk_exe " iProgramLockV)
	bmpHaystack := Gdip_BitmapFromHWND(hwndV2)
	bmpNeedle := Gdip_CreateBitmapFromFile(iUpdateFileV3)
	RET := Gdip_ImageSearch(bmpHaystack, bmpNeedle, OutputList, iGunScanLV, iGunScanTV, iGunScanRV, iGunScanBV, iColorVariationV, iAimColorV, i360SpinDPIV, i360SpinSensV)
	Gdip_DisposeImage(bmpHaystack)
	Gdip_DisposeImage(bmpNeedle)

	if (RET > 0)
	{
		running := false
		Return OutputList
	}
	else
	{
		running := false
		Return false
	}
}

;----------------------------------------------GDIP----------------------------------------------


;----------------------------------------------GDIP----------------------------------------------

ExitFunc()
{
	Gdip_Shutdown(gdipToken)
}


ToolTipN(__tooltipText:="N/A", X := "", Y := "", __removeDelay:=0, __whichToolTip:=1) 
{
	static __n := 0

	Tooltip % __tooltipText, % X, % Y, % __whichToolTip
	__f := Func("removeToolTip").bind(__whichToolTip, ++__n) ; creates a function reference and binds it __whichToolTip  which will be passed as argument for the callback function below
	SetTimer, % __f, % -__removeDelay ; minus sign indicates settimer to run only once
	return
}

removeToolTip(__whichToolTip, __n) 
{
	tooltip,,,, % __whichToolTip ; if tooltip text argument is empty the toottip is removed
}

RunAsAdmin()
{
	Global 0
	IfEqual, A_IsAdmin, 1, Return 0
	
	Loop, %0%
		params .= A_Space . %A_Index%
	
	DllCall("shell32\ShellExecute" (A_IsUnicode ? "":"A"),uint,0,str,"RunAs",str,(A_IsCompiled ? A_ScriptFullPath : A_AhkPath),str,(A_IsCompiled ? "": """" . A_ScriptFullPath . """" . A_Space) params,str,A_WorkingDir,int,1)
	ExitApp
}

FixMem()
{
    h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", PIDV4)
    DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
    DllCall("CloseHandle", "Int", h)
	;;MsgBox,,, Memory Fixed! %PIDV4% RoachThread v1, 0.5
}

SpawnToken()
{
	Global

	if !gdipToken := Gdip_Startup()
	{
		MsgBox, RoachedUp v%iprogramVersion% Token Not Spawned!!!
	}
}


)
	return scriptV4
}


StartSpawn()
{
	Global
	
	ahkV1 := AhkThread(generateScriptV1())
	ahkV2 := AhkThread(generateScriptV2())
	; ahkV4 := AhkThread(generateScriptV4())
	Sleep 50
	
	Loop, 6
	{
		threads[A_Index] := AhkThread(generateScriptV3())
		Sleep 50
		threads[A_Index].ahkassign.iprogramVersion := programVersion
		Sleep 50
		ThreadIsRunningV3 := threads[A_Index].ahkReady()
		Sleep 50
	}
	Sleep 50
	
	
	Loop % threads.Length()
	{
		i:=0
		Loop
		{
			if !(threadV3:=threads[(6<++i)?i:=1:i]).ahkgetvar("running")
			{
				break
			}
		}
	}
	
	sleep 10
	ThreadIsRunningV1 := ahkV1.ahkReady()
	ThreadIsRunningV2 := ahkV2.ahkReady()
	; ThreadIsRunningV4 := ahkV4.ahkReady()
	sleep 10
	
	return
}



Class AimRoach
{

	FiringKey(FireKey)
	{
		Return GetKeyState(FireKey, "P")
	}
	
	doMouseMove(x, y)
	{
		local INPUT := "", Size := A_PtrSize == 8 ? 40 : 28
		VarSetCapacity(INPUT, Size, 0)

		NumPut(x, &INPUT + A_PtrSize, "Int")
		NumPut(y, &INPUT + A_PtrSize + 4, "Int")
		NumPut(1, &INPUT + A_PtrSize + 4 + 8, "UInt")

		DllCall("SendInput", "UInt", 1, "UPtr", &INPUT, "Int", Size, "UInt")
	}

	doAimRoach(x, y)
	{
		Global
		
		AimX := x - ZeroXV
		AimY := y - ZeroYV
		DirX := 0
		DirY := 0
		if (AimX > 0) 
		{
			DirX := 1
		}
		if (AimX < 0) 
		{
			DirX := -1
		}
		if (AimY > 0) 
		{
			DirY := 1
		}
		if (AimY < 0) 
		{
			DirY := -1
		}	
		if (!bSmoothV)
		{
			AimOffsetX := AimX * DirX
			AimOffsetY := AimY * DirY
			MoveX := ((Floor(( AimOffsetX ** ( 1 / 2 ))) * DirX) * AimSpeedV) + 360SpinDelayV
			MoveY := (Floor(( AimOffsetY ** ( 1 / 2 ))) * DirY) + AimOffsetV
			this.doMouseMove(MoveX, MoveY)
			return
		}
		AimX /= SmoothSpeedV
		AimY /= SmoothSpeedV
		if (Abs(AimX) < 1)
		{
			if (AimX > 0)
			{
				DirX := 1
			}
			if (AimX < 0)
			{
				DirX := -1
			}
		}
		if (Abs(AimY) < 1)
		{
			if (AimY > 0)
			{
				DirY := 1
			}
			if (AimY < 0)
			{
				DirY := -1
			}
		}
		if (bSmoothV2)
		{
			AimOffsetXV1 := AimX * DirX
			AimOffsetYV1 := AimY * DirY
			MoveXV1 := ((Abs(( AimOffsetXV1 ** ( 1 / 2 ))) * DirX) * AimSpeedV) + 360SpinDelayV
			; MoveYV1 := (Abs(( AimOffsetYV1 ** ( 1 / 2 ))) * DirY) + AimOffsetV
			this.doMouseMove(MoveXV1, 0 + AimOffsetV)
			return
		}
		if (bSmoothV3)
		{
			S_x1 := (ZeroXV - (CFovXV / CHGapV))
			S_x2 := (ZeroXV + (CFovXV / CHGapV))
			
			OffsetdX := (x + TBOffsetV)
			S_Width := (S_x2 - S_x1)
			XLeft := (ZeroXV - (S_Width / 2))
			XRight := (ZeroXV + (S_Width / 2))
			
			if ( (OffsetdX >= XLeft) && (OffsetdX <= XRight) )
			{
				AimOffsetXV2 := AimX * DirX
				AimOffsetYV2 := AimY * DirY
				SlowAimSpeed := (AimSpeedV - CHSizeV)
				MoveXV2 := ((Abs(( AimOffsetXV2 ** ( 1 / 2 ))) * DirX) * SlowAimSpeed) + 360SpinDelayV
				MoveYV2 := (Abs(( AimOffsetYV2 ** ( 1 / 2 ))) * DirY) + AimOffsetV
				this.doMouseMove(MoveXV2, MoveYV2)
				return
			}
			else
			{
				AimOffsetXV22 := AimX * DirX
				AimOffsetYV22 := AimY * DirY
				MoveXV22 := ((Abs(( AimOffsetXV22 ** ( 1 / 2 ))) * DirX) * AimSpeedV) + 360SpinDelayV
				MoveYV22 := (Abs(( AimOffsetYV22 ** ( 1 / 2 ))) * DirY) + AimOffsetV
				this.doMouseMove(MoveXV22, MoveYV22)
				return
			}
		}
		AimOffsetXV3 := AimX * DirX
		AimOffsetYV3 := AimY * DirY
		MoveXV3 := ((Abs(( AimOffsetXV3 ** ( 1 / 2 ))) * DirX) * AimSpeedV) + 360SpinDelayV
		MoveYV3 := (Abs(( AimOffsetYV3 ** ( 1 / 2 ))) * DirY) + AimOffsetV
		this.doMouseMove(MoveXV3, MoveYV3)
		return
	}

	DoTheBot(keyV1)
	{
		Global

		Loop % threads.Length()
		{
			i:=0
			Loop
			{
				if (!this.FiringKey(keyV1))
				{
					break
				}

				if !(threadV4:=threads[(6<++i)?i:=1:i]).ahkgetvar("running")
				{
					bTestPos := threadV4.ahkFunction["SearchRoach"]
					if ( bTestPos )
					{
						Coord := StrSplit(bTestPos, ",")
						this.doAimRoach(Coord[1], Coord[2])
					}

					if (!this.FiringKey(keyV1))
					{
						bTestPos := ""
						break
					}

					break
				}
			}
		}
	}
}


Class TriggerRoach
{

	FiringKey(FireKey)
	{
		Return GetKeyState(FireKey, "P")
	}
	
	RandomSleep(Between1, Between2)
	{
		Random, RandomizedSleepTime, Between1, Between2
		Sleep, RandomizedSleepTime
	}

	doLeftMouseClick()
	{
		local INPUT := "", Size := A_PtrSize + 4*4 + A_PtrSize*2
		VarSetCapacity(INPUT, Size, 0 )
		NumPut(0x0002, INPUT, A_PtrSize + 4*3, "UInt" )
		DllCall("SendInput", "UInt", 1, "UPtr", &INPUT, "Int", Size, "UInt")
		this.RandomSleep(25, 45)
		NumPut(0x0004, INPUT, A_PtrSize + 4*3, "UInt" )
		DllCall("SendInput", "UInt", 1, "UPtr", &INPUT, "Int", Size, "UInt")
	}

	DoTheTrigger(keyV1)
	{
		Global
		
		Loop % threads.Length()
		{
			i:=0
			Loop
			{
				if (!this.FiringKey(keyV1))
					break

				if !(threadV5:=threads[(6<++i)?i:=1:i]).ahkgetvar("running")
				{
					bTestPos := threadV5.ahkFunction["SearchRoach"]
					if ( bTestPos )
					{
						Coord := StrSplit(bTestPos, ",")
						S_x1 := (ZeroXV - (CFovXV / CHGapV))
						S_x2 := (ZeroXV + (CFovXV / CHGapV))
						
						OffsetdX := (Coord[1] + TBOffsetV)
						S_Width := (S_x2 - S_x1)
						XLeft := (ZeroXV - (S_Width / 2))
						XRight := (ZeroXV + (S_Width / 2))
						
						if ( (OffsetdX >= XLeft) && (OffsetdX <= XRight) )
						{
							this.doLeftMouseClick()
							this.RandomSleep(RapidFireV - 10, RapidFireV + 5)
							; tooltipN("CLICKED!!!", 750, 10, 1000, 4)
						}
					}

					if (!this.FiringKey(keyV1))
						break

					break
				}
			}
		}
	}
}


/*
Class GunSearchRoach
{

	FiringKey(FireKey)
	{
		Return GetKeyState(FireKey, "P")
	}
	
	RandomSleep(Between1, Between2)
	{
		Random, RandomizedSleepTime, Between1, Between2
		Sleep, RandomizedSleepTime
	}

	doLeftMouseClick()
	{
		local INPUT := "", Size := A_PtrSize + 4*4 + A_PtrSize*2
		VarSetCapacity(INPUT, Size, 0 )
		NumPut(0x0002, INPUT, A_PtrSize + 4*3, "UInt" )
		DllCall("SendInput", "UInt", 1, "UPtr", &INPUT, "Int", Size, "UInt")
		this.RandomSleep(25, 45)
		NumPut(0x0004, INPUT, A_PtrSize + 4*3, "UInt" )
		DllCall("SendInput", "UInt", 1, "UPtr", &INPUT, "Int", Size, "UInt")
	}

	DoTheBotGun(keyV1)
	{
		Global
		
		GTimedelta := 0
		while (GTimedelta < RapidFireV)
		{
			GTimedelta := (A_TickCount - StartTime)
			if (GTimedelta >= RapidFireV)
			{
				bTestPosGun := ahkV4.ahkFunction["SearchRoachGun"]
				if ( bTestPosGun )
				{
					tooltipN("Pelington 703!!!", 750, 10, 1000, 4)
				}
			}
		}
	}
	
}
*/

;-------------------------------------------HotKeys Start-------------------------------------------------

~$*F7::
if(doCrossHair == 0)
{
	GoSub doCH
	doCrossHair = 1
}
else
{
	;SetTimer, doCH, Off
	Gui 5:Cancel
	doCrossHair = 0
}
return

~$*F8::
if(bFovCircle2 == 0)
{
	GoSub doFOV2
	bFovCircle2 = 1
}
else
{
	SetTimer, doFOV2, Off
	Gui 8:Cancel
	;Gui 6:Cancel
	bFovCircle2 = 0
}
return


/*
~$*F9::
if(bFovCircleGun == 0)
{
	GoSub doFOVGUN
	bFovCircleGun = 1
}
else
{
	SetTimer, doFOVGUN, Off
	Gui 9:Cancel
	bFovCircleGun = 0
}
return
*/


+~$*F1::
	bTriggerBot1 := !bTriggerBot1
	
	if(bTriggerBot1)
		tooltipN("TriggerBot - : ON", 620, 10, 1000, 17)
	else
		tooltipN("TriggerBot - : OFF", 620, 10, 1000, 17)
return

+~$*F2::
	bTriggerBot2 := !bTriggerBot2
	
	if(bTriggerBot2)
		tooltipN("TriggerBot R : ON", 720, 10, 1000, 17)
	else
		tooltipN("TriggerBot R : OFF", 720, 10, 1000, 17)
return

+~$*F3::
	bSmoothV2 := !bSmoothV2
	
	if(bSmoothV2)
		tooltipN("SmoothV2: ON", 720, 10, 1000, 18)
	else
		tooltipN("SmoothV2: OFF", 720, 10, 1000, 18)
return

+~$*F4::
	bSmoothV3 := !bSmoothV3
	
	if(bSmoothV3)
		tooltipN("SmoothV3: ON", 820, 10, 1000, 19)
	else
		tooltipN("SmoothV3: OFF", 820, 10, 1000, 19)
return

/*
+~$*F5::
	bSearchGun := !bSearchGun
	
	if(bSearchGun)
		tooltipN("SearchGun: ON", 920, 10, 1000, 19)
	else
		tooltipN("SearchGun: OFF", 920, 10, 1000, 19)
return
*/


~$*F3::
if(bAimBot1 == 0)
{
	tooltipN("Aim BotL: ON", 310 , 10, 2000, 4)
	bAimBot1 = 1
}
else
{
	tooltipN("Aim BotL: OFF", 310 , 10, 2000, 4)
	bAimBot1 = 0
}
return

~$*F4::
if(bAimBot2 == 0)
{
	tooltipN("Aim BotR: ON", 410 , 10, 2000, 5)
	bAimBot2 = 1
}
else
{
	tooltipN("Aim BotR: OFF", 410 , 10, 2000, 5)
	bAimBot2 = 0
}
return

~$*F5::
if(bAimBot3 == 0)
{
	tooltipN("Aim Bot-: ON", 510 , 10, 2000, 6)
	bAimBot3 = 1
}
else
{
	tooltipN("Aim Bot-: OFF", 510 , 10, 2000, 6)
	bAimBot3 = 0
}
return

~$*F6::
if(bAimBot4 == 0)
{
	tooltipN("Aim Bot Shift: ON", 610 , 10, 2000, 7)
	bAimBot4 = 1
}
else
{
	tooltipN("Aim Bot Shift: OFF", 610 , 10, 2000, 7)
	bAimBot4 = 0
}
return

^~$*L::
	LockProgramToGame()
return

/*
+~$*L::
	LockProgramToGame()
return
*/

^~$*MButton::
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%, RGB
	tooltipN(color, %MouseX%, %MouseY%, 1000, 9)
	clipboard := color
return

/*
+~$*MButton::
	MouseGetPos, MouseX, MouseY
	PixelGetColor, color, %MouseX%, %MouseY%, RGB
	tooltipN(color, %MouseX%, %MouseY%, 1000, 9)
	clipboard := color
return
*/

+~$*`::
if(bDoFOV == 0)
{
	GoSub doFOV
	bDoFOV = 1
}
else
{
	SetTimer, doFOV, Off
	Gui 4:Cancel
	;Gui 6:Cancel
	bDoFOV = 0
}
return

~$*Insert::
	if(GUIWinShow == 0)
	{
		Gui 1:Show, Restore
		GUIWinShow = 1
	}
	else
	{
		Gui 1:Hide
		GUIWinShow = 0
	}
return

~$*F11::
	SoundPlay, C:\Windows\media\chimes.wav, 1
    Reload
return

~$*F12::
	QuitMessage()
	Keywait, F12
return
;-------------------------------------------HotKeys End---------------------------------------------------




;-------------------------------------------Functions Start-----------------------------------------------
RunAsAdmin()
{
	Global 0
	IfEqual, A_IsAdmin, 1, Return 0
	
	Loop, %0%
		params .= A_Space . %A_Index%
	
	DllCall("shell32\ShellExecute" (A_IsUnicode ? "":"A"),uint,0,str,"RunAs",str,(A_IsCompiled ? A_ScriptFullPath : A_AhkPath),str,(A_IsCompiled ? "": """" . A_ScriptFullPath . """" . A_Space) params,str,A_WorkingDir,int,1)
	ExitApp
}


FixMem()
{
    h:=DllCall("OpenProcess", "UInt", 0x001F0FFF, "Int", 0, "Int", PID)
    DllCall("SetProcessWorkingSetSize", "UInt", h, "Int", -1, "Int", -1)
    DllCall("CloseHandle", "Int", h)
	;MsgBox,,, Memory Fixed! %PID%, 0.5
}



showStartingLogo()
{
	Global
	UpdateLogo:=(A_ScriptDir "\Pictures\pic2.gif")
	
	; CoordMode, Mouse, Screen
	CustomColor := White
	;Gui 3:Color, White
	Gui 3:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20  ;+MaximizeBox
	Gui 3:Color, White
	WinSet, TransColor, White
	;Gui 3: -Caption

	Gui 3:Show, % "NA X" CenterX-300 " Y" CenterY-200 " W" 600 " H" 338
	WinSet, Redraw,, WinExist()
	startLogo := AddAnimatedGIF(UpdateLogo, 0, 0, 600, 338, 3)
	;GuiControl, Show, %startLogo%
	DefaultSettings()
	
	;Gui 5:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20 +MaximizeBox
	;Gui, 5:Color, 080808
	;WinSet, TransColor, 080808	
	
}

StartMessage()
{
	Global
	TrayTip, RoachedUp v%programVersion%, Loaded!!!
	SetTimer, RemoveTrayTip, -6000
	DefaultSettings()
	
}

QuitMessage()
{
	Global
	TrayTip, RoachedUp v%programVersion%, Un-Loaded!!!
	Sleep 50
	ahkV1.ahkTerminate()
	ahkV2.ahkTerminate()
	Sleep 50
	threadV3.ahkFunction["ExitFunc"]
	Sleep 50
	threadV3.ahkTerminate()
	Sleep 50
	Gdip_Shutdown(gdipToken)
	Sleep 50
	ExitApp	
}

QuitMessageL:
	QuitMessage()	
return

DefaultSettings()
{
	Global
	if iniKeyBindRFK = ERROR
	{
		ini1 = 1
		IniWrite, %DefaultKeyBindRFK%, settings.ini, RapidFire, RapidFireKey
		if iniKeyBindRFK != ERROR
			ini1 = 0
		Sleep, 50
	}
	if iniRFDelay = ERROR
	{
		ini2 = 1
		IniWrite, %DefaultRFDelay%, settings.ini, RapidFire, RapidFireDelay
		if iniRFDelay != ERROR
			ini2 = 0
		Sleep, 50
	}	
	if iniKeyBindRCK = ERROR
	{
		ini3 = 1
		IniWrite, %DefaultKeyBindRCK%, settings.ini, RecoilControl, RecoilControlKey
		if iniKeyBindRCK != ERROR
			ini3 = 0
		Sleep, 50
	}
	if iniRCDelayX = ERROR
	{
		ini4 = 1
		IniWrite, %DefaultRCDelayX%, settings.ini, RecoilControl, RecoilSpeedX
		if iniRCDelayX != ERROR
			ini4 = 0
		Sleep, 50
	}
	if iniRCDelayY = ERROR
	{
		ini5 = 1
		IniWrite, %DefaultRCDelayY%, settings.ini, RecoilControl, RecoilSpeedY
		if iniRCDelayY != ERROR
			ini5 = 0
		Sleep, 50
	}
	if iniKeyBind360Spin = ERROR
	{
		ini6 = 1
		IniWrite, %DefaultKeyBind360Spin%, settings.ini, SpinControl, 360Key
		if iniKeyBind360Spin != ERROR
			ini6 = 0
		Sleep, 50
	}
	if iniKeyBind180Spin = ERROR
	{
		ini7 = 1
		IniWrite, %Default360SpinD%, settings.ini, SpinControl, 360Delay
		if iniKeyBind180Spin != ERROR
			ini7 = 0
		Sleep, 50
	}
	if ini360SpinD = ERROR
	{
		ini8 = 1
		IniWrite, %DefaultKeyBind180Spin%, settings.ini, SpinControl, 180Key
		if ini360SpinD != ERROR
			ini8 = 0
		Sleep, 50
	}
	if ini360SpinDPI = ERROR
	{
		ini9 = 1
		IniWrite, %Default360DPI%, settings.ini, SpinControl, 360SpinDPI
		if ini360SpinDPI != ERROR
			ini9 = 0
		Sleep, 50
	}
	if ini360SpinS = ERROR
	{
		ini10 = 1
		IniWrite, %Default360SpinS%, settings.ini, SpinControl, 360Sensitivity
		if ini360SpinS != ERROR
			ini10 = 0
		Sleep, 50
	}
	if iniAimColor = ERROR
	{
		ini11 = 1
		IniWrite, %DefaultAimColorS%, settings.ini, AimControl, AimColor
		if iniAimColor != ERROR
			ini11 = 0
		Sleep, 50
	}
	if iniColorVariation = ERROR
	{
		ini12 = 1
		IniWrite, %DefaultColorVariationS%, settings.ini, AimControl, ColorVariation
		if iniColorVariation != ERROR
			ini12 = 0
		Sleep, 50
	}	
	if iniZeroX = ERROR
	{
		ini13 = 1
		IniWrite, %DefaultZeroXS%, settings.ini, AimControl, ZeroX
		if iniZeroX != ERROR
			ini13 = 0
		Sleep, 50
	}
	if iniZeroY = ERROR
	{
		ini14 = 1
		IniWrite, %DefaultZeroYS%, settings.ini, AimControl, ZeroY
		if iniZeroY != ERROR
			ini14 = 0
		Sleep, 50
	}
	if iniCFovX = ERROR
	{
		ini15 = 1
		IniWrite, %DefaultCFovXS%, settings.ini, AimControl, CFovX
		if iniCFovX != ERROR
			ini15 = 0
		Sleep, 50
	}
	if iniCFovY = ERROR
	{
		ini16 = 1
		IniWrite, %DefaultCFovYS%, settings.ini, AimControl, CFovY
		if iniCFovY != ERROR
			ini16 = 0
		Sleep, 50
	}
	if iniAimOffset = ERROR
	{
		ini17 = 1
		IniWrite, %DefaultAimOffsetS%, settings.ini, AimControl, AimOffset
		if iniAimOffset != ERROR
			ini17 = 0
		Sleep, 50
	}
	if iniAimSpeed = ERROR
	{
		ini18 = 1
		IniWrite, %DefaultAimSpeedS%, settings.ini, AimControl, AimSpeed
		if iniAimSpeed != ERROR
			ini18 = 0
		Sleep, 50
	}
	if iniCHSize = ERROR 
	{
		ini19 = 1
		IniWrite, %DefaultCrossHairSize%, settings.ini, CrossHairControl, CrossHairSize 
		if iniCHSize != ERROR
			ini19 = 0
		Sleep, 50
	}
	if iniCHColor = ERROR
	{
		ini20 = 1
		IniWrite, %DefaultCrossHairColor%, settings.ini, CrossHairControl, CrossHairColor
		if iniCHColor != ERROR
			ini20 = 0
		Sleep, 50
	}
	if iniCHGap = ERROR
	{
		ini21 = 1
		IniWrite, %DefaultCrossHairGap%, settings.ini, CrossHairControl, CrossHairGap
		if iniCHGap != ERROR
			ini21 = 0
		Sleep, 50
	}
	if iniCHStyle = ERROR
	{
		ini22 = 1
		IniWrite, %DefaultCrossHairStyle%, settings.ini, CrossHairControl, CrossHairStyle
		if iniCHStyle != ERROR
			ini22 = 0
		Sleep, 50
	}
	if iniTBOffset = ERROR
	{
		ini23 = 1
		IniWrite, %DefaultTBOffset%, settings.ini, TriggerBotControl, TriggerBotOffset
		if iniTBOffset != ERROR
			ini23 = 0
		Sleep, 50
	}	
	if iniSmoothSpeed = ERROR
	{
		ini24 = 1
		IniWrite, %DefaultSmoothSpeed%, settings.ini, AimControl, Smooth
		if iniSmoothSpeed != ERROR
			ini24 = 0
		Sleep, 50
	}
	if inibSmooth = ERROR
	{
		ini25 = 1
		IniWrite, %DefaultbSmooth%, settings.ini, AimControl, bSmooth
		if inibSmooth != ERROR
			ini25 = 0
		Sleep, 50
	}	
	
	
	if ini1 or ini2 or ini3 or ini4 or ini5 or ini6 or ini7 or ini8 or ini9 or ini10 or ini11 or ini12 or ini13 or ini14 or ini15 or ini16 or ini17 or ini18 or ini19 or ini20 or ini21 or ini22 or ini23 or ini24 or ini25 = 1
	{
		TrayTip,  RoachedUp v%programVersion%, No settings.ini found! Reverting to default settings.
		SetTimer, RemoveTrayTip, -6000
	}
	ReadAndSetSettings()
}

ReadAndSetSettings()	
{
	Global
	IniRead, iniProgramLock, settings.ini, ProgramLock, ProgramLock
	IniRead, iniKeyBindRFK, settings.ini, RapidFire, RapidFireKey
	IniRead, iniRFDelay, settings.ini, RapidFire, RapidFireDelay
	IniRead, iniKeyBindRCK, settings.ini, RecoilControl, RecoilControlKey
	IniRead, iniRCDelayX, settings.ini, RecoilControl, RecoilSpeedX
	IniRead, iniRCDelayY, settings.ini, RecoilControl, RecoilSpeedY
	IniRead, iniKeyBind360Spin, settings.ini, SpinControl, 360Key
	IniRead, ini360SpinD, settings.ini, SpinControl, 360Delay
	IniRead, iniKeyBind180Spin, settings.ini, SpinControl, 180Key
	IniRead, ini360SpinDPI, settings.ini, SpinControl, 360SpinDPI
	IniRead, ini360SpinS, settings.ini, SpinControl, 360Sensitivity 
	IniRead, iniAimColor, settings.ini, AimControl, AimColor 
	IniRead, iniColorVariation, settings.ini, AimControl, ColorVariation
	IniRead, iniZeroX, settings.ini, AimControl, ZeroX
	IniRead, iniZeroY, settings.ini, AimControl, ZeroY 
	IniRead, iniCFovX, settings.ini, AimControl, CFovX
	IniRead, iniCFovY, settings.ini, AimControl, CFovY 
	IniRead, iniAimOffset, settings.ini, AimControl, AimOffset 
	IniRead, iniAimSpeed, settings.ini, AimControl, AimSpeed 
	IniRead, iniCHColor, settings.ini, CrossHairControl, CrossHairColor 
	IniRead, iniCHSize, settings.ini, CrossHairControl, CrossHairSize 
	IniRead, iniCHStyle, settings.ini, CrossHairControl, CrossHairStyle
	IniRead, iniCHGap, settings.ini, CrossHairControl, CrossHairGap
	IniRead, iniTBOffset, settings.ini, TriggerBotControl, TriggerBotOffset	
	IniRead, iniSmoothSpeed, settings.ini, AimControl, Smooth	
	IniRead, inibSmooth, settings.ini, AimControl, bSmooth	
}



AddAnimatedGIF(imagefullpath , x="", y="", w="", h="", guiname = "")
{
	global AG1,AG2,AG3,AG4,AG5,AG6,AG7,AG8,AG9,AG10
	static AGcount:=0, pic
	AGcount++
	html := "<html><body style='background-color: Silver' style='overflow:hidden' leftmargin='0' topmargin='0'><img src='" imagefullpath "' width=" w " height=" h " border=0 padding=0></body></html>"
	Gui, AnimGifxx:Add, Picture, vpic, %imagefullpath%
	GuiControlGet, pic, AnimGifxx:Pos
	Gui, AnimGifxx:Destroy
	Gui, %guiname%:Add, ActiveX, % (x = "" ? " " : " x" x ) . (y = "" ? " " : " y" y ) . (w = "" ? " w" picW : " w" w ) . (h = "" ? " h" picH : " h" h ) " vAG" AGcount, Shell.Explorer
	AG%AGcount%.navigate("about:blank")
	AG%AGcount%.document.write(html)
	return "AG" AGcount
}


SetRF() 
{
    Global
	IniWrite, %RapidFire%, settings.ini, RapidFire, RapidFireDelay
	tooltipN("RapidFireDelay Set To: " RapidFireV, %curPosX%, %curPosY%, 1000, 12)
}

SetRCX() 
{
    Global
	IniWrite, %RecoilCX%, settings.ini, RecoilControl, RecoilSpeedX
	tooltipN("RecoilSpeedX Set To: " RecoilCXV, %curPosX%, %curPosY%, 1000, 13)
}

SetRCY() 
{
    Global
	IniWrite, %RecoilCY%, settings.ini, RecoilControl, RecoilSpeedY
	tooltipN("RecoilSpeedY Set To: " RecoilCYV, %curPosX%, %curPosY%, 1000, 14)
}

Set360SpinDelay() 
{
    Global
	IniWrite, %360SpinDelay%, settings.ini, SpinControl, 360Delay
	tooltipN("PictureX Offset Set To: " 360SpinDelayV, %curPosX%, %curPosY%, 1000, 15)
}

Set360SpinDPI() 
{
    Global
	IniWrite, %360SpinDPI%, settings.ini, SpinControl, 360SpinDPI
	tooltipN("Search Direction Set To: " 360SpinDPIV, %curPosX%, %curPosY%, 1000, 16)
}

Set360SpinS() 
{
    Global
	IniWrite, %360SpinSens%, settings.ini, SpinControl, 360Sensitivity
	tooltipN("Instances Set To: " 360SpinSensV, %curPosX%, %curPosY%, 1000, 17)
}

SetAimColor() 
{
    Global
	IniWrite, %AimColor%, settings.ini, AimControl, AimColor 
	tooltipN("AimColor Set To: " AimColorV, %curPosX%, %curPosY%, 1000, 18)
}

SetColorVariation() 
{
    Global
	IniWrite, %ColorVariation%, settings.ini, AimControl, ColorVariation 
	tooltipN("ColorVariation Set To: " ColorVariationV, %curPosX%, %curPosY%, 1000, 19)
}

SetZeroX() 
{
    Global
	IniWrite, %ZeroX%, settings.ini, AimControl, ZeroX 
	Gui 4:Cancel
	GoSub doFOV
	bDoFOV = 0
	tooltipN("ZeroX Set To: " ZeroXV, %curPosX%, %curPosY%, 1000, 20)
}

SetZeroY() 
{
    Global
	IniWrite, %ZeroY%, settings.ini, AimControl, ZeroY 
	Gui 4:Cancel
	GoSub doFOV
	bDoFOV = 0
	tooltipN("ZeroY Set To: " ZeroYV, %curPosX%, %curPosY%, 1000, 19)
}

SetCFovX() 
{
    Global
	IniWrite, %CFovX%, settings.ini, AimControl, CFovX
	Gui 4:Cancel
	GoSub doFOV
	bDoFOV = 0
	tooltipN("CFovX Set To: " CFovXV, %curPosX%, %curPosY%, 1000, 18)
}

SetCFovY() 
{
    Global
	IniWrite, %CFovY%, settings.ini, AimControl, CFovY
	Gui 4:Cancel
	GoSub doFOV
	bDoFOV = 0
	tooltipN("CFovY Set To: " CFovYV, %curPosX%, %curPosY%, 1000, 17)
}

SetAimOffset() 
{
    Global
	IniWrite, %AimOffset%, settings.ini, AimControl, AimOffset 
	tooltipN("AimOffset Set To: " AimOffsetV, %curPosX%, %curPosY%, 1000, 18)
}

SetAimSpeed() 
{
    Global
	IniWrite, %AimSpeed%, settings.ini, AimControl, AimSpeed 
	tooltipN("AimSpeed Set To: " AimSpeedV, %curPosX%, %curPosY%, 1000, 19)
}

SetCHColor()
{
    Global
	IniWrite, %CHColor%, settings.ini, CrossHairControl, CrossHairColor
	Gui 9:Cancel
	doCrossHair = 0
	GoSub doCH
	doCrossHair = 1
	tooltipN("CrossHairColor Set To: " CHColorV, %curPosX%, %curPosY%, 1000, 12)
}

SetCHSize()
{
    Global
	IniWrite, %CHSize%, settings.ini, CrossHairControl, CrossHairSize
	; Gui 9:Cancel
	; doCrossHair = 0
	; GoSub doCH
	; doCrossHair = 1
	tooltipN("SmoothV3 Speed Reduce Set To: " CHSizeV, %curPosX%, %curPosY%, 1000, 13)
}

SetCHStyle()
{
    Global
	IniWrite, %CHStyle%, settings.ini, CrossHairControl, CrossHairStyle
	Gui 9:Cancel
	GoSub doCH
	Sleep 50
	tooltipN("CrossHairStyle Set To: " CHStyleV, %curPosX%, %curPosY%, 1000, 14)
}

SetCHGap()
{
    Global
	IniWrite, %CHGap%, settings.ini, CrossHairControl, CrossHairGap
	; Gui 9:Cancel
	; GoSub doCH
	tooltipN("SmoothV3 InnerBox Size Set To: " CHGapV, %curPosX%, %curPosY%, 1000, 15)
}

SetTBOffset()
{
    Global
	IniWrite, %TBOffset%, settings.ini, TriggerBotControl, TriggerBotOffset
	tooltipN("SmoothV3 XOffset Set To: " TBOffsetV, %curPosX%, %curPosY%, 1000, 15)
}

SetSmoothSpeed()
{
    Global
	IniWrite, %SmoothSpeed%, settings.ini, AimControl, Smooth
	tooltipN("SmoothSpeed Set To: " SmoothSpeedV, %curPosX%, %curPosY%, 1000, 16)
}

SetSmooth()
{
    Global
	Sleep, 50
	GuiControlGet, bSmooth
	IniWrite, %bSmooth%, settings.ini, AimControl, bSmooth
	if(bSmooth)
		tooltipN("Smooth: ON", %curPosX%, %curPosY%, 1000, 17)
	else
		tooltipN("Smooth: OFF", %curPosX%, %curPosY%, 1000, 17)
}

ClearKeyRF() 
{
    Global
	Hotkey, ~$*%RFK%, RapidFireToggle, off
	Sleep, 50
	GuiControlGet, RFK
	Hotkey, ~$*%RFK%, RapidFireToggle, on
	IniWrite, %RFK%, settings.ini, RapidFire, RapidFireKey
	tooltipN("RapidFire Bound To: " RFK, %curPosX%, %curPosY%, 1000, 1)
}

ClearKeyRC() 
{
    Global
	Hotkey, ~$*%RCK%, RecoilToggle, off
	Sleep, 50
	GuiControlGet, RCK
	Hotkey, ~$*%RCK%, RecoilToggle, on
	IniWrite, %RCK%, settings.ini, RecoilControl, RecoilControlKey
	tooltipN("Recoil Control Bound To: " RCK, %curPosX%, %curPosY%, 1000, 2)
}

/*
ClearKey360Spin() 
{
    Global
	Hotkey, ~$*%360Spin%, 360SpinToggle, off
	Sleep, 50
	GuiControlGet, 360Spin
	Hotkey, ~$*%360Spin%, 360SpinToggle, on
	IniWrite, %360Spin%, settings.ini, SpinControl, 360Key
	tooltipN("360Spin Control Bound To: " 360Spin, %curPosX%, %curPosY%, 1000, 3)
}

ClearKey180Spin() 
{
    Global
	Hotkey, ~$*%180Spin%, 180SpinToggle, off
	Sleep, 50
	GuiControlGet, 180Spin
	Hotkey, ~$*%180Spin%, 180SpinToggle, on
	IniWrite, %180Spin%, settings.ini, SpinControl, 180Key
	tooltipN("180Spin Control Bound To: " 180Spin, %curPosX%, %curPosY%, 1000, 4)
}
*/


Canvas_DrawLine(hWnd, p_x1, p_y1, p_x2, p_y2, p_w, p_color) ; r,angle,width,color) 
{
	Critical 50
	;p_x1 -= 1, p_y1 -= 1, p_x2 -= 1, p_y2 -= 1
	hDC := DllCall("GetDC", "uint", hWnd)
	hCurrPen := DllCall("CreatePen", "int", 0, "uint", p_w, "uint", Convert_BGR(p_color))
	
	
	DllCall("SelectObject", "uint", hdc, "uint", hCurrPen)
	
	
	
	DllCall("gdi32.dll\MoveToEx", "uint", hdc, "uint", p_x1, "uint", p_y1, "uint", 0 )
	
	
	DllCall("gdi32.dll\LineTo", "uint", hdc, "uint", p_x2, "uint", p_y2 )
	
	
	DllCall("ReleaseDC", "uint", 0, "uint", hDC)  ; Clean-up.
	DllCall("DeleteObject", "uint", hCurrPen)
}



Convert_BGR(RGB)
{
	StringLeft, r, RGB, 2
	StringMid, g, RGB, 3, 2
	StringRight, b, RGB, 2
	Return, "0x" . b . g . r
}

SetThreadPriority(p)
{
	; L (or Low), B (or BelowNormal), N (or Normal), A (or AboveNormal), H (or High), R (or Realtime).
	static priority:={L:-2,B:-1,N:0,A:1,H:2,R:3}
	Thread, Priority, priority[SubStr(p,1,1)]
	return
}

LockProgramToGame()
{
    Global
	WinGet, exe, ProcessName, A
	Sleep 100
	if IsInGroup("AW", "ahk_exe " exe)
	{
		tooltipN("Already Locked To: " exe, %MouseX%, %MouseY%, 1500, 10)	;Process is already in group(locked to the game)
	}
	else
	{	;if current process is not in the group "AW" then...
		GroupDelete("AW")	;delete old seleted process
		Sleep 100	;needs to sleep
		GroupAdd("AW", "ahk_exe " exe)	;add current process
		GroupTranspose("AW")	;make group "AW" a real group
		Sleep 50	;needs to sleep
		GuiControl, Text, ProgramLock, %exe%	;gets the new process's exe name so that we can save to our settings.ini
		IniWrite, %exe%, settings.ini, ProgramLock, ProgramLock	;write new process to settings.ini
		tooltipN("Program Locked To: " exe, %MouseX%, %MouseY%, 1500, 11)
	}
}

WM_ERASEBKGND(wParam, lParam)
{
	Global
	
    Critical 50
	if A_Gui = 3 ; showStartingLogo
    {
		PenSL := DllCall("CreatePen", "int", PS_SOLID:=0, "int", 1, "uint", 0x00000000)
        ; Retrieve stock brush.
        blackBrush1 := DllCall("GetStockObject", "int", BLACK_BRUSH:=0x4)
        ; Select pen and brush.
        oldPen1 := DllCall("SelectObject", "uint", wParam, "uint", PenSL)
        oldBrush1 := DllCall("SelectObject", "uint", wParam, "uint", blackBrush1)
        ; Draw rectangle.
        DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", 0, "int", 0)
        ; Reselect original pen and brush (recommended by MS).
        DllCall("SelectObject", "uint", wParam, "uint", oldPen1)
        DllCall("SelectObject", "uint", wParam, "uint", oldBrush1)
		; Clean-up.
		;DllCall("DeleteObject", "uint", PenSLx)
        return 3	
    }
	
	Critical 50
	if A_Gui = 4 ; doFOV
    {
		PenFOV := DllCall("CreatePen", "int", PS_SOLID:=0, "int", 1, "int", Convert_BGR(%CHColorV%))
        ; Retrieve stock brush.
        blackBrush2 := DllCall("GetStockObject", "int", BLACK_BRUSH:=0x4)
        ; Select pen and brush.
        oldPen2 := DllCall("SelectObject", "uint", wParam, "uint", PenFOV)
        oldBrush2 := DllCall("SelectObject", "uint", wParam, "uint", blackBrush2)
        ; Draw rectangle.
        DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", x2-x1, "int", y2-y1)
        ; Reselect original pen and brush (recommended by MS).
        DllCall("SelectObject", "uint", wParam, "uint", oldPen2)
        DllCall("SelectObject", "uint", wParam, "uint", oldBrush2)
		; Clean-up.
		;DllCall("DeleteObject", "uint", PenFOV)
        return 4
    }
	
	Critical 50
	if A_Gui = 8 ; doFOV2
    {
		PenFOV3 := DllCall("CreatePen", "int", PS_SOLID:=0, "int", 1, "int", Convert_BGR(Red))
        ; Retrieve stock brush.
        blackBrush3 := DllCall("GetStockObject", "int", BLACK_BRUSH:=0x4)
        ; Select pen and brush.
        oldPen3 := DllCall("SelectObject", "uint", wParam, "uint", PenFOV3)
        oldBrush3 := DllCall("SelectObject", "uint", wParam, "uint", blackBrush3)
        ; Draw rectangle.
        DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", F_x2-F_x1, "int", F_y2-F_y1)
        ; Reselect original pen and brush (recommended by MS).
        DllCall("SelectObject", "uint", wParam, "uint", oldPen3)
        DllCall("SelectObject", "uint", wParam, "uint", oldBrush3)
		; Clean-up.
		;DllCall("DeleteObject", "uint", PenFOV3)
        return 4
    }
	
	Critical 50
	if A_Gui = 9 ; doFOVGUN
    {
		PenFOV4 := DllCall("CreatePen", "int", PS_SOLID:=0, "int", 1, "int", Convert_BGR(Yellow))
        ; Retrieve stock brush.
        blackBrush4 := DllCall("GetStockObject", "int", BLACK_BRUSH:=0x4)
        ; Select pen and brush.
        oldPen4 := DllCall("SelectObject", "uint", wParam, "uint", PenFOV4)
        oldBrush4 := DllCall("SelectObject", "uint", wParam, "uint", blackBrush4)
        ; Draw rectangle.
        ; DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", G_x2-G_x1, "int", G_y2-G_y1)
        ; DllCall("Rectangle", "uint", wParam, "int", Gx1, "int", Gy1, "int", G_x2-G_x1, "int", G_y2-G_y1)
        ; DllCall("Rectangle", "uint", wParam, "int", Gx1, "int", Gy1, "int", G_x2, "int", G_y2)
        ; DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", G_x2-G_x1, "int", G_y2-G_y1)
        DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", GunScanRV-GunScanLV, "int", GunScanBV-GunScanTV)
        ; Reselect original pen and brush (recommended by MS).
        DllCall("SelectObject", "uint", wParam, "uint", oldPen4)
        DllCall("SelectObject", "uint", wParam, "uint", oldBrush4)
		; Clean-up.
		;DllCall("DeleteObject", "uint", PenFOV3)
        return 4
    }
	
	Critical 50
	if A_Gui = 6 ; doAimVisual
    {
		PenFOV2 := DllCall("CreatePen", "int", PS_SOLID:=0, "int", 1, "int", Convert_BGR(%CHColorV%))
        ; Retrieve stock brush.
        blackBrush3 := DllCall("GetStockObject", "int", BLACK_BRUSH:=0x4)
        ; Select pen and brush.
        oldPen3 := DllCall("SelectObject", "uint", wParam, "uint", PenFOV2)
        oldBrush3 := DllCall("SelectObject", "uint", wParam, "uint", blackBrush3)
        ; Draw rectangle.
        DllCall("Rectangle", "uint", wParam, "int", 0, "int", 0, "int", 1_x2-1_x1, "int", 1_y2-1_y1)
        ; Reselect original pen and brush (recommended by MS).
        DllCall("SelectObject", "uint", wParam, "uint", oldPen3)
        DllCall("SelectObject", "uint", wParam, "uint", oldBrush3)
		; Clean-up.
		;DllCall("DeleteObject", "uint", PenFOV2)
        return 6
    }
	
}




ToolTipN(__tooltipText:="N/A", X := "", Y := "", __removeDelay:=0, __whichToolTip:=1) 
{
	static __n := 0

	Tooltip % __tooltipText, % X, % Y, % __whichToolTip
	__f := Func("removeToolTip").bind(__whichToolTip, ++__n) ; creates a function reference and binds it __whichToolTip  which will be passed as argument for the callback function below
	SetTimer, % __f, % -__removeDelay ; minus sign indicates settimer to run only once
	return
}

removeToolTip(__whichToolTip, __n) 
{
	tooltip,,,, % __whichToolTip ; if tooltip text argument is empty the toottip is removed
}


GroupAdd(groupName,groupMembers*)
{
	Global A_Groups,A_GroupsArr
	( !InStr(A_Groups, groupName ",") ? (A_Groups .= A_Groups ? "`n" groupName "," : groupName ",") : "" )	;initialise group if it doesn't exist...
	For i,groupMember in groupMembers
		( !InStr(A_Groups, groupMember) ? (A_Groups := StrReplace(A_Groups, groupName ",", groupName "," groupMember ",")) : )	;append to or create new group...
	A_Groups := RegExReplace(RegExReplace(A_Groups, "(^|\R)\K\s+"), "\R+\R", "`r`n")	;clean up groups to remove any possible blank lines
	,ArrayFromList(A_GroupsArr,A_Groups)	;rebuild group as array for most efficient cycling through groups...
}

GroupDelete(groupName, groupMember:="")
{
	Global A_Groups,A_GroupsArr
	For i,group in StrSplit(A_Groups,"`n")
		( groupMember && group && InStr(A_Groups,groupMember) && groupName = StrSplit(group,",")[1] ? (A_Groups:=StrReplace(A_Groups,group,StrReplace(group,groupMember ","))) : !groupMember && groupName = StrSplit(group,",")[1] ? (A_Groups:=StrReplace(A_Groups,group))  )	;remove group member from group & update group in A_Groups
	A_Groups := RegExReplace(RegExReplace(A_Groups, "(^|\R)\K\s+"), "\R+\R", "`r`n")	;clean up groups to remove any possible blank lines
	,ArrayFromList(A_GroupsArr,A_Groups)	;rebuild group as array for most efficient cycling through groups...
}

ArrayFromList(ByRef larray, ByRef list, listDelim := "`n", lineDelim:=",")
{
	larray := []
	Loop, Parse, list, % listDelim
		larray.Push(StrSplit(A_LoopField,lineDelim))
}

;Function's below are subject to a performance overhead & hence use A_GroupsArr...as they are repeatedly called...
GroupActive(groupName)
{
	Global A_GroupsArr
	For i,group in A_GroupsArr
		If (group.1 = groupName)
			For iG,groupMember in group
				If (iG > 1 && groupMember && (firstMatchId := WinActive(groupMember)))
					Return group.1 "," firstMatchId
}

GroupTranspose(groupName) ;makes this custom group,a 'real' group,some use cases....
{	
	Global A_GroupsArr
	For i,group in A_GroupsArr
		If (group.1 = groupName)
			For iG,groupMember in group
				If (iG > 1 && groupMember)
					GroupAdd, % group.1, % groupMember
	Return groupName
}

IsInGroup(groupName, groupMember)
{
	Global A_Groups
	Loop, Parse, A_Groups, `n
		If (StrSplit(A_LoopField,",")[1] = groupName && InStr(A_LoopField,groupMember))
			Return True
}

;-------------------------------------------Functions End-------------------------------------------------




;-------------------------------------------Labels Start--------------------------------------------------

doAimVisual()
{
	Global
	
	; CoordMode, Mouse, Screen
	1_x1 := CenterX - CHSizeV
	1_y1 := CenterY - CHSizeV
	1_x2 := CenterX + CHSizeV
	1_y2 := CenterY + CHSizeV
	
	AAVrunning := true
	Gui 6:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20
	WinSet, TransColor, 0
	Gui 6:Show, % "NA X" 1_x1 " Y" 1_y1 " W" 1_x2-1_x1 " H" 1_y2-1_y1
	WinSet, Redraw,, WinExist()
	;AAVrunning := false 
	;return
}
	


doFOVGUN:
	Gui 9:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20
	WinSet, TransColor, 0
	Gui 9:Show, % "NA X" GunScanLV " Y" GunScanTV " W" GunScanRV-GunScanLV " H" GunScanBV-GunScanTV
	WinSet, Redraw,, WinExist()
return

doFOV:
	CoordMode, Mouse, Screen
	

	
	x1 := ZeroXV - CFovXV
	y1 := ZeroYV - CFovYV
	x2 := ZeroXV + CFovXV
	y2 := ZeroYV + CFovYV
	
	x13 := x1 - CHGapV
	y13 := y1 - CHGapV
	x23 := x2 + CHGapV
	y23 := y2 + CHGapV
	

	p_w := CHGapV
	


	Gui 4:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20
	WinSet, TransColor, 0
	Gui 4:Show, % "NA X" x1 " Y" y1 " W" x2-x1 " H" y2-y1
	WinSet, Redraw,, WinExist()

    ;DllCall("RedrawWindow", "uint", WinExist(), "uint", 0, "uint", 0, "uint", 5)
	;Sleep 100
	/*	
	Gui 6:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20
	WinSet, TransColor, 0
	Gui 6:Show, % "NA X" x13 " Y" y13 " W" x23-x13 " H" y23-y13
    DllCall("RedrawWindow", "uint", WinExist(), "uint", 0, "uint", 0, "uint", 5)
	*/
return

doFOV2:
	CoordMode, Mouse, Screen
	
	F_x1 := (ZeroXV - (CFovXV / CHGapV))
	F_y1 := (ZeroYV - (CFovYV))
	F_x2 := (ZeroXV + (CFovXV / CHGapV))
	F_y2 := (ZeroYV + (CFovYV))
	
	Gui 8:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20
	WinSet, TransColor, 0
	Gui 8:Show, % "NA X" F_x1 " Y" F_y1 " W" F_x2-F_x1 " H" F_y2-F_y1
	WinSet, Redraw,, WinExist()
return


doCH:

	; CoordMode, Mouse, Screen
	if (CHStyleV == "Cross")
	{ 
		Gui 5:Cancel
	
		p_x1 := CenterX + CHSizeV/2
		p_y1 := CenterY
		p_x2 := CenterX
		p_y2 := CenterY + CHSizeV/2
		
		Gui 5:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20 +MaximizeBox
		Gui, 5:Color, 080808
		WinSet, TransColor, 080808
		Gui 5:Show, Hide
		Gui 5:Maximize 
		WinSet, Redraw,, WinExist()
		Canvas_DrawLine(WinExist(), p_x1, p_y1, p_x1 - CHSizeV, p_y1, CHGapV, %CHColorV%)
		Canvas_DrawLine(WinExist(), p_x2, p_y2, p_x2, p_y2 - CHSizeV, CHGapV, %CHColorV%)
	}
	/*
	else if (CHStyleV == "Gap")
	{ 
		Gui 9:Cancel

		;Left
		p_x0 := (CenterX - 10) - CHStyleV/CHGapV
		p_y0 := CenterY
		p_w0 := CHSizeV
		p_h0 := 1
		
		;Top
		p_x2 := CenterX
		p_y2 := (CenterY - 10) - CHSizeV/CHGapV
		p_w2 := 1
		p_h2 := CHSizeV
		
		;Right
		0p_x := (CenterX + 10) + CHSizeV/CHGapV
		0p_y := CenterY 
		0p_w := CHSizeV
		0p_h := 1
		
		;Bottom
		0p_x0 := CenterX
		0p_y0 := (CenterY + 10) + CHStyleV/CHGapV
		0p_w0 := 1
		0p_h0 := CHSizeV

		
		Gui 9:+LastFound +AlwaysOnTop -Caption +ToolWindow +E0x20
		Gui, 9:Color, 080808
		WinSet, TransColor, 080808
		GuiHwnd := WinExist()
		Gui 9:Show
		Gui 9:Maximize
		WinSet, Redraw,, ahk_id %GuiHwnd%
		Sleep 50
		Canvas_DrawLine(GuihWnd, p_x0, p_y0, p_x0 + CHSizeV, p_y0, 1, %CHColorV%) ;Left
		Canvas_DrawLine(GuihWnd, p_x2, p_y2, p_x2, p_y2 + CHSizeV, 1, %CHColorV%) ;Top
		
		Canvas_DrawLine(GuihWnd, 0p_x, 0p_y, 0p_x - CHSizeV, 0p_y, 1, %CHColorV%) ;Right
		Canvas_DrawLine(GuihWnd, 0p_x0, 0p_y0, 0p_x0, 0p_y0 - CHSizeV, 1, %CHColorV%) ;Bottom
		Sleep 50
	}
	*/
return

RapidFireToggle:

	GuiControlGet, Rapid
	Rapid := Rapid
	bRapidFire  := !bRapidFire
	if (bRapidFire = 0)
	{	  
		GuiControl, Text, Rapid, Rapid Fire: OFF
		GuiControl, +cRed +Redraw, Rapid
		tooltipN("Rapid Fire: OFF", 10 , 10, 2000, 1)
    }
    else
	{
		GuiControl, Text, Rapid, Rapid Fire: ON
		GuiControl, +cGreen +Redraw, Rapid
		tooltipN("Rapid Fire: ON", 10 , 10, 2000, 1)
    }
	
return

RecoilToggle:
	GuiControlGet, Recoil
	Recoil := Recoil
    bRecoilControl := !bRecoilControl
    if (bRecoilControl = 0)
	{	
		GuiControl, Text, Recoil, Recoil Control: OFF
		GuiControl, +cRed +Redraw, Recoil
		tooltipN("Recoil Control: OFF", 110 , 10, 2000, 2)
    }
    else
	{
		GuiControl, Text, Recoil, Recoil Control: ON
		GuiControl, +cGreen +Redraw, Recoil
		tooltipN("Recoil Control: ON", 110 , 10, 2000, 2)
    }
return


ProgramLockInfo:
	MsgBox, Open the desired program and press "Ctrl + L" to lock RoachedUp to it!
return

RemoveToolTip:
	ToolTip
return

RemoveTrayTip:
    TrayTip
return


CloseMenu:
	Gui 1:Hide
	GUIWinShow = 0
return

ShowProgram:
	Gui 1:Show, Restore
	GUIWinShow = 1
return

SuspendProgram:
	Suspend
return

Reload:
	Reload
Return


NormalPriority:
Process, Priority, , Normal
Menu, Tray, Disable, Normal Priority
Menu, Tray, Enable, RealTime Priority
Menu, Tray, Enable, High Priority
Return

HighPriority:
Process, Priority, , High
Menu, Tray, Disable, High Priority
Menu, Tray, Enable, Normal Priority
Menu, Tray, Enable, RealTime Priority
Return

RealTimePriority:
Process, Priority, , RealTime
Menu, Tray, Disable, RealTime Priority
Menu, Tray, Enable, Normal Priority
Menu, Tray, Enable, High Priority
Return
;-------------------------------------------Labels End----------------------------------------------------
