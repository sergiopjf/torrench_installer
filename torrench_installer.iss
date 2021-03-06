; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{661C6009-A24E-4599-ADE9-2C3EDABB34D0}
AppName=Torrench
AppVersion=1.0
AppPublisherURL=https://github.com/kryptxy/torrench
AppSupportURL=https://github.com/kryptxy/torrench/issues
AppUpdatesURL=https://github.com/kryptxy/torrench/releases
DefaultDirName={pf}\Torrench
DefaultGroupName=Torrench
AllowNoIcons=yes
OutputDir=D:\Temp
OutputBaseFilename=torrench_setup
Compression=lzma
SolidCompression=yes
SetupLogging=yes

#include <idp.iss>

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"


[Files]
Source: "run_torrench.bat"; DestDir: "{app}"; Flags: ignoreversion;
Source: "config.ini"; DestDir: "{tmp}"; Flags: ignoreversion;
Source: "copy_config.bat"; DestDir: "{tmp}"; Flags: ignoreversion;
Source: "version.ps1"; DestDir: "{tmp}"; Flags: ignoreversion dontcopy deleteafterinstall;
Source: "pre_install.bat"; DestDir: "{tmp}"; Flags: ignoreversion dontcopy deleteafterinstall;
 
[Icons]
Name: "{group}\Torrench"; Filename: "{app}\run_torrench.bat"; IconFilename: "{app}\torrench.exe"
Name: "{group}\{cm:UninstallProgram,Torrench}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\Torrench"; Filename: "{app}\run_torrench.bat"; WorkingDir: "{app}"; IconFilename: "{app}\torrench.exe"

[Run]
Filename: "{tmp}\copy_config.bat"; Flags: runhidden hidewizard waituntilterminated
Filename: "{app}\run_torrench.bat"; Description: "{cm:LaunchProgram,Torrench}"; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: files; Name: "{app}\*.*"

[Code]
var
  Version: String;
  Version2: String;
  Version3: String;
  
function InitializeSetup: Boolean;
var
  ResultCode: integer;
 
begin
  ExtractTemporaryFile('pre_install.bat');
  FileCopy(ExpandConstant('{tmp}\pre_install.bat'), ExpandConstant('pre_install.bat'), false);
  DeleteFile('pre_install.bat');
  ExtractTemporaryFile('version.ps1');
  FileCopy(ExpandConstant('{tmp}\version.ps1'), ExpandConstant('version.ps1'), false);
  DeleteFile('version.ps1');
  Result := True;
  
  if Exec(ExpandConstant('{tmp}\pre_install.bat'), '', '', SW_HIDE,
     ewWaitUntilTerminated, ResultCode) then
  begin
      LoadStringFromFile(ExpandConstant('{tmp}\url.txt'), Version);
      Version2 := Copy(Version,2,length(Version));
      Version3 := 'torrench-' + Version2 + '.exe'
      log(Version);
      log(Version2);
      log(Version3);
      
  end
  else begin
    // handle failure if necessary; ResultCode contains the error code
  end;

  // Proceed Setup
  Result := True;

end;

procedure InitializeWizard();
begin
    idpAddFile('https://github.com/kryptxy/torrench/releases/download/' + String(Version) + '/torrench-' + String(Version2) + '.exe', ExpandConstant('{tmp}\torrench-' + Version2 + '.exe'));
    idpDownloadAfter(wpReady);
end;


procedure CurStepChanged(CurStep: TSetupStep);
begin
    if CurStep = ssPostInstall then 
    begin
        // Copy downloaded files to application directory
        FileCopy(ExpandConstant('{tmp}\torrench-' + String(Version2) + '.exe'), ExpandConstant('{app}\torrench.exe'), false);
     end;
end;
