; 该脚本使用 HM VNISEdit 脚本编辑器向导产生


#变量定义
Var MSG     ;MSG变量必须定义，而且在最前面，否则WndProc::onCallback不工作，插件中需要这个消息变量,用于记录消息信息
Var Dialog  ;Dialog变量也需要定义，他可能是NSIS默认的对话框变量用于保存窗体中控件的信息

Var BGImage  ;背景大图
Var ImageHandle

Var BGImage1  ;背景大图
Var ImageHandle1

Var Txt_Browser
Var btn_Browser
Var btn_incancle
Var btn_in
Var btn_ins
Var btn_back
Var btn_Close
Var btn_instetup
Var btn_instend
Var btn_instend1
Var btn_Licenseback
Var btn_Gracenoteback

Var Txt_Xllicense
Var Rtf_license
Var Txt_Gracenote
Var Rtf_Gracenote
Var Txt_ji

Var Ckbox0
Var Ckbox1
Var Ckbox1_State
Var Ckbox2
Var Ckbox2_State
Var Ckbox3
Var Ckbox3_State
Var ckbox4
Var ckbox5

; 安装程序初始定义常量
!define PRODUCT_NAME "迈迪物联码打码控制系统"
!define PRODUCT_VERSION "4.2.12.23"
!define PRODUCT_PUBLISHER "迈迪网"
!define PRODUCT_WEB_SITE "http://www.maidiyun.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\MdCode.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

#设置压缩方式
SetCompressor lzma
SetCompress force

#安装程序基本设置
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}" ;应用程序显示名字
OutFile "${PRODUCT_NAME} ${PRODUCT_VERSION}.exe" ;应用程序输出文件名
!define DIR "$PROGRAMFILES\MaidiCode" ;请在这里定义路径
InstallDir "${DIR}"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails nevershow ;设置是否显示安装详细信息。
ShowUnInstDetails nevershow ;设置是否显示删除详细信息。
BrandingText "迈迪物联码打码控制系统"

#引入头文件
!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "LoadRTF.nsh"
!include "FileFunc.nsh"

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
; MUI 预定义常量
!define MUI_ICON "Icon\MD_Setup.ico" ;安装图标路径
!define MUI_UNICON "Icon\MD_Setup.ico" ;安装图标路径
#!define MUI_UNICON "Icon\Uninstall.ico" ;卸载图标路径
!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
!define MUI_CUSTOMFUNCTION_UNGUIINIT un.myGUIInit
#!define MUI_PAGE_CUSTOMFUNCTION_SHOW "CompShowProc"
#!insertmacro MUI_PAGE_COMPONENTS

# ReserveFile把文件保存在稍后使用的数据区块  加快安装包展开速度
ReserveFile "images\bg.bmp"
ReserveFile "images\bg2.bmp"
ReserveFile "images\bg3.bmp"
ReserveFile "images\browse.bmp"
ReserveFile "images\close.bmp"
ReserveFile "images\custom.bmp"
ReserveFile "images\empty_bg.bmp"
ReserveFile "images\express.bmp"
ReserveFile "images\finish.bmp"
ReserveFile "images\full_bg.bmp"
ReserveFile "images\onekey.bmp"
ReserveFile "images\strongbtn.bmp"
ReserveFile "images\weakbtn.bmp"
;轮展数据
ReserveFile "images\Slides.dat"
ReserveFile "images\InstallingBG01.png"
ReserveFile "images\InstallingBG02.png"
ReserveFile "images\InstallingBG03.png"


#定义页面


Page custom Page.1 Page.1leave

; 安装过程页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPageShow ;安装过程页面添加函数
!insertmacro MUI_PAGE_INSTFILES

; 安装完成页面
Page custom Page.3

;这个不要删除，否则自动跳转出问题
Page custom Page.4


; 定义安装卸载过程页面

UninstPage custom un.page
#!insertmacro MUI_UNPAGE_CONFIRM
!define MUI_PAGE_CUSTOMFUNCTION_SHOW un.installpageshow
!insertmacro MUI_UNPAGE_INSTFILES 


UninstPage custom un.installFinishPage
#!insertmacro MUI_UNPAGE_FINISH

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"


#文件版本信息定义
VIProductVersion "0.0.0.0"           ;←↓版本啦
VIAddVersionKey /LANG=2052 "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "Comments" "http://www.maidiyun.com/" ;请自己修改
VIAddVersionKey /LANG=2052 "CompanyName" "迈迪"
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright (c) 迈迪"
VIAddVersionKey /LANG=2052 "FileDescription" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "FileVersion" "${PRODUCT_VERSION}"
;------------------------------------------------------MUI 现代界面定义以及函数结束------------------------


;------------------------------------------------------区块定义------------------------
Section MainSetup
	SetDetailsPrint textonly
	DetailPrint "正在释放文件，请稍候..."
	SetDetailsPrint None ;不显示信息
	nsisSlideshow::Show /NOUNLOAD /auto=$PLUGINSDIR\Slides.dat
	Sleep 1500 ;在安装程序里暂停执行 "休眠时间(单位为:ms)" 毫秒。"休眠时间(单位为:ms)" 可以是一个变量， 例如 "$0" 或一个数字，例如 "666"。
	SetOutPath $INSTDIR
	SetOverwrite on
	File /r "Release\*.*"
  
  #创建快捷方式
  SetShellVarContext current
  CreateDirectory "$SMPROGRAMS\迈迪物联码打码控制系统"
  CreateShortCut "$SMPROGRAMS\迈迪物联码打码控制系统\迈迪物联码打码控制系统.lnk" "$INSTDIR\MdCode.exe"
  CreateShortCut "$DESKTOP\迈迪物联码打码控制系统.lnk" "$INSTDIR\MdCode.exe"

 # SetShellVarContext all
 # CreateDirectory "$SMPROGRAMS\迈迪物联码打码控制系统"
 # CreateShortCut "$SMPROGRAMS\迈迪物联码打码控制系统\迈迪物联码打码控制系统.lnk" "$INSTDIR\MdCode.exe"
 # CreateShortCut "$DESKTOP\迈迪物联码打码控制系统.lnk" "$INSTDIR\MdCode.exe"
nsisSlideshow::Stop
SetAutoClose true
SectionEnd


Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\迈迪物联码打码控制系统\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\迈迪物联码打码控制系统\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

#写入注册表
Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe" ;
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\MDCode.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe" ;这里建议自己修改.这里是卸载程序的路径和文件名。
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\uninst.exe"      ;显示在你的应用程序名称旁边的图标的路径，文件名和索引。
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

#卸载区块
Section Uninstall
	SetDetailsPrint textonly
	DetailPrint "正在卸载${PRODUCT_NAME}..."
  SetDetailsPrint None
	nsisSlideshow::Show /NOUNLOAD /auto=$PLUGINSDIR\Slides.dat
	Sleep 500
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\MdCode.exe"
  Delete "$INSTDIR\*.*"
  Delete "$APPDATA\Net Dimension Studio\NanUI\Memory\*.*"
  #删除快捷方式
  SetShellVarContext current
  Delete "$SMPROGRAMS\迈迪物联码打码控制系统\Uninstall.lnk"
  Delete "$SMPROGRAMS\迈迪物联码打码控制系统\Website.lnk"
  Delete "$DESKTOP\迈迪物联码打码控制系统.lnk"
  Delete "$SMPROGRAMS\迈迪物联码打码控制系统\迈迪物联码打码控制系统.lnk"
  RMDir "$SMPROGRAMS\迈迪物联码打码控制系统"
  SetShellVarContext all
  Delete "$SMPROGRAMS\迈迪物联码打码控制系统\Uninstall.lnk"
  Delete "$SMPROGRAMS\迈迪物联码打码控制系统\Website.lnk"
  Delete "$DESKTOP\迈迪物联码打码控制系统.lnk"
  Delete "$SMPROGRAMS\迈迪物联码打码控制系统\迈迪物联码打码控制系统.lnk"
  RMDir "$SMPROGRAMS\迈迪物联码打码控制系统"

	RMDir /r "$INSTDIR\app.publish"
	RMDir /r "$INSTDIR\log"
  RMDir /r "$INSTDIR\Template"
  RMDir /r "$INSTDIR\TemplateEq"
  RMDir /r "$INSTDIR\backup"
  RMDir /r "$INSTDIR\res"
  RMDir /r "$INSTDIR\plug"
  RMDir /r "$INSTDIR\PARAM"
  RMDir /r "$INSTDIR\LANG"
  RMDir /r "$INSTDIR\fx"
  RMDir /r "$INSTDIR\FONT"
  RMDir /r "$INSTDIR\update"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd
;------------------------------------------------------区块定义结束------------------------


;------------------------------------------------------函数定义------------------------

#初始化函数

Function .onInit
    InitPluginsDir ;初始化插件目录
    Call checkFramework4
    StrCpy $Ckbox1_State ${BST_CHECKED}
    StrCpy $Ckbox2_State ${BST_CHECKED}
    StrCpy $Ckbox3_State ${BST_CHECKED}

		File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\bg.bmp` ;第一大背景
    File `/oname=$PLUGINSDIR\bg2.bmp` `images\bg2.bmp` ;第二大背景
    File `/oname=$PLUGINSDIR\bg3.bmp` `images\bg3.bmp` ;完成页背景

    File `/oname=$PLUGINSDIR\btn_onekey.bmp` `images\onekey.bmp`  ;快速安装
    File `/oname=$PLUGINSDIR\btn_custom.bmp` `images\custom.bmp`  ;自定义安装
    File `/oname=$PLUGINSDIR\btn_browse.bmp` `images\browse.bmp` ;浏览按钮
    File `/oname=$PLUGINSDIR\btn_strongbtn.bmp` `images\strongbtn.bmp` ;立即安装
    File `/oname=$PLUGINSDIR\btn_finish.bmp` `images\finish.bmp` ;安装完成
    File `/oname=$PLUGINSDIR\btn_weakbtn.bmp` `images\weakbtn.bmp` ;返回
    File `/oname=$PLUGINSDIR\btn_express.bmp` `images\express.bmp` ;立即体验
    File `/oname=$PLUGINSDIR\btn_Close.bmp` `images\Close.bmp` ;关闭

		;进度条皮肤
	  File `/oname=$PLUGINSDIR\Progress.bmp` `images\empty_bg.bmp`
  	File `/oname=$PLUGINSDIR\ProgressBar.bmp` `images\full_bg.bmp`
  	;协议
  	File `/oname=$PLUGINSDIR\license.rtf` `rtf\license.rtf`
  	File `/oname=$PLUGINSDIR\Gracenote.rtf` `rtf\Gracenote.rtf`

		;初始化
    SkinBtn::Init "$PLUGINSDIR\btn_onekey.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_custom.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_browse.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_strongbtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_finish.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_weakbtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_express.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_Close.bmp"

FunctionEnd


Function onGUIInit

#		File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
#    File '/oname=$PLUGINSDIR\InstallingBG01.png' 'images\InstallingBG01.png'
#    File '/oname=$PLUGINSDIR\InstallingBG02.png' 'images\InstallingBG02.png'
#    File '/oname=$PLUGINSDIR\InstallingBG03.png' 'images\InstallingBG03.png'
	;检查重复运行
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "MDCode") i .r1 ?e'
  Pop $R1																																		 ;;;;$$$$$安装程序已经运行
  StrCmp $R1 0 +3
  MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "程序已经在运行。"
  Abort

  ;检测是否正在运行
  RETRY:
  FindProcDLL::FindProc "MDCode.exe" ;检测的运行进程名称
  StrCmp $R0 1 0 +3
  MessageBox MB_RETRYCANCEL|MB_ICONINFORMATION|MB_TOPMOST '检测到 "${PRODUCT_NAME}" 正在运行,请先关闭后重试，或者点击"取消"退出!' IDRETRY RETRY
	Quit

    ;消除边框
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;隐藏一些既有控件
    GetDlgItem $0 $HWNDPARENT 1034
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1035
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1036
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1037
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1038
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1039
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}

    ${NSW_SetWindowSize} $HWNDPARENT 589 439 ;改变主窗体大小
    System::Call User32::GetDesktopWindow()i.R0

    ;圆角
    System::Alloc 16
  	System::Call user32::GetWindowRect(i$HWNDPARENT,isR0)
  	System::Call *$R0(i.R1,i.R2,i.R3,i.R4)
  	IntOp $R3 $R3 - $R1
  	IntOp $R4 $R4 - $R2
  	System::Call gdi32::CreateRoundRectRgn(i0,i0,iR3,iR4,i4,i4)i.r0
  	System::Call user32::SetWindowRgn(i$HWNDPARENT,ir0,i1)
  	System::Free $R0
FunctionEnd
Function un.myGUIInit
 InitPluginsDir ;初始化插件目录
 FindProcDLL::FindProc "MdCode.exe"
   Pop $R0
   IntCmp $R0 1 0 no_run
   MessageBox MB_ICONSTOP "安装程序检测到 ${PRODUCT_NAME} 正在运行，请退出程序后重试"
   Quit
   no_run:
#    Call checkFramework4
#		MessageBox MB_OK $PLUGINSDIR
    StrCpy $Ckbox1_State ${BST_CHECKED}
    StrCpy $Ckbox2_State ${BST_CHECKED}
    StrCpy $Ckbox3_State ${BST_CHECKED}
    ReserveFile "images\Slides.dat"
		ReserveFile "images\InstallingBG01.png"
		ReserveFile "images\InstallingBG02.png"
		ReserveFile "images\InstallingBG03.png"
		File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    File '/oname=$PLUGINSDIR\InstallingBG01.png' 'images\InstallingBG01.png'
    File '/oname=$PLUGINSDIR\InstallingBG02.png' 'images\InstallingBG02.png'
    File '/oname=$PLUGINSDIR\InstallingBG03.png' 'images\InstallingBG03.png'

    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\bg.bmp` ;第一大背景
    File `/oname=$PLUGINSDIR\bg2.bmp` `images\bg2.bmp` ;第二大背景
    File `/oname=$PLUGINSDIR\bg4.bmp` `images\bg4.bmp` ;完成页背景

    File `/oname=$PLUGINSDIR\btn_onekey.bmp` `images\onekey.bmp`  ;快速安装
    File `/oname=$PLUGINSDIR\btn_custom.bmp` `images\custom.bmp`  ;自定义安装
    File `/oname=$PLUGINSDIR\btn_browse.bmp` `images\browse.bmp` ;浏览按钮
    File `/oname=$PLUGINSDIR\btn_strongbtn.bmp` `images\strongbtn.bmp` ;立即安装
    File `/oname=$PLUGINSDIR\btn_finish.bmp` `images\finish.bmp` ;安装完成
    File `/oname=$PLUGINSDIR\btn_weakbtn.bmp` `images\weakbtn.bmp` ;返回
    File `/oname=$PLUGINSDIR\btn_express.bmp` `images\express.bmp` ;立即体验
    File `/oname=$PLUGINSDIR\btn_Close.bmp` `images\Close.bmp` ;关闭

		;进度条皮肤
	  File `/oname=$PLUGINSDIR\Progress.bmp` `images\empty_bg.bmp`
  	File `/oname=$PLUGINSDIR\ProgressBar.bmp` `images\full_bg.bmp`
  	;协议
  	File `/oname=$PLUGINSDIR\license.rtf` `rtf\license.rtf`
  	File `/oname=$PLUGINSDIR\Gracenote.rtf` `rtf\Gracenote.rtf`

		;初始化
    SkinBtn::Init "$PLUGINSDIR\btn_onekey.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_custom.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_browse.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_strongbtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_finish.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_weakbtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_express.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_Close.bmp"

	 ;消除边框
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;隐藏一些既有控件
    GetDlgItem $0 $HWNDPARENT 1034
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1035
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1036
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1037
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1038
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1039
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1256
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1028
    ShowWindow $0 ${SW_HIDE}

    ${NSW_SetWindowSize} $HWNDPARENT 589 439 ;改变主窗体大小
    System::Call User32::GetDesktopWindow()i.R0

    ;圆角
    System::Alloc 16
  	System::Call user32::GetWindowRect(i$HWNDPARENT,isR0)
  	System::Call *$R0(i.R1,i.R2,i.R3,i.R4)
  	IntOp $R3 $R3 - $R1
  	IntOp $R4 $R4 - $R2
  	System::Call gdi32::CreateRoundRectRgn(i0,i0,iR3,iR4,i4,i4)i.r0
  	System::Call user32::SetWindowRgn(i$HWNDPARENT,ir0,i1)
  	System::Free $R0
FunctionEnd


;处理无边框移动
Function onGUICallback
  ${If} $MSG = ${WM_LBUTTONDOWN}
    SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
  ${EndIf}
FunctionEnd

;处理无边框移动
Function un.onGUICallback
  ${If} $MSG = ${WM_LBUTTONDOWN}
    SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
  ${EndIf}
FunctionEnd

#检测.NET4框架
Function checkFramework4
	ClearErrors
	ReadRegDWORD $0 HKLM "SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client" "Install2"
		IfErrors 0 ExitCheckFramework4
  ClearErrors
 	ReadRegDWORD $0 HKLM "SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" "Install"
 	  IfErrors 0 ExitCheckFramework4
 	MessageBox MB_OK "装程序无法检测到.NET Framework V4.0, 请先安装"
 	ExitCheckFramework4:
FunctionEnd

# 自定义页面 Page.1 方法
Function Page.1

    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1990
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1991
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 1992
    ShowWindow $0 ${SW_HIDE}

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $0 588 438 ;改变Page大小

    ;读取RTF的文本框
		nsDialogs::CreateControl "RichEdit20A" \
    ${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_TABSTOP}|${WS_VSCROLL}|${ES_MULTILINE}|${ES_WANTRETURN} \
		${WS_EX_STATICEDGE}  16u 24u 360u 229u ''
    Pop $rtf_License
		${LoadRTF} '$PLUGINSDIR\license.rtf' $rtf_License
    ShowWindow $rtf_License ${SW_HIDE}

		nsDialogs::CreateControl "RichEdit20A" \
    ${ES_READONLY}|${WS_VISIBLE}|${WS_CHILD}|${WS_TABSTOP}|${WS_VSCROLL}|${ES_MULTILINE}|${ES_WANTRETURN} \
		${WS_EX_STATICEDGE}  16u 24u 360u 229u ''
    Pop $Rtf_Gracenote
		${LoadRTF} '$PLUGINSDIR\Gracenote.rtf' $Rtf_Gracenote
    ShowWindow $Rtf_Gracenote ${SW_HIDE}

    ;协议确定按钮
    ${NSD_CreateButton} 180u 263u 55 30 "确定"
    Pop $btn_Licenseback
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_Licenseback
    GetFunctionAddress $3 Licenseback
    SkinBtn::onClick $btn_Licenseback $3
    SetCtlColors $btn_Licenseback 7F7F7F transparent
    ShowWindow $btn_Licenseback ${SW_HIDE}

    ;第三方协议确定按钮
    ${NSD_CreateButton} 220u 263u 55 30 "确定"
    Pop $btn_Gracenoteback
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_Gracenoteback
    GetFunctionAddress $3 Gracenoteback
    SkinBtn::onClick $btn_Gracenoteback $3
    SetCtlColors $btn_Gracenoteback 7F7F7F transparent
    ShowWindow $btn_Gracenoteback ${SW_HIDE}

    ;自定义安装按钮
    ${NSD_CreateButton} 310u 263u 98 17 ""
    Pop $btn_ins
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_custom.bmp $btn_ins
    GetFunctionAddress $3 onClickint
    SkinBtn::onClick $btn_ins $3

    ;快速安装
    ${NSD_CreateButton} 126u 204u 252 64 ""
    Pop $btn_in
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_onekey.bmp $btn_in
    GetFunctionAddress $3 onClickins
    SkinBtn::onClick $btn_in $3

    ;关闭按钮
    ${NSD_CreateButton} 372u 8u 24 20 ""
    Pop $btn_Close
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_Close.bmp $btn_Close
    GetFunctionAddress $3 ABORT
    SkinBtn::onClick $btn_Close $3

    ;立即安装
    ${NSD_CreateButton} 284u 260u 82 29 "立即安装"
    Pop $btn_instetup
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_strongbtn.bmp $btn_instetup
    GetFunctionAddress $3 onClickins
    SkinBtn::onClick $btn_instetup $3
    SetCtlColors $btn_instetup FFFFFF transparent
    ShowWindow $btn_instetup ${SW_HIDE}

    ;返回
    ${NSD_CreateButton} 344u 259u 56 30 "返回"
    Pop $btn_back
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_back
    GetFunctionAddress $3 onClickBack
    SkinBtn::onClick $btn_back $3
    SetCtlColors $btn_back 7F7F7F transparent
    ShowWindow $btn_back ${SW_HIDE}

#------------------------------------------
#许可协议
#------------------------------------------
    ${NSD_CreateCheckbox} 17u 265u 116u 12u "同意迈迪物联打码控制系统的"
    Pop $Ckbox0
    SetCtlColors $Ckbox0 "" EEF7FE
    ${NSD_Check} $Ckbox0
    ${NSD_OnClick} $Ckbox0 Chklicense
    ${NSD_CreateLink} 134u 267u 57u 12u "用户许可协议"
    Pop $Txt_Xllicense
    SetCtlColors $Txt_Xllicense 13ABEE EEF7FE
    ${NSD_OnClick} $Txt_Xllicense xllicense

#------------------------------------------
#可选项1
#------------------------------------------
    ${NSD_CreateCheckbox} 17u 216u 80u 12u "创建桌面图标"
    Pop $Ckbox1
    SetCtlColors $Ckbox1 ""  EEF7FE ;前景色,背景设成透明
		ShowWindow $Ckbox1 ${SW_HIDE}
		${NSD_Check} $Ckbox1

#------------------------------------------
#可选项2
#------------------------------------------
    ${NSD_CreateCheckbox} 130u 216u 80u 12u "添加到快速启动栏"
    Pop $Ckbox2
    SetCtlColors $Ckbox2 ""  EEF7FE ;前景色,背景设成透明
		ShowWindow $Ckbox2 ${SW_HIDE}
		${NSD_Check} $Ckbox2

		;创建安装目录输入文本框
  	${NSD_CreateText} 21u 183u 290u 18u "${DIR}"
		Pop $Txt_Browser
		EnableWindow $Txt_Browser 0 ;文本输入框禁止鼠标键盘键入 ，目的是防止用户手动输入无效的目录
		SetCtlColors $Txt_Browser ""  FFFFFF ;背景设成透明
		;${NSD_AddExStyle} $Txt_Browser ${WS_EX_WINDOWEDGE}
    CreateFont $1 "tahoma" "11" "500"
    SendMessage $Txt_Browser ${WM_SETFONT} $1 1
		ShowWindow $Txt_Browser ${SW_HIDE}


    ;创建更改路径文件夹按钮
    ${NSD_CreateButton} 314u 273U 79 19u  "浏览..."
		Pop $btn_Browser
		SkinBtn::Set /IMGID=$PLUGINSDIR\btn_browse.bmp $btn_Browser
		GetFunctionAddress $3 onClickSelectPath
    SkinBtn::onClick $btn_Browser $3
    SetCtlColors $btn_Browser 7F7F7F transparent ;前景色,背景设成透明
    
    ShowWindow $btn_Browser ${SW_HIDE}


    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage1
    ${NSD_SetImage} $BGImage1 $PLUGINSDIR\bg2.bmp $ImageHandle1
    ShowWindow $BGImage1 ${SW_HIDE}

    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
    WndProc::onCallback $BGImage1 $0 ;处理无边框窗体移动

    nsDialogs::Show
    ${NSD_FreeImage} $ImageHandle
    ${NSD_FreeImage} $ImageHandle1
FunctionEnd

Function Page.1leave
${NSD_GetState} $Ckbox1 $Ckbox1_State
${NSD_GetState} $Ckbox2 $Ckbox2_State
${NSD_GetState} $Ckbox3 $Ckbox3_State
FunctionEnd


Function  InstFilesPageShow

		;存入轮展图片
    File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    File '/oname=$PLUGINSDIR\InstallingBG01.png' 'images\InstallingBG01.png'
    File '/oname=$PLUGINSDIR\InstallingBG02.png' 'images\InstallingBG02.png'
    File '/oname=$PLUGINSDIR\InstallingBG03.png' 'images\InstallingBG03.png'
    
    FindWindow $R2 "#32770" "" $HWNDPARENT
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $1 $R2 1027
    ShowWindow $1 ${SW_HIDE}
    StrCpy $R0 $R2 ;改变页面大小,不然贴图不能全页
    #System::Call "user32::MoveWindow(i R0, i 0, i 0, i 588, i 438) i r2"
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 588, i 438) i r2"
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $R0 $0 ;处理无边框窗体移动

    GetDlgItem $R0 $R2 1004  ;设置进度条位置
    System::Call "user32::MoveWindow(i R0, i 30, i 350, i 537, i 12) i r2"

    GetDlgItem $R1 $R2 1006  ;进度条上面的标签
    SetCtlColors $R1 "DC0000"  F0F0F0 ;背景设成F6F6F6,注意颜色不能设为透明，否则重叠
    System::Call "user32::MoveWindow(i R1, i 30, i 330, i 290, i 12) i r2"

    GetDlgItem $R8 $R2 1016
    SetCtlColors $R8 ""  DC0000 ;背景设成F6F6F6,注意颜色不能设为透明，否则重叠
    System::Call "user32::MoveWindow(i R8, i 0, i 0, i 588, i 438) i r2" ;背景图贴满整个页面

    FindWindow $R2 "#32770" "" $HWNDPARENT  ;获取1995并设置图片
    GetDlgItem $R0 $R2 1995
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 498, i 373) i r2"
    ${NSD_SetImage} $R0 $PLUGINSDIR\bg2.bmp $ImageHandle

		;这里是给进度条贴图
    FindWindow $R2 "#32770" "" $HWNDPARENT
    GetDlgItem $5 $R2 1004
	  SkinProgress::Set $5 "$PLUGINSDIR\ProgressBar.bmp" "$PLUGINSDIR\Progress.bmp"

FunctionEnd


Function Page.3
    GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $0 588 438 ;改变Page大小

    ;立即体验
    ${NSD_CreateButton} 80u 210u 160 54 ""
    Pop $btn_instend
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_express.bmp $btn_instend
    GetFunctionAddress $3 onClickexpress
    SkinBtn::onClick $btn_instend $3

    ;安装完成
    ${NSD_CreateButton} 210u 210u 160 54 ""
    Pop $btn_instend1
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_finish.bmp $btn_instend1
    GetFunctionAddress $3 onClickend
    SkinBtn::onClick $btn_instend1 $3

    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg3.bmp $ImageHandle

    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
    nsDialogs::Show

    ${NSD_FreeImage} $ImageHandle

FunctionEnd


Function Page.4

FunctionEnd

Function un.installpageshow
		;存入轮展图片
    File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    File '/oname=$PLUGINSDIR\InstallingBG01.png' 'images\InstallingBG01.png'
    File '/oname=$PLUGINSDIR\InstallingBG02.png' 'images\InstallingBG02.png'
    File '/oname=$PLUGINSDIR\InstallingBG03.png' 'images\InstallingBG03.png'

  	FindWindow $R2 "#32770" "" $HWNDPARENT
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $1 $R2 1027
    ShowWindow $1 ${SW_HIDE}


    StrCpy $R0 $R2 ;改变页面大小,不然贴图不能全页
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 588, i 588) i r2"
    GetFunctionAddress $0 un.onGUICallback
    WndProc::onCallback $R0 $0 ;处理无边框窗体移动

    GetDlgItem $R0 $R2 1004  ;设置进度条位置
    System::Call "user32::MoveWindow(i R0, i 30, i 350, i 537, i 12) i r2"

    GetDlgItem $R1 $R2 1006  ;进度条上面的标签
    SetCtlColors $R1 "DC0000"  F0F0F0 ;背景设成F6F6F6,注意颜色不能设为透明，否则重叠
    System::Call "user32::MoveWindow(i R1, i 30, i 370, i 290, i 12) i r2"
    

    GetDlgItem $R8 $R2 1016
    ;SetCtlColors $R8 ""  F6F6F6 ;背景设成F6F6F6,注意颜色不能设为透明，否则重叠
    System::Call "user32::MoveWindow(i R8, i 0, i 0, i 588, i 438) i r2"



    FindWindow $R2 "#32770" "" $HWNDPARENT  ;获取1995并设置图片
    GetDlgItem $R0 $R2 1995
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 498, i 373) i r2"
    ${NSD_SetImage} $R0 $PLUGINSDIR\bg2.bmp $ImageHandle

		;这里是给进度条贴图
    FindWindow $R2 "#32770" "" $HWNDPARENT
    GetDlgItem $5 $R2 1004
	  SkinProgress::Set $5 "$PLUGINSDIR\ProgressBar.bmp" "$PLUGINSDIR\Progress.bmp"


FunctionEnd

Function un.installFinishPage
 		GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $0 588 438 ;改变Page大小


    ;卸载完成
    ${NSD_CreateButton} 126u 204u 252 64 "卸载完成"
    Pop $btn_in
    #SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_in
    GetFunctionAddress $3 un.Abort ;点击进入下一步
    SkinBtn::onClick $btn_in $3
    #SkinBtn::onClick Abort

    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg4.bmp $ImageHandle

    GetFunctionAddress $0 un.onGUICallback
    WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
    nsDialogs::Show

    ${NSD_FreeImage} $ImageHandle

FunctionEnd
Function un.Abort
SendMessage  $HWNDPARENT "0x408" 0 0
  Quit
	#ExecShell "open" "http://www.maidiyun.com"
	#Abort
FunctionEnd


Function un.page
 		GetDlgItem $0 $HWNDPARENT 1
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 2
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $0 $HWNDPARENT 3
    ShowWindow $0 ${SW_HIDE}

    nsDialogs::Create 1044
    Pop $0
    ${If} $0 == error
        Abort
    ${EndIf}
    SetCtlColors $0 ""  transparent ;背景设成透明

    ${NSW_SetWindowSize} $0 588 438 ;改变Page大小

  	;卸载确认
    ${NSD_CreateButton} 60u 215u 120u 30u "暂不卸载"
    Pop $btn_incancle
#    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_strongbtn.bmp $btn_incancle
    GetFunctionAddress $3 un.noremove ;点击退出
    SkinBtn::onClick $btn_incancle $3

    ;卸载确认
    ${NSD_CreateButton} 200u 215u 120u 30u "确定卸载"
    Pop $btn_in
    #SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_in
    GetFunctionAddress $3 un.remove ;点击进入下一步
    SkinBtn::onClick $btn_in $3

    ;贴背景大图
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

 #   GetFunctionAddress $0 onGUICallback
 #   WndProc::onCallback $BGImage $0 ;处理无边框窗体移动
    nsDialogs::Show

    ${NSD_FreeImage} $ImageHandle

FunctionEnd

Function ABORT
MessageBox MB_ICONQUESTION|MB_YESNO|MB_ICONSTOP '您确定要退出"迈迪打码控制系统"安装程序？' IDNO CANCEL
SendMessage $hwndparent ${WM_CLOSE} 0 0
CANCEL:
Abort
FunctionEnd

;处理页面跳转的命令
Function RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

Function un.noremove
	SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd

Function un.remove
  StrCpy $R9 1
  Call un.RelGotoPage
FunctionEnd

Function un.RelGotoPage
  IntCmp $R9 0 0 Move Move
    StrCmp $R9 "X" 0 Move
      StrCpy $R9 "120"
  Move:
  SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

Function onClickins
	#检测安装目录是否合法 通过检测根目录空间实现
	${NSD_GetText} $Txt_Browser  $R0  ;获得设置的安装路径
	StrCpy $INSTDIR $R0
	${GetRoot} "$INSTDIR" $R3 ;获取安装根目录
	StrCpy $R0 "$R3\"
	${DriveSpace} "$R3\" "/D=F  /S=M" $R0 ;获取指定盘符的剩余可用空间 ， /D=F剩余空间 /S=M 单位M字节
	${if} $R0 < 100
		MessageBox MB_OK|MB_ICONEXCLAMATION "指定分区剩余空间不足， 请选择其他分区安装！"
		Abort
	${endif}

   ;判断目录是否正确
#	ClearErrors
#	CreateDirectory "$INSTDIR"
#	IfErrors 0 +3
#  MessageBox MB_ICONINFORMATION|MB_OK "'$INSTDIR' 安装目录不存在，请重新设置。"
#  Abort
#	StrCpy $INSTDIR  $R0  ;保存安装路径

  StrCpy $R9 1 ;Goto the next page
  Call RelGotoPage
  Abort
FunctionEnd

;当单击自定义安装后隐藏和显示一部分控件
Function onClickint
ShowWindow $BGImage ${SW_HIDE}
ShowWindow $Ckbox0 ${SW_HIDE}
ShowWindow $Txt_Xllicense ${SW_HIDE}
ShowWindow $Txt_Gracenote ${SW_HIDE}
ShowWindow $Txt_ji ${SW_HIDE}


ShowWindow $btn_in ${SW_HIDE}
ShowWindow $btn_ins ${SW_HIDE}

ShowWindow $btn_Close ${SW_SHOW}
ShowWindow $BGImage1 ${SW_SHOW}
ShowWindow $btn_instetup ${SW_SHOW}
ShowWindow $btn_back ${SW_SHOW}
ShowWindow $Ckbox1 ${SW_SHOW}
ShowWindow $Ckbox2 ${SW_SHOW}
ShowWindow $Ckbox3 ${SW_SHOW}
ShowWindow $btn_Browser ${SW_SHOW}
ShowWindow $Txt_Browser ${SW_SHOW}

FunctionEnd

;点击返回时隐藏显示部分控件
Function onClickBack
ShowWindow $BGImage1 ${SW_HIDE}

ShowWindow $BGImage ${SW_SHOW}

ShowWindow $Ckbox0 ${SW_SHOW}
ShowWindow $Txt_Xllicense ${SW_SHOW}
ShowWindow $Txt_Gracenote ${SW_SHOW}
ShowWindow $Txt_ji ${SW_SHOW}
ShowWindow $btn_in ${SW_HIDE}
ShowWindow $btn_ins ${SW_HIDE}
ShowWindow $btn_in ${SW_SHOW}
ShowWindow $btn_ins ${SW_SHOW}


ShowWindow $BGImage1 ${SW_HIDE}
ShowWindow $btn_instetup ${SW_HIDE}
ShowWindow $btn_back ${SW_HIDE}
ShowWindow $Ckbox1 ${SW_HIDE}
ShowWindow $Ckbox2 ${SW_HIDE}
ShowWindow $Ckbox3 ${SW_HIDE}
ShowWindow $btn_Browser ${SW_HIDE}
ShowWindow $Txt_Browser ${SW_HIDE}
FunctionEnd

#------------------------------------------
#许可协议
#------------------------------------------
Function xllicense
ShowWindow $Ckbox0 ${SW_HIDE}
ShowWindow $Txt_Xllicense ${SW_HIDE}
ShowWindow $Txt_Gracenote ${SW_HIDE}
ShowWindow $Txt_ji ${SW_HIDE}
ShowWindow $btn_in ${SW_HIDE}
ShowWindow $btn_ins ${SW_HIDE}
ShowWindow $btn_Close ${SW_HIDE}
ShowWindow $rtf_License ${SW_SHOW}
ShowWindow $btn_Licenseback ${SW_SHOW}

ShowWindow $rtf_License ${SW_SHOW}

FunctionEnd

;点击协议下方的按钮执行
Function Licenseback
ShowWindow $btn_Close ${SW_SHOW}
ShowWindow $Ckbox0 ${SW_SHOW}
ShowWindow $Txt_Xllicense ${SW_SHOW}
ShowWindow $Txt_Gracenote ${SW_SHOW}
ShowWindow $Txt_ji ${SW_SHOW}
ShowWindow $btn_in ${SW_SHOW}
ShowWindow $btn_ins ${SW_SHOW}
ShowWindow $btn_ins ${SW_SHOW}
ShowWindow $btn_Licenseback ${SW_HIDE}
ShowWindow $rtf_License ${SW_HIDE}
ShowWindow $Rtf_Gracenote ${SW_HIDE}

FunctionEnd

Function Gracenote
ShowWindow $Ckbox0 ${SW_HIDE}
ShowWindow $Txt_Xllicense ${SW_HIDE}
ShowWindow $Txt_Gracenote ${SW_HIDE}
ShowWindow $rtf_License ${SW_HIDE}
ShowWindow $Txt_ji ${SW_HIDE}
ShowWindow $btn_in ${SW_HIDE}
ShowWindow $btn_ins ${SW_HIDE}
ShowWindow $btn_Licenseback ${SW_SHOW}
ShowWindow $rtf_Gracenote ${SW_SHOW}
FunctionEnd

;点击第三方协议下的确定按钮执行
Function Gracenoteback
ShowWindow $rtf_License ${SW_HIDE}
ShowWindow $Rtf_Gracenote ${SW_HIDE}
ShowWindow $btn_Gracenoteback ${SW_HIDE}
ShowWindow $Ckbox0 ${SW_SHOW}
ShowWindow $Txt_Xllicense ${SW_SHOW}
ShowWindow $Txt_Gracenote ${SW_SHOW}
ShowWindow $Txt_ji ${SW_SHOW}
ShowWindow $btn_in ${SW_SHOW}
ShowWindow $btn_ins ${SW_SHOW}
ShowWindow $btn_ins ${SW_SHOW}
FunctionEnd

Function onClickmusic
ExecShell "open" "http://www.maidiyun.com"
FunctionEnd
#------------------------------------------
#是否选中许可协议判断
#------------------------------------------
Function Chklicense
  Pop $Ckbox0
  ${NSD_GetState} $Ckbox0 $0
  ${If} $0 == 1
    EnableWindow $btn_ins 1 ;对指定的窗口或控件是否允许键入0禁止
    EnableWindow $btn_in 1
  ${Else}
    EnableWindow $btn_ins 0 ;对指定的窗口或控件是否允许键入0禁止
    EnableWindow $btn_in 0
  ${EndIf}
FunctionEnd


#--------------------------------------------------------
# 路径选择按钮事件，打开Windows系统自带的目录选择对话框
#--------------------------------------------------------
Function onClickSelectPath


	 ${NSD_GetText} $Txt_Browser  $0
   nsDialogs::SelectFolderDialog  "请选择 ${PRODUCT_NAME} 安装目录："  "$0"
   Pop $0
   ${IfNot} $0 == error
			${NSD_SetText} $Txt_Browser  $0
	${EndIf}

FunctionEnd

;立即体验检测
Function onClickexpress
${NSD_GetState} $Ckbox4 $0
    ${If} $0 == 1
  	MessageBox MB_OK '选中：开机自动启动' ;判断选中时的操作,实际代码需要自己修改
  ${EndIf}
${NSD_GetState} $Ckbox5 $0
  ${if} $0 = 1
  MessageBox MB_OK '选中：推荐安装' ;判断选中时的操作,实际代码需要自己修改
  ${EndIf}
Exec "$INSTDIR\MdCode.exe" ;这个不需要选中也操作，即运行
#MessageBox MB_OK '运行迈迪物联打码控制系统'
#ExecShell "open" "http://www.maidiyun.com"
SendMessage $hwndparent ${WM_CLOSE} 0 0  ;关闭安装完成页面 ${WM_CLOSE}可用16代替
FunctionEnd

;完成页面完成按钮
Function onClickend
${NSD_GetState} $Ckbox4 $0
#    ${If} $0 == 1
#  	MessageBox MB_OK '选中：开机自动启动' ;判断选中时的操作,实际代码需要自己修改
#  ${EndIf}
#${NSD_GetState} $Ckbox5 $0
#  ${if} $0 = 1
#  MessageBox MB_OK '选中：推荐安装' ;判断选中时的操作,实际代码需要自己修改
#  ${EndIf}
;ExecShell "open" "http://www.nsisfans.com/"
SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd

Function .onInstSuccess
  ExecShell "" "$INSTDIR\MdCode.exe"
FunctionEnd

#--;开始卸载时检查：--#
Function un.onInit
FindProcDLL::FindProc "MdCode.exe"
   Pop $R0
   IntCmp $R0 1 0 no_run
   MessageBox MB_ICONSTOP "安装程序检测到 ${PRODUCT_NAME} 正在运行，请退出程序后重试"
   Quit
   no_run:
#     MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
#  Abort
FunctionEnd
