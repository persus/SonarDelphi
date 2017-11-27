program ProjectFileWithKeyWordsAsNames;

{$R *.dres}

uses
  eurekalog.inc in 'Includes\eurekalog.inc.pas',
  VCL.Forms,
  WinAPI.Windows,
  System.Classes,
  ComInitialization in 'Legacy\ComInitialization.pas',
  Com.Init in 'Legacy\Com.Init.pas',
  Some.Helper in 'Core\FooBar\Some.Helper.pas',
  Some.Log in 'Core\FooBar\Some.Log.pas',
  Some.Patch in 'Core\FooBar\Some.Patch.pas';

{$MINSTACKSIZE      $00004000}
{$MAXSTACKSIZE      $00200000}
{$SetPEFlags IMAGE_FILE_LARGE_ADDRESS_AWARE}

{$R *.RES}
 
begin
  Application.Initialize;
  Application.ModalPopupMode := pmAuto;
  Application.CreateForm(TFormMain, FormlMain);
  if MainApp.Initialize then
    Application.Run;

  MainApp.Finalise;
end.