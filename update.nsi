

!define PRODUCT_NAME "ͬ������"
!define PRODUCT_VERSION "1.0.0.1"

SetCompressor lzma
SetFont "tahoma" 8
RequestExecutionLevel admin

!include "MUI2.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON "Icon\MD_Setup.ico"
!define MUI_UNICON "Icon\Uninstall.ico"

!insertmacro MUI_LANGUAGE "SimpChinese"

Name "${PRODUCT_NAME}_����_${PRODUCT_VERSION}"
OutFile "${PRODUCT_NAME}_����_${PRODUCT_VERSION}.exe"
InstallDirRegKey HKCU "Software\autotask" ""

Section "�����ļ�" SEC01

  SetDetailsPrint textonly
  DetailPrint "�������� ${PRODUCT_NAME}���뵥���رհ�ť���������"
  SetDetailsPrint listonly

  SectionIn RO
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ;�����ļ�
  File "release\username.txt"
  File "release\*.*"

SectionEnd


Function un.onInit
	;�ж��Ƿ��Ѱ�װ
	ReadRegStr $0 HKCU "Software\autotask" ""
	StrCmp $0 "" 0 NoAbort
	  MessageBox MB_OK|MB_ICONEXCLAMATION "��δ��ȷ��װautotask�����������ʹ�ô���������"
	  Abort ;�˳���װ����
	NoAbort:


	;�رս���
	Push $R0
	CheckProc:
	  Push "${PRODUCT_NAME}_����_${PRODUCT_VERSION}.exe"
	  ProcessWork::existsprocess
	  Pop $R0
	  IntCmp $R0 0 Done
	  MessageBox MB_OKCANCEL|MB_ICONSTOP "���������⵽ ${PRODUCT_NAME} �������С�$\r$\n$\r$\n��� ��ȷ���� ǿ�ƹر�${PRODUCT_NAME}������������$\r$\n��� ��ȡ���� �˳���װ����" IDCANCEL Exit
	  Push "�������.exe"
	  Processwork::KillProcess
	  Sleep 1000
	  Goto CheckProc
	  Exit:
	  Abort
	  Done:
	  Pop $R0

	InitPluginsDir
  ;���������ֹ�ظ�����
  System::Call 'kernel32::CreateMutexA(i 0, i 0, t "�������_installer") i .r1 ?e'
  Pop $R0
  StrCmp $R0 0 +3
    MessageBox MB_OK|MB_ICONEXCLAMATION "��һ�� ${PRODUCT_NAME} ���������Ѿ����У�"
    Abort
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
  Abort
  
  
FunctionEnd
