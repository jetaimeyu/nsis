; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���


#��������
Var MSG     ;MSG�������붨�壬��������ǰ�棬����WndProc::onCallback���������������Ҫ�����Ϣ����,���ڼ�¼��Ϣ��Ϣ
Var Dialog  ;Dialog����Ҳ��Ҫ���壬��������NSISĬ�ϵĶԻ���������ڱ��洰���пؼ�����Ϣ

Var BGImage  ;������ͼ
Var ImageHandle

Var BGImage1  ;������ͼ
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

; ��װ�����ʼ���峣��
!define PRODUCT_NAME "����������������ϵͳ"
!define PRODUCT_VERSION "4.2.12.23"
!define PRODUCT_PUBLISHER "������"
!define PRODUCT_WEB_SITE "http://www.maidiyun.com"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\MdCode.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

#����ѹ����ʽ
SetCompressor lzma
SetCompress force

#��װ�����������
Name "${PRODUCT_NAME} ${PRODUCT_VERSION}" ;Ӧ�ó�����ʾ����
OutFile "${PRODUCT_NAME} ${PRODUCT_VERSION}.exe" ;Ӧ�ó�������ļ���
!define DIR "$PROGRAMFILES\MaidiCode" ;�������ﶨ��·��
InstallDir "${DIR}"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails nevershow ;�����Ƿ���ʾ��װ��ϸ��Ϣ��
ShowUnInstDetails nevershow ;�����Ƿ���ʾɾ����ϸ��Ϣ��
BrandingText "����������������ϵͳ"

#����ͷ�ļ�
!include "MUI.nsh"
!include "WinCore.nsh"
!include "nsWindows.nsh"
!include "LogicLib.nsh"
!include "WinMessages.nsh"
!include "LoadRTF.nsh"
!include "FileFunc.nsh"

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
; MUI Ԥ���峣��
!define MUI_ICON "Icon\MD_Setup.ico" ;��װͼ��·��
!define MUI_UNICON "Icon\MD_Setup.ico" ;��װͼ��·��
#!define MUI_UNICON "Icon\Uninstall.ico" ;ж��ͼ��·��
!define MUI_CUSTOMFUNCTION_GUIINIT onGUIInit
!define MUI_CUSTOMFUNCTION_UNGUIINIT un.myGUIInit
#!define MUI_PAGE_CUSTOMFUNCTION_SHOW "CompShowProc"
#!insertmacro MUI_PAGE_COMPONENTS

# ReserveFile���ļ��������Ժ�ʹ�õ���������  �ӿ찲װ��չ���ٶ�
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
;��չ����
ReserveFile "images\Slides.dat"
ReserveFile "images\InstallingBG01.png"
ReserveFile "images\InstallingBG02.png"
ReserveFile "images\InstallingBG03.png"


#����ҳ��


Page custom Page.1 Page.1leave

; ��װ����ҳ��
!define MUI_PAGE_CUSTOMFUNCTION_SHOW InstFilesPageShow ;��װ����ҳ����Ӻ���
!insertmacro MUI_PAGE_INSTFILES

; ��װ���ҳ��
Page custom Page.3

;�����Ҫɾ���������Զ���ת������
Page custom Page.4


; ���尲װж�ع���ҳ��

UninstPage custom un.page
#!insertmacro MUI_UNPAGE_CONFIRM
!define MUI_PAGE_CUSTOMFUNCTION_SHOW un.installpageshow
!insertmacro MUI_UNPAGE_INSTFILES 


UninstPage custom un.installFinishPage
#!insertmacro MUI_UNPAGE_FINISH

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"


#�ļ��汾��Ϣ����
VIProductVersion "0.0.0.0"           ;�����汾��
VIAddVersionKey /LANG=2052 "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "Comments" "http://www.maidiyun.com/" ;���Լ��޸�
VIAddVersionKey /LANG=2052 "CompanyName" "����"
VIAddVersionKey /LANG=2052 "LegalCopyright" "Copyright (c) ����"
VIAddVersionKey /LANG=2052 "FileDescription" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "FileVersion" "${PRODUCT_VERSION}"
;------------------------------------------------------MUI �ִ����涨���Լ���������------------------------


;------------------------------------------------------���鶨��------------------------
Section MainSetup
	SetDetailsPrint textonly
	DetailPrint "�����ͷ��ļ������Ժ�..."
	SetDetailsPrint None ;����ʾ��Ϣ
	nsisSlideshow::Show /NOUNLOAD /auto=$PLUGINSDIR\Slides.dat
	Sleep 1500 ;�ڰ�װ��������ִͣ�� "����ʱ��(��λΪ:ms)" ���롣"����ʱ��(��λΪ:ms)" ������һ�������� ���� "$0" ��һ�����֣����� "666"��
	SetOutPath $INSTDIR
	SetOverwrite on
	File /r "Release\*.*"
  
  #������ݷ�ʽ
  SetShellVarContext current
  CreateDirectory "$SMPROGRAMS\����������������ϵͳ"
  CreateShortCut "$SMPROGRAMS\����������������ϵͳ\����������������ϵͳ.lnk" "$INSTDIR\MdCode.exe"
  CreateShortCut "$DESKTOP\����������������ϵͳ.lnk" "$INSTDIR\MdCode.exe"

 # SetShellVarContext all
 # CreateDirectory "$SMPROGRAMS\����������������ϵͳ"
 # CreateShortCut "$SMPROGRAMS\����������������ϵͳ\����������������ϵͳ.lnk" "$INSTDIR\MdCode.exe"
 # CreateShortCut "$DESKTOP\����������������ϵͳ.lnk" "$INSTDIR\MdCode.exe"
nsisSlideshow::Stop
SetAutoClose true
SectionEnd


Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\����������������ϵͳ\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\����������������ϵͳ\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

#д��ע���
Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe" ;
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\MDCode.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe" ;���ｨ���Լ��޸�.������ж�س����·�����ļ�����
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\uninst.exe"      ;��ʾ�����Ӧ�ó��������Աߵ�ͼ���·�����ļ�����������
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

#ж������
Section Uninstall
	SetDetailsPrint textonly
	DetailPrint "����ж��${PRODUCT_NAME}..."
  SetDetailsPrint None
	nsisSlideshow::Show /NOUNLOAD /auto=$PLUGINSDIR\Slides.dat
	Sleep 500
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\MdCode.exe"
  Delete "$INSTDIR\*.*"
  Delete "$APPDATA\Net Dimension Studio\NanUI\Memory\*.*"
  #ɾ����ݷ�ʽ
  SetShellVarContext current
  Delete "$SMPROGRAMS\����������������ϵͳ\Uninstall.lnk"
  Delete "$SMPROGRAMS\����������������ϵͳ\Website.lnk"
  Delete "$DESKTOP\����������������ϵͳ.lnk"
  Delete "$SMPROGRAMS\����������������ϵͳ\����������������ϵͳ.lnk"
  RMDir "$SMPROGRAMS\����������������ϵͳ"
  SetShellVarContext all
  Delete "$SMPROGRAMS\����������������ϵͳ\Uninstall.lnk"
  Delete "$SMPROGRAMS\����������������ϵͳ\Website.lnk"
  Delete "$DESKTOP\����������������ϵͳ.lnk"
  Delete "$SMPROGRAMS\����������������ϵͳ\����������������ϵͳ.lnk"
  RMDir "$SMPROGRAMS\����������������ϵͳ"

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
;------------------------------------------------------���鶨�����------------------------


;------------------------------------------------------��������------------------------

#��ʼ������

Function .onInit
    InitPluginsDir ;��ʼ�����Ŀ¼
    Call checkFramework4
    StrCpy $Ckbox1_State ${BST_CHECKED}
    StrCpy $Ckbox2_State ${BST_CHECKED}
    StrCpy $Ckbox3_State ${BST_CHECKED}

		File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\bg.bmp` ;��һ�󱳾�
    File `/oname=$PLUGINSDIR\bg2.bmp` `images\bg2.bmp` ;�ڶ��󱳾�
    File `/oname=$PLUGINSDIR\bg3.bmp` `images\bg3.bmp` ;���ҳ����

    File `/oname=$PLUGINSDIR\btn_onekey.bmp` `images\onekey.bmp`  ;���ٰ�װ
    File `/oname=$PLUGINSDIR\btn_custom.bmp` `images\custom.bmp`  ;�Զ��尲װ
    File `/oname=$PLUGINSDIR\btn_browse.bmp` `images\browse.bmp` ;�����ť
    File `/oname=$PLUGINSDIR\btn_strongbtn.bmp` `images\strongbtn.bmp` ;������װ
    File `/oname=$PLUGINSDIR\btn_finish.bmp` `images\finish.bmp` ;��װ���
    File `/oname=$PLUGINSDIR\btn_weakbtn.bmp` `images\weakbtn.bmp` ;����
    File `/oname=$PLUGINSDIR\btn_express.bmp` `images\express.bmp` ;��������
    File `/oname=$PLUGINSDIR\btn_Close.bmp` `images\Close.bmp` ;�ر�

		;������Ƥ��
	  File `/oname=$PLUGINSDIR\Progress.bmp` `images\empty_bg.bmp`
  	File `/oname=$PLUGINSDIR\ProgressBar.bmp` `images\full_bg.bmp`
  	;Э��
  	File `/oname=$PLUGINSDIR\license.rtf` `rtf\license.rtf`
  	File `/oname=$PLUGINSDIR\Gracenote.rtf` `rtf\Gracenote.rtf`

		;��ʼ��
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
	;����ظ�����
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "MDCode") i .r1 ?e'
  Pop $R1																																		 ;;;;$$$$$��װ�����Ѿ�����
  StrCmp $R1 0 +3
  MessageBox MB_OK|MB_ICONINFORMATION|MB_TOPMOST "�����Ѿ������С�"
  Abort

  ;����Ƿ���������
  RETRY:
  FindProcDLL::FindProc "MDCode.exe" ;�������н�������
  StrCmp $R0 1 0 +3
  MessageBox MB_RETRYCANCEL|MB_ICONINFORMATION|MB_TOPMOST '��⵽ "${PRODUCT_NAME}" ��������,���ȹرպ����ԣ����ߵ��"ȡ��"�˳�!' IDRETRY RETRY
	Quit

    ;�����߿�
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;����һЩ���пؼ�
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

    ${NSW_SetWindowSize} $HWNDPARENT 589 439 ;�ı��������С
    System::Call User32::GetDesktopWindow()i.R0

    ;Բ��
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
 InitPluginsDir ;��ʼ�����Ŀ¼
 FindProcDLL::FindProc "MdCode.exe"
   Pop $R0
   IntCmp $R0 1 0 no_run
   MessageBox MB_ICONSTOP "��װ�����⵽ ${PRODUCT_NAME} �������У����˳����������"
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

    File `/ONAME=$PLUGINSDIR\bg.bmp` `images\bg.bmp` ;��һ�󱳾�
    File `/oname=$PLUGINSDIR\bg2.bmp` `images\bg2.bmp` ;�ڶ��󱳾�
    File `/oname=$PLUGINSDIR\bg4.bmp` `images\bg4.bmp` ;���ҳ����

    File `/oname=$PLUGINSDIR\btn_onekey.bmp` `images\onekey.bmp`  ;���ٰ�װ
    File `/oname=$PLUGINSDIR\btn_custom.bmp` `images\custom.bmp`  ;�Զ��尲װ
    File `/oname=$PLUGINSDIR\btn_browse.bmp` `images\browse.bmp` ;�����ť
    File `/oname=$PLUGINSDIR\btn_strongbtn.bmp` `images\strongbtn.bmp` ;������װ
    File `/oname=$PLUGINSDIR\btn_finish.bmp` `images\finish.bmp` ;��װ���
    File `/oname=$PLUGINSDIR\btn_weakbtn.bmp` `images\weakbtn.bmp` ;����
    File `/oname=$PLUGINSDIR\btn_express.bmp` `images\express.bmp` ;��������
    File `/oname=$PLUGINSDIR\btn_Close.bmp` `images\Close.bmp` ;�ر�

		;������Ƥ��
	  File `/oname=$PLUGINSDIR\Progress.bmp` `images\empty_bg.bmp`
  	File `/oname=$PLUGINSDIR\ProgressBar.bmp` `images\full_bg.bmp`
  	;Э��
  	File `/oname=$PLUGINSDIR\license.rtf` `rtf\license.rtf`
  	File `/oname=$PLUGINSDIR\Gracenote.rtf` `rtf\Gracenote.rtf`

		;��ʼ��
    SkinBtn::Init "$PLUGINSDIR\btn_onekey.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_custom.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_browse.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_strongbtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_finish.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_weakbtn.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_express.bmp"
    SkinBtn::Init "$PLUGINSDIR\btn_Close.bmp"

	 ;�����߿�
    System::Call `user32::SetWindowLong(i$HWNDPARENT,i${GWL_STYLE},0x9480084C)i.R0`
    ;����һЩ���пؼ�
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

    ${NSW_SetWindowSize} $HWNDPARENT 589 439 ;�ı��������С
    System::Call User32::GetDesktopWindow()i.R0

    ;Բ��
    System::Alloc 16
  	System::Call user32::GetWindowRect(i$HWNDPARENT,isR0)
  	System::Call *$R0(i.R1,i.R2,i.R3,i.R4)
  	IntOp $R3 $R3 - $R1
  	IntOp $R4 $R4 - $R2
  	System::Call gdi32::CreateRoundRectRgn(i0,i0,iR3,iR4,i4,i4)i.r0
  	System::Call user32::SetWindowRgn(i$HWNDPARENT,ir0,i1)
  	System::Free $R0
FunctionEnd


;�����ޱ߿��ƶ�
Function onGUICallback
  ${If} $MSG = ${WM_LBUTTONDOWN}
    SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
  ${EndIf}
FunctionEnd

;�����ޱ߿��ƶ�
Function un.onGUICallback
  ${If} $MSG = ${WM_LBUTTONDOWN}
    SendMessage $HWNDPARENT ${WM_NCLBUTTONDOWN} ${HTCAPTION} $0
  ${EndIf}
FunctionEnd

#���.NET4���
Function checkFramework4
	ClearErrors
	ReadRegDWORD $0 HKLM "SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Client" "Install2"
		IfErrors 0 ExitCheckFramework4
  ClearErrors
 	ReadRegDWORD $0 HKLM "SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" "Install"
 	  IfErrors 0 ExitCheckFramework4
 	MessageBox MB_OK "װ�����޷���⵽.NET Framework V4.0, ���Ȱ�װ"
 	ExitCheckFramework4:
FunctionEnd

# �Զ���ҳ�� Page.1 ����
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $0 588 438 ;�ı�Page��С

    ;��ȡRTF���ı���
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

    ;Э��ȷ����ť
    ${NSD_CreateButton} 180u 263u 55 30 "ȷ��"
    Pop $btn_Licenseback
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_Licenseback
    GetFunctionAddress $3 Licenseback
    SkinBtn::onClick $btn_Licenseback $3
    SetCtlColors $btn_Licenseback 7F7F7F transparent
    ShowWindow $btn_Licenseback ${SW_HIDE}

    ;������Э��ȷ����ť
    ${NSD_CreateButton} 220u 263u 55 30 "ȷ��"
    Pop $btn_Gracenoteback
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_Gracenoteback
    GetFunctionAddress $3 Gracenoteback
    SkinBtn::onClick $btn_Gracenoteback $3
    SetCtlColors $btn_Gracenoteback 7F7F7F transparent
    ShowWindow $btn_Gracenoteback ${SW_HIDE}

    ;�Զ��尲װ��ť
    ${NSD_CreateButton} 310u 263u 98 17 ""
    Pop $btn_ins
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_custom.bmp $btn_ins
    GetFunctionAddress $3 onClickint
    SkinBtn::onClick $btn_ins $3

    ;���ٰ�װ
    ${NSD_CreateButton} 126u 204u 252 64 ""
    Pop $btn_in
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_onekey.bmp $btn_in
    GetFunctionAddress $3 onClickins
    SkinBtn::onClick $btn_in $3

    ;�رհ�ť
    ${NSD_CreateButton} 372u 8u 24 20 ""
    Pop $btn_Close
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_Close.bmp $btn_Close
    GetFunctionAddress $3 ABORT
    SkinBtn::onClick $btn_Close $3

    ;������װ
    ${NSD_CreateButton} 284u 260u 82 29 "������װ"
    Pop $btn_instetup
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_strongbtn.bmp $btn_instetup
    GetFunctionAddress $3 onClickins
    SkinBtn::onClick $btn_instetup $3
    SetCtlColors $btn_instetup FFFFFF transparent
    ShowWindow $btn_instetup ${SW_HIDE}

    ;����
    ${NSD_CreateButton} 344u 259u 56 30 "����"
    Pop $btn_back
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_back
    GetFunctionAddress $3 onClickBack
    SkinBtn::onClick $btn_back $3
    SetCtlColors $btn_back 7F7F7F transparent
    ShowWindow $btn_back ${SW_HIDE}

#------------------------------------------
#���Э��
#------------------------------------------
    ${NSD_CreateCheckbox} 17u 265u 116u 12u "ͬ�����������������ϵͳ��"
    Pop $Ckbox0
    SetCtlColors $Ckbox0 "" EEF7FE
    ${NSD_Check} $Ckbox0
    ${NSD_OnClick} $Ckbox0 Chklicense
    ${NSD_CreateLink} 134u 267u 57u 12u "�û����Э��"
    Pop $Txt_Xllicense
    SetCtlColors $Txt_Xllicense 13ABEE EEF7FE
    ${NSD_OnClick} $Txt_Xllicense xllicense

#------------------------------------------
#��ѡ��1
#------------------------------------------
    ${NSD_CreateCheckbox} 17u 216u 80u 12u "��������ͼ��"
    Pop $Ckbox1
    SetCtlColors $Ckbox1 ""  EEF7FE ;ǰ��ɫ,�������͸��
		ShowWindow $Ckbox1 ${SW_HIDE}
		${NSD_Check} $Ckbox1

#------------------------------------------
#��ѡ��2
#------------------------------------------
    ${NSD_CreateCheckbox} 130u 216u 80u 12u "��ӵ�����������"
    Pop $Ckbox2
    SetCtlColors $Ckbox2 ""  EEF7FE ;ǰ��ɫ,�������͸��
		ShowWindow $Ckbox2 ${SW_HIDE}
		${NSD_Check} $Ckbox2

		;������װĿ¼�����ı���
  	${NSD_CreateText} 21u 183u 290u 18u "${DIR}"
		Pop $Txt_Browser
		EnableWindow $Txt_Browser 0 ;�ı�������ֹ�����̼��� ��Ŀ���Ƿ�ֹ�û��ֶ�������Ч��Ŀ¼
		SetCtlColors $Txt_Browser ""  FFFFFF ;�������͸��
		;${NSD_AddExStyle} $Txt_Browser ${WS_EX_WINDOWEDGE}
    CreateFont $1 "tahoma" "11" "500"
    SendMessage $Txt_Browser ${WM_SETFONT} $1 1
		ShowWindow $Txt_Browser ${SW_HIDE}


    ;��������·���ļ��а�ť
    ${NSD_CreateButton} 314u 273U 79 19u  "���..."
		Pop $btn_Browser
		SkinBtn::Set /IMGID=$PLUGINSDIR\btn_browse.bmp $btn_Browser
		GetFunctionAddress $3 onClickSelectPath
    SkinBtn::onClick $btn_Browser $3
    SetCtlColors $btn_Browser 7F7F7F transparent ;ǰ��ɫ,�������͸��
    
    ShowWindow $btn_Browser ${SW_HIDE}


    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage1
    ${NSD_SetImage} $BGImage1 $PLUGINSDIR\bg2.bmp $ImageHandle1
    ShowWindow $BGImage1 ${SW_HIDE}

    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    WndProc::onCallback $BGImage1 $0 ;�����ޱ߿����ƶ�

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

		;������չͼƬ
    File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    File '/oname=$PLUGINSDIR\InstallingBG01.png' 'images\InstallingBG01.png'
    File '/oname=$PLUGINSDIR\InstallingBG02.png' 'images\InstallingBG02.png'
    File '/oname=$PLUGINSDIR\InstallingBG03.png' 'images\InstallingBG03.png'
    
    FindWindow $R2 "#32770" "" $HWNDPARENT
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $1 $R2 1027
    ShowWindow $1 ${SW_HIDE}
    StrCpy $R0 $R2 ;�ı�ҳ���С,��Ȼ��ͼ����ȫҳ
    #System::Call "user32::MoveWindow(i R0, i 0, i 0, i 588, i 438) i r2"
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 588, i 438) i r2"
    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $R0 $0 ;�����ޱ߿����ƶ�

    GetDlgItem $R0 $R2 1004  ;���ý�����λ��
    System::Call "user32::MoveWindow(i R0, i 30, i 350, i 537, i 12) i r2"

    GetDlgItem $R1 $R2 1006  ;����������ı�ǩ
    SetCtlColors $R1 "DC0000"  F0F0F0 ;�������F6F6F6,ע����ɫ������Ϊ͸���������ص�
    System::Call "user32::MoveWindow(i R1, i 30, i 330, i 290, i 12) i r2"

    GetDlgItem $R8 $R2 1016
    SetCtlColors $R8 ""  DC0000 ;�������F6F6F6,ע����ɫ������Ϊ͸���������ص�
    System::Call "user32::MoveWindow(i R8, i 0, i 0, i 588, i 438) i r2" ;����ͼ��������ҳ��

    FindWindow $R2 "#32770" "" $HWNDPARENT  ;��ȡ1995������ͼƬ
    GetDlgItem $R0 $R2 1995
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 498, i 373) i r2"
    ${NSD_SetImage} $R0 $PLUGINSDIR\bg2.bmp $ImageHandle

		;�����Ǹ���������ͼ
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $0 588 438 ;�ı�Page��С

    ;��������
    ${NSD_CreateButton} 80u 210u 160 54 ""
    Pop $btn_instend
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_express.bmp $btn_instend
    GetFunctionAddress $3 onClickexpress
    SkinBtn::onClick $btn_instend $3

    ;��װ���
    ${NSD_CreateButton} 210u 210u 160 54 ""
    Pop $btn_instend1
    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_finish.bmp $btn_instend1
    GetFunctionAddress $3 onClickend
    SkinBtn::onClick $btn_instend1 $3

    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg3.bmp $ImageHandle

    GetFunctionAddress $0 onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    nsDialogs::Show

    ${NSD_FreeImage} $ImageHandle

FunctionEnd


Function Page.4

FunctionEnd

Function un.installpageshow
		;������չͼƬ
    File '/oname=$PLUGINSDIR\Slides.dat' 'images\Slides.dat'
    File '/oname=$PLUGINSDIR\InstallingBG01.png' 'images\InstallingBG01.png'
    File '/oname=$PLUGINSDIR\InstallingBG02.png' 'images\InstallingBG02.png'
    File '/oname=$PLUGINSDIR\InstallingBG03.png' 'images\InstallingBG03.png'

  	FindWindow $R2 "#32770" "" $HWNDPARENT
    ShowWindow $0 ${SW_HIDE}
    GetDlgItem $1 $R2 1027
    ShowWindow $1 ${SW_HIDE}


    StrCpy $R0 $R2 ;�ı�ҳ���С,��Ȼ��ͼ����ȫҳ
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 588, i 588) i r2"
    GetFunctionAddress $0 un.onGUICallback
    WndProc::onCallback $R0 $0 ;�����ޱ߿����ƶ�

    GetDlgItem $R0 $R2 1004  ;���ý�����λ��
    System::Call "user32::MoveWindow(i R0, i 30, i 350, i 537, i 12) i r2"

    GetDlgItem $R1 $R2 1006  ;����������ı�ǩ
    SetCtlColors $R1 "DC0000"  F0F0F0 ;�������F6F6F6,ע����ɫ������Ϊ͸���������ص�
    System::Call "user32::MoveWindow(i R1, i 30, i 370, i 290, i 12) i r2"
    

    GetDlgItem $R8 $R2 1016
    ;SetCtlColors $R8 ""  F6F6F6 ;�������F6F6F6,ע����ɫ������Ϊ͸���������ص�
    System::Call "user32::MoveWindow(i R8, i 0, i 0, i 588, i 438) i r2"



    FindWindow $R2 "#32770" "" $HWNDPARENT  ;��ȡ1995������ͼƬ
    GetDlgItem $R0 $R2 1995
    System::Call "user32::MoveWindow(i R0, i 0, i 0, i 498, i 373) i r2"
    ${NSD_SetImage} $R0 $PLUGINSDIR\bg2.bmp $ImageHandle

		;�����Ǹ���������ͼ
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $0 588 438 ;�ı�Page��С


    ;ж�����
    ${NSD_CreateButton} 126u 204u 252 64 "ж�����"
    Pop $btn_in
    #SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_in
    GetFunctionAddress $3 un.Abort ;���������һ��
    SkinBtn::onClick $btn_in $3
    #SkinBtn::onClick Abort

    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg4.bmp $ImageHandle

    GetFunctionAddress $0 un.onGUICallback
    WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
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
    SetCtlColors $0 ""  transparent ;�������͸��

    ${NSW_SetWindowSize} $0 588 438 ;�ı�Page��С

  	;ж��ȷ��
    ${NSD_CreateButton} 60u 215u 120u 30u "�ݲ�ж��"
    Pop $btn_incancle
#    SkinBtn::Set /IMGID=$PLUGINSDIR\btn_strongbtn.bmp $btn_incancle
    GetFunctionAddress $3 un.noremove ;����˳�
    SkinBtn::onClick $btn_incancle $3

    ;ж��ȷ��
    ${NSD_CreateButton} 200u 215u 120u 30u "ȷ��ж��"
    Pop $btn_in
    #SkinBtn::Set /IMGID=$PLUGINSDIR\btn_weakbtn.bmp $btn_in
    GetFunctionAddress $3 un.remove ;���������һ��
    SkinBtn::onClick $btn_in $3

    ;��������ͼ
    ${NSD_CreateBitmap} 0 0 100% 100% ""
    Pop $BGImage
    ${NSD_SetImage} $BGImage $PLUGINSDIR\bg.bmp $ImageHandle

 #   GetFunctionAddress $0 onGUICallback
 #   WndProc::onCallback $BGImage $0 ;�����ޱ߿����ƶ�
    nsDialogs::Show

    ${NSD_FreeImage} $ImageHandle

FunctionEnd

Function ABORT
MessageBox MB_ICONQUESTION|MB_YESNO|MB_ICONSTOP '��ȷ��Ҫ�˳�"���ϴ������ϵͳ"��װ����' IDNO CANCEL
SendMessage $hwndparent ${WM_CLOSE} 0 0
CANCEL:
Abort
FunctionEnd

;����ҳ����ת������
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
	#��ⰲװĿ¼�Ƿ�Ϸ� ͨ������Ŀ¼�ռ�ʵ��
	${NSD_GetText} $Txt_Browser  $R0  ;������õİ�װ·��
	StrCpy $INSTDIR $R0
	${GetRoot} "$INSTDIR" $R3 ;��ȡ��װ��Ŀ¼
	StrCpy $R0 "$R3\"
	${DriveSpace} "$R3\" "/D=F  /S=M" $R0 ;��ȡָ���̷���ʣ����ÿռ� �� /D=Fʣ��ռ� /S=M ��λM�ֽ�
	${if} $R0 < 100
		MessageBox MB_OK|MB_ICONEXCLAMATION "ָ������ʣ��ռ䲻�㣬 ��ѡ������������װ��"
		Abort
	${endif}

   ;�ж�Ŀ¼�Ƿ���ȷ
#	ClearErrors
#	CreateDirectory "$INSTDIR"
#	IfErrors 0 +3
#  MessageBox MB_ICONINFORMATION|MB_OK "'$INSTDIR' ��װĿ¼�����ڣ����������á�"
#  Abort
#	StrCpy $INSTDIR  $R0  ;���氲װ·��

  StrCpy $R9 1 ;Goto the next page
  Call RelGotoPage
  Abort
FunctionEnd

;�������Զ��尲װ�����غ���ʾһ���ֿؼ�
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

;�������ʱ������ʾ���ֿؼ�
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
#���Э��
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

;���Э���·��İ�ťִ��
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

;���������Э���µ�ȷ����ťִ��
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
#�Ƿ�ѡ�����Э���ж�
#------------------------------------------
Function Chklicense
  Pop $Ckbox0
  ${NSD_GetState} $Ckbox0 $0
  ${If} $0 == 1
    EnableWindow $btn_ins 1 ;��ָ���Ĵ��ڻ�ؼ��Ƿ��������0��ֹ
    EnableWindow $btn_in 1
  ${Else}
    EnableWindow $btn_ins 0 ;��ָ���Ĵ��ڻ�ؼ��Ƿ��������0��ֹ
    EnableWindow $btn_in 0
  ${EndIf}
FunctionEnd


#--------------------------------------------------------
# ·��ѡ��ť�¼�����Windowsϵͳ�Դ���Ŀ¼ѡ��Ի���
#--------------------------------------------------------
Function onClickSelectPath


	 ${NSD_GetText} $Txt_Browser  $0
   nsDialogs::SelectFolderDialog  "��ѡ�� ${PRODUCT_NAME} ��װĿ¼��"  "$0"
   Pop $0
   ${IfNot} $0 == error
			${NSD_SetText} $Txt_Browser  $0
	${EndIf}

FunctionEnd

;����������
Function onClickexpress
${NSD_GetState} $Ckbox4 $0
    ${If} $0 == 1
  	MessageBox MB_OK 'ѡ�У������Զ�����' ;�ж�ѡ��ʱ�Ĳ���,ʵ�ʴ�����Ҫ�Լ��޸�
  ${EndIf}
${NSD_GetState} $Ckbox5 $0
  ${if} $0 = 1
  MessageBox MB_OK 'ѡ�У��Ƽ���װ' ;�ж�ѡ��ʱ�Ĳ���,ʵ�ʴ�����Ҫ�Լ��޸�
  ${EndIf}
Exec "$INSTDIR\MdCode.exe" ;�������Ҫѡ��Ҳ������������
#MessageBox MB_OK '�������������������ϵͳ'
#ExecShell "open" "http://www.maidiyun.com"
SendMessage $hwndparent ${WM_CLOSE} 0 0  ;�رհ�װ���ҳ�� ${WM_CLOSE}����16����
FunctionEnd

;���ҳ����ɰ�ť
Function onClickend
${NSD_GetState} $Ckbox4 $0
#    ${If} $0 == 1
#  	MessageBox MB_OK 'ѡ�У������Զ�����' ;�ж�ѡ��ʱ�Ĳ���,ʵ�ʴ�����Ҫ�Լ��޸�
#  ${EndIf}
#${NSD_GetState} $Ckbox5 $0
#  ${if} $0 = 1
#  MessageBox MB_OK 'ѡ�У��Ƽ���װ' ;�ж�ѡ��ʱ�Ĳ���,ʵ�ʴ�����Ҫ�Լ��޸�
#  ${EndIf}
;ExecShell "open" "http://www.nsisfans.com/"
SendMessage $hwndparent ${WM_CLOSE} 0 0
FunctionEnd

Function .onInstSuccess
  ExecShell "" "$INSTDIR\MdCode.exe"
FunctionEnd

#--;��ʼж��ʱ��飺--#
Function un.onInit
FindProcDLL::FindProc "MdCode.exe"
   Pop $R0
   IntCmp $R0 1 0 no_run
   MessageBox MB_ICONSTOP "��װ�����⵽ ${PRODUCT_NAME} �������У����˳����������"
   Quit
   no_run:
#     MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
#  Abort
FunctionEnd
