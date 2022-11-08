
[Setup]
    AppName=PAGE - A Python GUI Generator
    AppId=PAGE - A Python GUI Generator
    CreateUninstallRegKey=1
    UsePreviousAppDir=1
    UsePreviousGroup=1
    AppVersion=NV
    AppVerName=PAGE - A Python GUI Generator NV
    BackColor=$FF0000
    BackColor2=$000000
    BackColorDirection=lefttoright
    WizardStyle=modern
    WindowShowCaption=1
    WindowStartMaximized=1
    WindowVisible=1
    WindowResizable=1
    UninstallLogMode=Append
    DirExistsWarning=auto
    UninstallFilesDir={app}
    DisableDirPage=0
    DisableStartupPrompt=0
    CreateAppDir=1
    DisableProgramGroupPage=0
    Uninstallable=1
    DefaultDirName=c:\page
    DefaultGroupName=PAGE
    AlwaysShowDirOnReadyPage=1
    EnableDirDoesntExistWarning=1
    ShowComponentSizes=1
    SourceDir=Y:\page-tree\page
    OutputDir=Y:\page-tree
    OutputBaseFilename=page-NV
    ChangesEnvironment=yes

[Files]
    Source: Y:\page-tree\page\*; DestDir: {app}; Flags: recursesubdirs
    
[Icons]
    Name: "{userdesktop}\PAGE"; Filename: "{app}\page.bat"; \
	      WorkingDir: "%HOME%\Desktop"; \
	      IconFilename: "{app}\WIN_INSTALL\page.ico"; \
		  Flags: runminimized closeonexit

[Run]
	Filename: "{app}\WIN_INSTALL\WRITE.BAT"; Parameters: "{app}"	

[Code]
	function NeedsAddPathHKLM(Param: string): boolean;
	var
	   OrigPath: string;
	begin
	   if not RegQueryStringValue(HKEY_LOCAL_MACHINE,
	            'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
	            'Path', OrigPath)
		  then begin
			 Result := True;
			 exit;
		  end;
	   // look for the path with leading and trailing semicolon
	   // Pos() returns 0 if not found
	   Result := Pos(';' + Param + ';', ';' + OrigPath + ';') = 0;
	end;

[Registry]

Root: "HKLM"; \
      Subkey:"SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; \
      ValueType:expandsz; ValueName: "Path"; ValueData: "{olddata};{app}"; \
      Check:NeedsAddPathHKLM(ExpandConstant('{app}'))
