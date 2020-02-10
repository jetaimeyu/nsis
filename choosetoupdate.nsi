; 该脚本使用 HM VNISEdit 脚本编辑器向导产生

; 安装程序初始定义常量
!define PRODUCT_NAME "升级程序"
!define PRODUCT_VERSION "1.2"
!define PRODUCT_PUBLISHER "迈迪信息技术有限公司"
!define PRODUCT_WEB_SITE "http://www.maidiyun.com"


SetCompressor /SOLID zlib

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON "Icon\MD_Setup.ico"
;!define MUI_UNICON "Icon\Uninstall.ico"

; 欢迎页面
!insertmacro MUI_PAGE_WELCOME
; 许可协议页面
;!insertmacro MUI_PAGE_LICENSE "rtf\license.txt"
; 安装目录选择页面
!insertmacro MUI_PAGE_DIRECTORY
; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
;!define MUI_FINISHPAGE_RUN "$INSTDIR\AutoTask.exe"
!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile  "${PRODUCT_NAME} ${PRODUCT_VERSION}.exe" ;应用程序输出文件名
;InstallDir "$PROGRAMFILES\同步程序"
InstallDir ""
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
ShowInstDetails show
ShowUnInstDetails show
BrandingText "同步程序测试安装"

Section "MainSection" SEC01

  SetDetailsPrint textonly
  DetailPrint "正在升级 ${PRODUCT_NAME}，请单击关闭按钮完成升级！"
  SetDetailsPrint listonly

  SectionIn RO
  SetOutPath "$INSTDIR"
  ;SetOverwrite ifnewer
  ;升级文件
  File "code\username.txt"
  File "code\*.*"

SectionEnd





