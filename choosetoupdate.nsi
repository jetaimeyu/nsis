; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ��װ�����ʼ���峣��
!define PRODUCT_NAME "��������"
!define PRODUCT_VERSION "1.2"
!define PRODUCT_PUBLISHER "������Ϣ�������޹�˾"
!define PRODUCT_WEB_SITE "http://www.maidiyun.com"


SetCompressor /SOLID zlib

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON "Icon\MD_Setup.ico"
;!define MUI_UNICON "Icon\Uninstall.ico"

; ��ӭҳ��
!insertmacro MUI_PAGE_WELCOME
; ���Э��ҳ��
;!insertmacro MUI_PAGE_LICENSE "rtf\license.txt"
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
;!define MUI_FINISHPAGE_RUN "$INSTDIR\AutoTask.exe"
!insertmacro MUI_PAGE_FINISH

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile  "${PRODUCT_NAME} ${PRODUCT_VERSION}.exe" ;Ӧ�ó�������ļ���
;InstallDir "$PROGRAMFILES\ͬ������"
InstallDir ""
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails show
ShowUnInstDetails show
BrandingText "ͬ��������԰�װ"

Section "MainSection" SEC01

  SetDetailsPrint textonly
  DetailPrint "�������� ${PRODUCT_NAME}���뵥���رհ�ť���������"
  SetDetailsPrint listonly

  SectionIn RO
  SetOutPath "$INSTDIR"
  ;SetOverwrite ifnewer
  ;�����ļ�
  File "code\username.txt"
  File "code\*.*"

SectionEnd





