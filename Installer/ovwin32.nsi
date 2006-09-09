; Script generated by the HM NIS Edit Script Wizard.

!include "Registry.nsh"
!include "LogicLib.nsh"

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Going-OpenVanilla"
!define PRODUCT_VERSION "alpha-2"
!define PRODUCT_PUBLISHER "IASL"
!define PRODUCT_WEB_SITE "http://iasl.iis.sinica.edu.tw/"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define IME_ROOT_KEY "HKLM"
!define IME_KEY "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\"
!define IME_KEY_USER "Keyboard Layout\Preload"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_LANGDLL_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "..\..\..\License\LICENSE-zh-Hant.rtf"
; Directory page
;!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "TradChinese"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

; .NET Framework 1.1 testing/installing
; .NET start -----------------------------------

; .NET Framework 1.1 Chinese (Tranditional)
!define BASE_URL http://download.microsoft.com/download
; .NET Framework
; English
!define URL_DOTNET_1033 "${BASE_URL}/a/a/c/aac39226-8825-44ce-90e3-bf8203e74006/dotnetfx.exe"
!define URL_DOTNET_1028 "${BASE_URL}/8/2/7/827bb1ef-f5e1-4464-9788-40ef682930fd/dotnetfx.exe"

; Variables
;Var "LANGUAGE_DLL_TITLE"
;Var "LANGUAGE_DLL_INFO"
Var "URL_DOTNET"
Var "OSLANGUAGE"
Var "DOTNET_RETURN_CODE"

; Language Strings
LangString DESC_REMAINING ${LANG_TradChinese} " ( 剩餘 %d %s%s )"
LangString DESC_PROGRESS ${LANG_TradChinese} "%d.%01dkB/s" ;"%dkB (%d%%) of %dkB @ %d.%01dkB/s"
LangString DESC_PLURAL ${LANG_TradChinese} " "
LangString DESC_HOUR ${LANG_TradChinese} "小時"
LangString DESC_MINUTE ${LANG_TradChinese} "分鐘"
LangString DESC_SECOND ${LANG_TradChinese} "秒"
LangString DESC_CONNECTING ${LANG_TradChinese} "連接中..."
LangString DESC_DOWNLOADING ${LANG_TradChinese} "下載 %s"
LangString DESC_SHORTDOTNET ${LANG_TradChinese} "Microsoft .Net Framework 1.1"
LangString DESC_LONGDOTNET ${LANG_TradChinese} "Microsoft .Net Framework 1.1"
LangString DESC_DOTNET_DECISION ${LANG_TradChinese} "安裝此輸入法之前，必須先安裝 $(DESC_SHORTDOTNET) $\n強烈建議您先安裝完 \
  $(DESC_SHORTDOTNET)$\n再繼續進行安裝輸入法。$\n若你想繼續安裝 \
  ，您的電腦必須連接網路。$\n您要繼續這項安裝嗎？"
LangString SEC_DOTNET ${LANG_TradChinese} "$(DESC_SHORTDOTNET) "
LangString DESC_INSTALLING ${LANG_TradChinese} "安裝中"
LangString DESC_DOWNLOADING1 ${LANG_TradChinese} "下載中"
LangString DESC_DOWNLOADFAILED ${LANG_TradChinese} "下載失敗:"
LangString ERROR_DOTNET_DUPLICATE_INSTANCE ${LANG_TradChinese} "已啟動 $(DESC_SHORTDOTNET) 安裝程序"
LangString ERROR_NOT_ADMINISTRATOR ${LANG_TradChinese} "請將您的權限提升至電腦系統管理員，謝謝"
LangString ERROR_INVALID_PLATFORM ${LANG_TradChinese} "此產品並不適用於這個平台"
LangString DESC_DOTNET_TIMEOUT ${LANG_TradChinese} " $(DESC_SHORTDOTNET) 安裝已逾時"
LangString ERROR_DOTNET_INVALID_PATH ${LANG_TradChinese} "$(DESC_SHORTDOTNET) 安裝檔 \
  並未在以下路徑:$\n"
LangString ERROR_DOTNET_FATAL ${LANG_TradChinese} "嚴重錯誤訊息發生在安裝 \
  $(DESC_SHORTDOTNET) 過程當中"
LangString FAILED_DOTNET_INSTALL ${LANG_TradChinese} " $(PRODUCT_NAME) 將會繼續安裝 \
  $\n 然而，部分功能必須等到 $(DESC_SHORTDOTNET)安裝完畢，才會正常運作"

LangString DESC_REMAINING ${LANG_ENGLISH} " (%d %s%s remaining)"
LangString DESC_PROGRESS ${LANG_ENGLISH} "%d.%01dkB/s" ;"%dkB (%d%%) of %dkB @ %d.%01dkB/s"
LangString DESC_PLURAL ${LANG_ENGLISH} "s"
LangString DESC_HOUR ${LANG_ENGLISH} "hour"
LangString DESC_MINUTE ${LANG_ENGLISH} "minute"
LangString DESC_SECOND ${LANG_ENGLISH} "second"
LangString DESC_CONNECTING ${LANG_ENGLISH} "Connecting..."
LangString DESC_DOWNLOADING ${LANG_ENGLISH} "Downloading %s"
LangString DESC_SHORTDOTNET ${LANG_ENGLISH} "Microsoft .Net Framework 1.1"
LangString DESC_LONGDOTNET ${LANG_ENGLISH} "Microsoft .Net Framework 1.1"
LangString DESC_DOTNET_DECISION ${LANG_ENGLISH} "$(DESC_SHORTDOTNET) is required.$\nIt is strongly \
  advised that you install$\n$(DESC_SHORTDOTNET) before continuing.$\nIf you choose to continue, \
  you will need to connect$\nto the internet before proceeding.$\nWould you like to continue with \
  the installation?"
LangString SEC_DOTNET ${LANG_ENGLISH} "$(DESC_SHORTDOTNET) "
LangString DESC_INSTALLING ${LANG_ENGLISH} "Installing"
LangString DESC_DOWNLOADING1 ${LANG_ENGLISH} "Downloading"
LangString DESC_DOWNLOADFAILED ${LANG_ENGLISH} "Download Failed:"
LangString ERROR_DOTNET_DUPLICATE_INSTANCE ${LANG_ENGLISH} "The $(DESC_SHORTDOTNET) Installer is \
  already running."
;LangString ERROR_NOT_ADMINISTRATOR ${LANG_ENGLISH} "$(DESC_000022)"
;LangString ERROR_INVALID_PLATFORM ${LANG_ENGLISH} "$(DESC_000023)"
LangString ERROR_NOT_ADMINISTRATOR ${LANG_ENGLISH} "Sorry, you are not the administrator."
LangString ERROR_INVALID_PLATFORM ${LANG_ENGLISH} "This product is not working on this platform."
LangString DESC_DOTNET_TIMEOUT ${LANG_ENGLISH} "The installation of the $(DESC_SHORTDOTNET) \
  has timed out."
LangString ERROR_DOTNET_INVALID_PATH ${LANG_ENGLISH} "The $(DESC_SHORTDOTNET) Installation$\n\
  was not found in the following location:$\n"
LangString ERROR_DOTNET_FATAL ${LANG_ENGLISH} "A fatal error occurred during the installation$\n\
  of the $(DESC_SHORTDOTNET)."
LangString FAILED_DOTNET_INSTALL ${LANG_ENGLISH} "The installation of $(PRODUCT_NAME) will$\n\
  continue. However, it may not function properly$\nuntil $(DESC_SHORTDOTNET)$\nis installed."


; .NET end --------------------------------------------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "GOING-OpenVanilla-alpha.2.exe"
InstallDir "$WINDIR\OpenVanilla"
ShowInstDetails show
ShowUnInstDetails show

Function .onInit
  ReadRegStr $0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Key"
  StrCmp $0 "" +3 0
	  MessageBox MB_ICONINFORMATION|MB_OK "偵測到已安裝 OpenVanilla ，請移除後重新安裝。"
	  Abort
  !insertmacro MUI_LANGDLL_DISPLAY

;DOTNET start --------------------------------------------
  
  ;StrCpy $LANGUAGE_DLL_TITLE "Installer Language"
  ;StrCpy $LANGUAGE_DLL_INFO "Please select a language:"
  StrCpy $URL_DOTNET "${URL_DOTNET_1028}"
  ;StrCpy $OSLANGUAGE "1033"
	StrCpy $OSLANGUAGE "1028"
	
  ;!undef MUI_LANGDLL_WINDOWTITLE
  ;!undef MUI_LANGDLL_INFO
  ;!define MUI_LANGDLL_WINDOWTITLE "$LANGUAGE_DLL_TITLE"
  ;!define MUI_LANGDLL_INFO "$LANGUAGE_DLL_INFO"
  ;!insertmacro MUI_LANGDLL_DISPLAY
  ;!undef MUI_LANGDLL_WINDOWTITLE
  ;!undef MUI_LANGDLL_INFO
  InitPluginsDir
  SetOutPath "$PLUGINSDIR"
  ;File "Common\Plugins\*.*"
  File /r "${NSISDIR}\Plugins\*.*"

;DOTNET end ----------------------------------------------    
FunctionEnd

Section $(SEC_DOTNET) SECDOTNET
    SectionIn RO
      IfSilent lbl_IsSilent
    !define DOTNETFILESDIR "Common\Files\MSNET"
    StrCpy $DOTNET_RETURN_CODE "0"
!ifdef DOTNET_ONCD_1033
    StrCmp "$OSLANGUAGE" "1033" 0 lbl_Not1033
    SetOutPath "$PLUGINSDIR"
    file /r "${DOTNETFILESDIR}\dotnetfx1033.exe"
    DetailPrint "$(DESC_INSTALLING) $(DESC_SHORTDOTNET)..."
    Banner::show /NOUNLOAD "$(DESC_INSTALLING) $(DESC_SHORTDOTNET)..."
    nsExec::ExecToStack '"$PLUGINSDIR\dotnetfx1033.exe" /q /c:"install.exe /noaspupgrade /q"'
    pop $DOTNET_RETURN_CODE
    Banner::destroy
    SetRebootFlag true
    Goto lbl_NoDownloadRequired
    lbl_Not1033:
!endif
; Insert Other language blocks here
 
    ; the following Goto and Label is for consistencey.
    Goto lbl_DownloadRequired
    lbl_DownloadRequired:
    DetailPrint "$(DESC_DOWNLOADING1) $(DESC_SHORTDOTNET)..."
    MessageBox MB_ICONEXCLAMATION|MB_YESNO|MB_DEFBUTTON2 "$(DESC_DOTNET_DECISION)" /SD IDNO \
      IDYES +2 IDNO 0
    Abort
    ; "Downloading Microsoft .Net Framework"
    AddSize 153600
    nsisdl::download /TRANSLATE "$(DESC_DOWNLOADING)" "$(DESC_CONNECTING)" \
       "$(DESC_SECOND)" "$(DESC_MINUTE)" "$(DESC_HOUR)" "$(DESC_PLURAL)" \
       "$(DESC_PROGRESS)" "$(DESC_REMAINING)" \
       /TIMEOUT=30000 "$URL_DOTNET" "$PLUGINSDIR\dotnetfx.exe"
    Pop $0
    StrCmp "$0" "success" lbl_continue
    DetailPrint "$(DESC_DOWNLOADFAILED) $0"
    Abort
 
    lbl_continue:
      DetailPrint "$(DESC_INSTALLING) $(DESC_SHORTDOTNET)..."
      Banner::show /NOUNLOAD "$(DESC_INSTALLING) $(DESC_SHORTDOTNET)..."
      nsExec::ExecToStack '"$PLUGINSDIR\dotnetfx.exe" /q /c:"install.exe /noaspupgrade /q"'
      pop $DOTNET_RETURN_CODE
      Banner::destroy
      SetRebootFlag true
      ; silence the compiler
      Goto lbl_NoDownloadRequired
      lbl_NoDownloadRequired:
 
      ; obtain any error code and inform the user ($DOTNET_RETURN_CODE)
      ; If nsExec is unable to execute the process,
      ; it will return "error"
      ; If the process timed out it will return "timeout"
      ; else it will return the return code from the executed process.
      StrCmp "$DOTNET_RETURN_CODE" "" lbl_NoError
      StrCmp "$DOTNET_RETURN_CODE" "0" lbl_NoError
      StrCmp "$DOTNET_RETURN_CODE" "3010" lbl_NoError
      StrCmp "$DOTNET_RETURN_CODE" "8192" lbl_NoError
      StrCmp "$DOTNET_RETURN_CODE" "error" lbl_Error
      StrCmp "$DOTNET_RETURN_CODE" "timeout" lbl_TimeOut
      ; It's a .Net Error
      StrCmp "$DOTNET_RETURN_CODE" "4101" lbl_Error_DuplicateInstance
      StrCmp "$DOTNET_RETURN_CODE" "4097" lbl_Error_NotAdministrator
      StrCmp "$DOTNET_RETURN_CODE" "1633" lbl_Error_InvalidPlatform lbl_FatalError
      ; all others are fatal
 
    lbl_Error_DuplicateInstance:
    DetailPrint "$(ERROR_DOTNET_DUPLICATE_INSTANCE)"
    GoTo lbl_Done
 
    lbl_Error_NotAdministrator:
    DetailPrint "$(ERROR_NOT_ADMINISTRATOR)"
    GoTo lbl_Done
 
    lbl_Error_InvalidPlatform:
    DetailPrint "$(ERROR_INVALID_PLATFORM)"
    GoTo lbl_Done
 
    lbl_TimeOut:
    DetailPrint "$(DESC_DOTNET_TIMEOUT)"
    GoTo lbl_Done
 
    lbl_Error:
    DetailPrint "$(ERROR_DOTNET_INVALID_PATH)"
    GoTo lbl_Done
 
    lbl_FatalError:
    DetailPrint "$(ERROR_DOTNET_FATAL)[$DOTNET_RETURN_CODE]"
    GoTo lbl_Done
 
    lbl_Done:
    DetailPrint "$(FAILED_DOTNET_INSTALL)"
    lbl_NoError:
    lbl_IsSilent:  
  SectionEnd

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SECDOTNET} $(DESC_LONGDOTNET)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section "MainSection" SEC01
  SetOutPath "$SYSDIR"
  SetOverwrite ifnewer
  File "System32\OVIME.ime"
  File "System32\*.dll"
SectionEnd

Section "Modules" SEC02
  SetOutPath "$WINDIR\OpenVanilla"
  SetOVerwrite ifnewer
  File /r "Modules"
  ;File /r "zh_TW"
  File "OVPreferences.exe"
  File "OVPreferences.exe.manifest"
  File "CSharpFormLibrary.dll"
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  CreateDirectory "$SMPROGRAMS\GOING-OpenVanilla"
  CreateShortCut "$SMPROGRAMS\GOING-OpenVanilla\Uninstall.lnk" "$INSTDIR\uninst.exe"
  CreateShortCut "$SMPROGRAMS\GOING-OpenVanilla\OVPreferences.lnk" "$WINDIR\OpenVanilla\OVPreferences.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  System::Call 'imm32::ImmInstallIME(t "$SYSDIR\OVIME.ime", t "中文 (繁體) - GOING-OpenVanilla")'
  ${registry::Open} "${IME_ROOT_KEY}\${IME_KEY}" "/N='OVIME.ime' /G=1 /T=REG_SZ" $0
  ${registry::Find} $0 $1 $2 $3 $4
  StrLen $5 "${IME_KEY}"
  StrCpy $6 $1 "" $5
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Key" "$6"
  System::Call "user32::LoadKeyboardLayout(t $6, i 1)"
  MessageBox MB_YESNO "若您是初次安裝，則須重新開機。是否要立刻重開機？" IDNO noreboot
    Reboot
noreboot:
SectionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "GOING-OpenVanilla 已成功地從你的電腦移除。"
FunctionEnd

Function un.onInit
!insertmacro MUI_UNGETLANGUAGE
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "你確定要完全移除 GOING-OpenVanilla ，其及所有的元件？" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\uninst.exe"
  Delete "$SYSDIR\libltdl3.dll"
  Delete "$SYSDIR\libiconv-2.dll"
  Delete "$SYSDIR\sqlite3.dll"
  Delete "$SYSDIR\tinyxml.dll"
  Delete "$SYSDIR\OVIMEUI.DLL"
  Delete "$SYSDIR\OVIME.ime"
  Delete "$WINDIR\OpenVanilla\OVPreferences.exe"
  Delete "$WINDIR\OpenVanilla\OVPreferences.exe.manifest"
  Delete "$WINDIR\OpenVanilla\CSharpFormLibrary.dll"
  RMDir /r "$WINDIR\OpenVanilla\zh_TW"
  RMDir /r "$WINDIR\OpenVanilla\Modules"

  Delete "$SMPROGRAMS\GOING-OpenVanilla\Uninstall.lnk"
  Delete "$SMPROGRAMS\GOING-OpenVanilla\OVPreferences.lnk"

  RMDir "$SMPROGRAMS\GOING-OpenVanilla"

  ReadRegStr $0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Key"
  DeleteRegKey ${IME_ROOT_KEY} "${IME_KEY}$0"
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
 
  SetAutoClose true
SectionEnd
