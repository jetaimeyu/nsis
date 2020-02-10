

!define PRODUCT_NAME "同步程序"
!define PRODUCT_VERSION "1.0.0.1"

SetCompressor lzma
SetFont "tahoma" 8
RequestExecutionLevel admin

!include "MUI2.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON "Icon\MD_Setup.ico"
!define MUI_UNICON "Icon\Uninstall.ico"

!insertmacro MUI_LANGUAGE "SimpChinese"

Name "${PRODUCT_NAME}_升级_${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}_升级_${PRODUCT_VERSION}.exe"
InstallDirRegKey HKCU "Software\autotask" ""

Section "升级文件" SEC01

  SetDetailsPrint textonly
  DetailPrint "正在升级 ${PRODUCT_NAME}，请单击关闭按钮完成升级！"
  SetDetailsPrint listonly

  SectionIn RO
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ;升级文件
  File "release\username.txt"
  File "release\*.*"

SectionEnd


Function un.onInit
	;判断是否已安装
	ReadRegStr $0 HKCU "Software\autotask" ""
	StrCmp $0 "" 0 NoAbort
	  MessageBox MB_OK|MB_ICONEXCLAMATION "您未正确安装autotask的软件，不能使用此升级程序！"
	  Abort ;退出安装程序
	NoAbort:


	;关闭进程
	Push $R0
	CheckProc:
	  Push "${PRODUCT_NAME}_升级_${PRODUCT_VERSION}.exe"
	  ProcessWork::existsprocess
	  Pop $R0
	  IntCmp $R0 0 Done
	  MessageBox MB_OKCANCEL|MB_ICONSTOP "升级程序检测到 ${PRODUCT_NAME} 正在运行。$\r$\n$\r$\n点击 “确定” 强制关闭${PRODUCT_NAME}，继续升级。$\r$\n点击 “取消” 退出安装程序。" IDCANCEL Exit
	  Push "轻狂的软件.exe"
	  Processwork::KillProcess
	  Sleep 1000
	  Goto CheckProc
	  Exit:
	  Abort
	  Done:
	  Pop $R0

	InitPluginsDir
  ;创建互斥防止重复运行
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "轻狂的软件_installer") i .r1 ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "有一个 ${PRODUCT_NAME} 升级程序已经运行！"
    Abort
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
  
  
FunctionEnd
