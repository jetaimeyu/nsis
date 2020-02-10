

!define PRODUCT_NAME "同步程序"
!define PRODUCT_VERSION "1.0.0.1"

SetCompressor lzma
SetFont "tahoma" 8
RequestExecutionLevel admin

!include "MUI2.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
;定义安装程序图标
!define MUI_ICON "Icon\MD_Setup.ico"
;定义卸载程序图标
;!define MUI_UNICON "Icon\Uninstall.ico"

!insertmacro MUI_LANGUAGE "SimpChinese"

;!insertmacro MUI_PAGE_WELCOME
; 安装目录选择页面
!insertmacro MUI_PAGE_DIRECTORY
; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES

InstallDir "$PROGRAMFILES\同步程序"
Name "${PRODUCT_NAME}_升级_${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}_升级_${PRODUCT_VERSION}.exe"
;InstallDirRegKey HKCU "Software\autotask" ""
BrandingText "迈迪信息技术有限公司"

Section "升级文件" SEC01

  SetDetailsPrint textonly
  DetailPrint "正在升级 ${PRODUCT_NAME}，请单击关闭按钮完成升级！"
  SetDetailsPrint listonly

  SectionIn RO
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ;升级文件
  File  "code\username.txt"
  ;File /r "release\*.*"

SectionEnd

Section .onInit
	;禁止多个安装程序实例
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "autotaskupdate") i .r1 ?e'
	Pop $R0
	StrCmp $R0 0 +3
	MessageBox MB_OK|MB_ICONEXCLAMATION "autotask更新程序已经在运行。"
	Abort

	;禁止重复安装程序
	/**
	ReadRegStr $0 HKLM '${PRODUCT_DIR_REGKEY}' ""
	StrLen $1 $0
	IntCmp $1 0 +3 +1 +1
	MessageBox MB_OK|MB_USERICON '$(^Name) 已安装在计算机中。如需重新安装，请卸载已有的安装'
	Quit
	*/

	ReadRegStr $0 HKCU "Software\autotask" ""
	StrCmp $0 "" 0 NoAbort
	  MessageBox MB_OK|MB_ICONEXCLAMATION "您未正确安装autotask的软件，不能使用此升级程序！"
	  Abort ;退出安装程序
	NoAbort:

SectionEnd


