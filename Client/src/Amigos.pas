unit Amigos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.ListBox,
  FMX.Gestures, FMX.TabControl, FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TSplitPaneForm = class(TForm)
    StyleBook2: TStyleBook;
    ToolbarHolder: TLayout;
    ToolbarPopup: TPopup;
    ToolbarPopupAnimation: TFloatAnimation;
    MainLayout: TLayout;
    LeftLayout: TLayout;
    ListBoxItems: TListBox;
    ArticleHeader1: TMetropolisUIListBoxItem;
    ArticleHeader2: TMetropolisUIListBoxItem;
    ArticleHeader3: TMetropolisUIListBoxItem;
    ArticleHeader4: TMetropolisUIListBoxItem;
    HeaderLayout: TLayout;
    TitleLabel1: TLabel;
    Layout2: TLayout;
    HeaderButton: TButton;
    RightLayout: TLayout;
    ToolBar1: TToolBar;
    ToolbarApplyButton: TButton;
    ToolbarCloseButton: TButton;
    ToolbarAddButton: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    Article1: TVertScrollBox;
    ArticleHeaderLayout1: TLayout;
    Illustration1: TImageControl;
    Layout1: TLayout;
    ItemTitle1: TLabel;
    ItemSubTitle1: TLabel;
    Text1: TLabel;
    Article2: TVertScrollBox;
    ArticleHeaderLayout2: TLayout;
    Illustration2: TImageControl;
    Layout4: TLayout;
    ItemTitle2: TLabel;
    ItemSubTitle2: TLabel;
    Article3: TVertScrollBox;
    ArticleHeaderLayout3: TLayout;
    Illustration3: TImageControl;
    Layout6: TLayout;
    ItemTitle3: TLabel;
    ItemSubTitle3: TLabel;
    Text3: TLabel;
    Article4: TVertScrollBox;
    ArticleHeaderLayout4: TLayout;
    Illustration4: TImageControl;
    Layout8: TLayout;
    ItemTitle4: TLabel;
    ItemSubTitle4: TLabel;
    Text2a: TLabel;
    Text2b: TLabel;
    Text2c: TLabel;
    Text2d: TLabel;
    Text4: TLabel;
    procedure HeaderButtonClick(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure ToolbarCloseButtonClick(Sender: TObject);
    procedure ArticleHeader1Click(Sender: TObject);
  private
    FGestureOrigin: TPointF;
    FGestureInProgress: Boolean;
    { Private declarations }
    procedure ShowToolbar(AShow: Boolean);
  public
    FIdPessoa : Integer;
  end;

var
  SplitPaneForm: TSplitPaneForm;

implementation

{$R *.fmx}

procedure TSplitPaneForm.HeaderButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TSplitPaneForm.ArticleHeader1Click(Sender: TObject);
begin
  TabControl1.TabIndex := TFmxObject(Sender).Tag;
end;

procedure TSplitPaneForm.FormActivate(Sender: TObject);
begin
  ShowMessage(IntToStr(FIdPessoa));
  WindowState := TWindowState.wsMaximized;
  ToolbarHolder.BringToFront;
end;

procedure TSplitPaneForm.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  DX, DY : Single;
begin
  if EventInfo.GestureID = igiPan then
  begin
    if (TInteractiveGestureFlag.gfBegin in EventInfo.Flags)
      and ((Sender = ToolbarPopup)
        or (EventInfo.Location.Y > (ClientHeight - 70))) then
    begin
      FGestureOrigin := EventInfo.Location;
      FGestureInProgress := True;
    end;

    if FGestureInProgress and (TInteractiveGestureFlag.gfEnd in EventInfo.Flags) then
    begin
      FGestureInProgress := False;
      DX := EventInfo.Location.X - FGestureOrigin.X;
      DY := EventInfo.Location.Y - FGestureOrigin.Y;
      if (Abs(DY) > Abs(DX)) then
        ShowToolbar(DY < 0);
    end;
  end
end;

procedure TSplitPaneForm.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkEscape then
    Close;
end;

procedure TSplitPaneForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if Button = TMouseButton.mbRight then
    ShowToolbar(True)
  else
    ShowToolbar(False);
end;

procedure TSplitPaneForm.ShowToolbar(AShow: Boolean);
begin
  ToolbarPopup.Width := ClientWidth;
  ToolbarPopup.PlacementRectangle.Rect := TRectF.Create(0, ClientHeight-ToolbarPopup.Height, ClientWidth-1, ClientHeight-1);
  ToolbarPopupAnimation.StartValue := ToolbarPopup.Height;
  ToolbarPopupAnimation.StopValue := 0;

  ToolbarPopup.IsOpen := AShow;
end;


procedure TSplitPaneForm.ToolbarCloseButtonClick(Sender: TObject);
begin
  Close;
end;

end.
