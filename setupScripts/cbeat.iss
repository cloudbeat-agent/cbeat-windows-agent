; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Cloudbeat Agent"
#define MyAppVersion "1.0"
#define MyAppPublisher "Cloudbeat"
#define MyAppURL "https://cloudbeat.me"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{B07B4F6A-A4BD-4E83-ABBC-5416976DD74A}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\Cloudbeat
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=C:\Users\artur\Desktop\CloudbeatAgent
OutputBaseFilename=cloudbeat_agent
SetupIconFile=C:\Users\artur\Desktop\CloudbeatAgent\assets\cloudbeat.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Files]
Source: "C:\Users\artur\Desktop\CloudbeatAgent\assets\files\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{group}\{cm:ReconfigureAgent}"; Filename: "{app}\configure.cmd"

[CustomMessages]
english.ServerInfo=Server information
english.FillServerInfo=Please fill the fields below to configure your Cloudbeat Agent.
english.ServerKey=Server key
english.CloudbeatUrl=Cloudbeat URL (Ex.: https://mine.cloudbeat.me)
english.ReconfigureAgent=Reconfigure Cloudbeat Agent
brazilianportuguese.ServerInfo=Informa��es do servidor
brazilianportuguese.FillServerInfo=Por favor, preencha os campos abaixo par configurar o Agente do Cloudbeat.
brazilianportuguese.ServerKey=Chave do servidor
brazilianportuguese.CloudbeatUrl=URL do Cloudbeat (Ex.: https://meu.cloudbeat.me)
brazilianportuguese.ReconfigureAgent=Reconfigurar Agente do Cloudbeat

[UninstallRun]
Filename: "{app}\remove.cmd"; Flags: runhidden; RunOnceId: "DelService"

[Code]
var
  Page: TInputQueryWizardPage;
  UserName, UserCompany: String;
  Resulttest: Integer;

procedure InitializeWizard();
begin
  Page := CreateInputQueryPage(
    wpWelcome,
    ExpandConstant('{cm:ServerInfo}'), '',
    ExpandConstant('{cm:FillServerInfo}')
  );

  { Add items (False means it's not a password edit) }
  Page.Add(ExpandConstant('{cm:ServerKey}'), False);
  Page.Add(ExpandConstant('{cm:CloudbeatUrl}'), False);

  { Set initial values (optional) }
  // Page.Values[0] := ExpandConstant('{sysuserinfoname}');
  // Page.Values[1] := ExpandConstant('{sysuserinfoorg}');
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  Result0: Integer;
  Result1: Integer;
  Result2: Integer; 
  Result3: Integer;
begin
  if CurStep = ssInstall then
  begin
    { installation is starting }
  end
    else
  if CurStep = ssPostInstall then
  begin
    { installation has finished }
    Exec('cmd.exe', '/c net stop "Cloudbeat Agent"', '', SW_HIDE, ewWaitUntilTerminated, Result0);
    Exec(ExpandConstant('{app}') + '\nodejs\node.exe', ExpandConstant('{app}') + '\service.js --remove', '', SW_HIDE, ewWaitUntilTerminated, Result1);
    Exec(
      ExpandConstant('{app}') + '\nodejs\node.exe ', '"' + ExpandConstant('{app}') + '\service.js" --add ' + Page.Values[0] + ' ' + Page.Values[1],
      '', SW_HIDE, ewWaitUntilTerminated, Result2);
    Exec('cmd.exe', '/c net start "Cloudbeat Agent" & pause', '', SW_HIDE, ewWaitUntilTerminated, Result0);
  end;
end;