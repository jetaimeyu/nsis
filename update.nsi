

!define PRODUCT_NAME "ͬ������"
!define PRODUCT_VERSION "1.0.0.1"

SetCompressor lzma
SetFont "tahoma" 8
RequestExecutionLevel admin

!include "MUI2.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
;���尲װ����ͼ��
!define MUI_ICON "Icon\MD_Setup.ico"
;����ж�س���ͼ��
;!define MUI_UNICON "Icon\Uninstall.ico"

!insertmacro MUI_LANGUAGE "SimpChinese"

;!insertmacro MUI_PAGE_WELCOME
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES

InstallDir "$PROGRAMFILES\ͬ������"
Name "${PRODUCT_NAME}_����_${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}_����_${PRODUCT_VERSION}.exe"
;InstallDirRegKey HKCU "Software\autotask" ""
BrandingText "������Ϣ�������޹�˾"

Section "�����ļ�" SEC01

  SetDetailsPrint textonly
  DetailPrint "�������� ${PRODUCT_NAME}���뵥���رհ�ť���������"
  SetDetailsPrint listonly

  SectionIn RO
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ;�����ļ�
  File  "code\username.txt"
  ;File /r "release\*.*"

SectionEnd

Section .onInit
	;��ֹ�����װ����ʵ��
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "autotaskupdate") i .r1 ?e'
	Pop $R0
	StrCmp $R0 0 +3
	MessageBox MB_OK|MB_ICONEXCLAMATION "autotask���³����Ѿ������С�"
	Abort

	;��ֹ�ظ���װ����
	/**
	ReadRegStr $0 HKLM '${PRODUCT_DIR_REGKEY}' ""
	StrLen $1 $0
	IntCmp $1 0 +3 +1 +1
	MessageBox MB_OK|MB_USERICON '$(^Name) �Ѱ�װ�ڼ�����С��������°�װ����ж�����еİ�װ'
	Quit
	*/

	ReadRegStr $0 HKCU "Software\autotask" ""
	StrCmp $0 "" 0 NoAbort
	  MessageBox MB_OK|MB_ICONEXCLAMATION "��δ��ȷ��װautotask�����������ʹ�ô���������"
	  Abort ;�˳���װ����
	NoAbort:

SectionEnd


