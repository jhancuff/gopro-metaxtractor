Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);'

[Console.Window]::ShowWindow([Console.Window]::GetConsoleWindow(), 0)
$global:python = $false
$global:ffmpeg = $false
$global:gopro2gpx = $false
$global:choco = $false
$global:git = $false
$global:singlemode = $true
$global:singlevid = ""
$global:filepath = ""
Add-Type -AssemblyName PresentationCore, PresentationFramework

Function New-WPFMessageBox {

    # For examples for use, see my blog:
    # https://smsagent.wordpress.com/2017/08/24/a-customisable-wpf-messagebox-for-powershell/
    
    # CHANGES
    # 2017-09-11 - Added some required assemblies in the dynamic parameters to avoid errors when run from the PS console host.
    
    # Define Parameters
    [CmdletBinding()]
    Param
    (
        # The popup Content
        [Parameter(Mandatory=$True,Position=0)]
        [Object]$Content,

        # The window title
        [Parameter(Mandatory=$false,Position=1)]
        [string]$Title,

        # The buttons to add
        [Parameter(Mandatory=$false,Position=2)]
        [ValidateSet('OK','OK-Cancel','Abort-Retry-Ignore','Yes-No-Cancel','Yes-No','Retry-Cancel','Cancel-TryAgain-Continue','None')]
        [array]$ButtonType = 'OK',

        # The buttons to add
        [Parameter(Mandatory=$false,Position=3)]
        [array]$CustomButtons,

        # Content font size
        [Parameter(Mandatory=$false,Position=4)]
        [int]$ContentFontSize = 14,

        # Title font size
        [Parameter(Mandatory=$false,Position=5)]
        [int]$TitleFontSize = 14,

        # BorderThickness
        [Parameter(Mandatory=$false,Position=6)]
        [int]$BorderThickness = 0,

        # CornerRadius
        [Parameter(Mandatory=$false,Position=7)]
        [int]$CornerRadius = 8,

        # ShadowDepth
        [Parameter(Mandatory=$false,Position=8)]
        [int]$ShadowDepth = 3,

        # BlurRadius
        [Parameter(Mandatory=$false,Position=9)]
        [int]$BlurRadius = 20,

        # WindowHost
        [Parameter(Mandatory=$false,Position=10)]
        [object]$WindowHost,

        # Timeout in seconds,
        [Parameter(Mandatory=$false,Position=11)]
        [int]$Timeout,

        # Code for Window Loaded event,
        [Parameter(Mandatory=$false,Position=12)]
        [scriptblock]$OnLoaded,

        # Code for Window Closed event,
        [Parameter(Mandatory=$false,Position=13)]
        [scriptblock]$OnClosed

    )

    # Dynamically Populated parameters
    DynamicParam {
        
        # Add assemblies for use in PS Console 
        Add-Type -AssemblyName System.Drawing, PresentationCore
        
        # ContentBackground
        $ContentBackground = 'ContentBackground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute) 
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.ContentBackground = "White"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ContentBackground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ContentBackground, $RuntimeParameter)
        

        # FontFamily
        $FontFamily = 'FontFamily'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute)  
        $arrSet = [System.Drawing.FontFamily]::Families.Name | Select -Skip 1 
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)
        $AttributeCollection.Add($ValidateSetAttribute)
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($FontFamily, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($FontFamily, $RuntimeParameter)
        $PSBoundParameters.FontFamily = "Segoe UI"

        # TitleFontWeight
        $TitleFontWeight = 'TitleFontWeight'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute) 
        $arrSet = [System.Windows.FontWeights] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.TitleFontWeight = "Normal"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($TitleFontWeight, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($TitleFontWeight, $RuntimeParameter)

        # ContentFontWeight
        $ContentFontWeight = 'ContentFontWeight'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute) 
        $arrSet = [System.Windows.FontWeights] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.ContentFontWeight = "Normal"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ContentFontWeight, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ContentFontWeight, $RuntimeParameter)
        

        # ContentTextForeground
        $ContentTextForeground = 'ContentTextForeground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute) 
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.ContentTextForeground = "Black"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ContentTextForeground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ContentTextForeground, $RuntimeParameter)

        # TitleTextForeground
        $TitleTextForeground = 'TitleTextForeground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute) 
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.TitleTextForeground = "Black"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($TitleTextForeground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($TitleTextForeground, $RuntimeParameter)

        # BorderBrush
        $BorderBrush = 'BorderBrush'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute) 
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.BorderBrush = "Black"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($BorderBrush, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($BorderBrush, $RuntimeParameter)


        # TitleBackground
        $TitleBackground = 'TitleBackground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute) 
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.TitleBackground = "White"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($TitleBackground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($TitleBackground, $RuntimeParameter)

        # ButtonTextForeground
        $ButtonTextForeground = 'ButtonTextForeground'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        $AttributeCollection.Add($ParameterAttribute) 
        $arrSet = [System.Drawing.Brushes] | Get-Member -Static -MemberType Property | Select -ExpandProperty Name 
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
        $AttributeCollection.Add($ValidateSetAttribute)
        $PSBoundParameters.ButtonTextForeground = "Black"
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ButtonTextForeground, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ButtonTextForeground, $RuntimeParameter)

        # Sound
        $Sound = 'Sound'
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Mandatory = $False
        #$ParameterAttribute.Position = 14
        $AttributeCollection.Add($ParameterAttribute) 
        $arrSet = (Get-ChildItem "$env:SystemDrive\Windows\Media" -Filter Windows* | Select -ExpandProperty Name).Replace('.wav','')
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)    
        $AttributeCollection.Add($ValidateSetAttribute)
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($Sound, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($Sound, $RuntimeParameter)

        return $RuntimeParameterDictionary
    }

    Begin {
        Add-Type -AssemblyName PresentationFramework
    }
    
    Process {

# Define the XAML markup
[XML]$Xaml = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        x:Name="Window" Title="" SizeToContent="WidthAndHeight" WindowStartupLocation="CenterScreen" WindowStyle="None" ResizeMode="NoResize" AllowsTransparency="True" Background="Transparent" Opacity="1">
    <Window.Resources>
        <Style TargetType="{x:Type Button}">
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border>
                            <Grid Background="{TemplateBinding Background}">
                                <ContentPresenter />
                            </Grid>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    <Border x:Name="MainBorder" Margin="10" CornerRadius="$CornerRadius" BorderThickness="$BorderThickness" BorderBrush="$($PSBoundParameters.BorderBrush)" Padding="0" >
        <Border.Effect>
            <DropShadowEffect x:Name="DSE" Color="Black" Direction="270" BlurRadius="$BlurRadius" ShadowDepth="$ShadowDepth" Opacity="0.6" />
        </Border.Effect>
        <Border.Triggers>
            <EventTrigger RoutedEvent="Window.Loaded">
                <BeginStoryboard>
                    <Storyboard>
                        <DoubleAnimation Storyboard.TargetName="DSE" Storyboard.TargetProperty="ShadowDepth" From="0" To="$ShadowDepth" Duration="0:0:1" AutoReverse="False" />
                        <DoubleAnimation Storyboard.TargetName="DSE" Storyboard.TargetProperty="BlurRadius" From="0" To="$BlurRadius" Duration="0:0:1" AutoReverse="False" />
                    </Storyboard>
                </BeginStoryboard>
            </EventTrigger>
        </Border.Triggers>
        <Grid >
            <Border Name="Mask" CornerRadius="$CornerRadius" Background="$($PSBoundParameters.ContentBackground)" />
            <Grid x:Name="Grid" Background="$($PSBoundParameters.ContentBackground)">
                <Grid.OpacityMask>
                    <VisualBrush Visual="{Binding ElementName=Mask}"/>
                </Grid.OpacityMask>
                <StackPanel Name="StackPanel" >                   
                    <TextBox Name="TitleBar" IsReadOnly="True" IsHitTestVisible="False" Text="$Title" Padding="10" FontFamily="$($PSBoundParameters.FontFamily)" FontSize="$TitleFontSize" Foreground="$($PSBoundParameters.TitleTextForeground)" FontWeight="$($PSBoundParameters.TitleFontWeight)" Background="$($PSBoundParameters.TitleBackground)" HorizontalAlignment="Stretch" VerticalAlignment="Center" Width="Auto" HorizontalContentAlignment="Center" BorderThickness="0"/>
                    <DockPanel Name="ContentHost" Margin="0,10,0,10"  >
                    </DockPanel>
                    <DockPanel Name="ButtonHost" LastChildFill="False" HorizontalAlignment="Center" >
                    </DockPanel>
                </StackPanel>
            </Grid>
        </Grid>
    </Border>
</Window>
"@

[XML]$ButtonXaml = @"
<Button xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Width="Auto" Height="30" FontFamily="Segui" FontSize="16" Background="Transparent" Foreground="White" BorderThickness="1" Margin="10" Padding="20,0,20,0" HorizontalAlignment="Right" Cursor="Hand"/>
"@

[XML]$ButtonTextXaml = @"
<TextBlock xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" FontFamily="$($PSBoundParameters.FontFamily)" FontSize="16" Background="Transparent" Foreground="$($PSBoundParameters.ButtonTextForeground)" Padding="20,5,20,5" HorizontalAlignment="Center" VerticalAlignment="Center"/>
"@

[XML]$ContentTextXaml = @"
<TextBlock xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Text="$Content" Foreground="$($PSBoundParameters.ContentTextForeground)" DockPanel.Dock="Right" HorizontalAlignment="Center" VerticalAlignment="Center" FontFamily="$($PSBoundParameters.FontFamily)" FontSize="$ContentFontSize" FontWeight="$($PSBoundParameters.ContentFontWeight)" TextWrapping="Wrap" Height="Auto" MaxWidth="500" MinWidth="50" Padding="10"/>
"@

    # Load the window from XAML
    $Window = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $xaml))

    # Custom function to add a button
    Function Add-Button {
        Param($Content)
        $Button = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $ButtonXaml))
        $ButtonText = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $ButtonTextXaml))
        $ButtonText.Text = "$Content"
        $Button.Content = $ButtonText
        $Button.Add_MouseEnter({
            $This.Content.FontSize = "17"
        })
        $Button.Add_MouseLeave({
            $This.Content.FontSize = "16"
        })
        $Button.Add_Click({
            New-Variable -Name WPFMessageBoxOutput -Value $($This.Content.Text) -Option ReadOnly -Scope Script -Force
            $Window.Close()
        })
        $Window.FindName('ButtonHost').AddChild($Button)
    }

    # Add buttons
    If ($ButtonType -eq "OK")
    {
        Add-Button -Content "OK"
    }

    If ($ButtonType -eq "OK-Cancel")
    {
        Add-Button -Content "OK"
        Add-Button -Content "Cancel"
    }

    If ($ButtonType -eq "Abort-Retry-Ignore")
    {
        Add-Button -Content "Abort"
        Add-Button -Content "Retry"
        Add-Button -Content "Ignore"
    }

    If ($ButtonType -eq "Yes-No-Cancel")
    {
        Add-Button -Content "Yes"
        Add-Button -Content "No"
        Add-Button -Content "Cancel"
    }

    If ($ButtonType -eq "Yes-No")
    {
        Add-Button -Content "Yes"
        Add-Button -Content "No"
    }

    If ($ButtonType -eq "Retry-Cancel")
    {
        Add-Button -Content "Retry"
        Add-Button -Content "Cancel"
    }

    If ($ButtonType -eq "Cancel-TryAgain-Continue")
    {
        Add-Button -Content "Cancel"
        Add-Button -Content "TryAgain"
        Add-Button -Content "Continue"
    }

    If ($ButtonType -eq "None" -and $CustomButtons)
    {
        Foreach ($CustomButton in $CustomButtons)
        {
            Add-Button -Content "$CustomButton"
        }
    }

    # Remove the title bar if no title is provided
    If ($Title -eq "")
    {
        $TitleBar = $Window.FindName('TitleBar')
        $Window.FindName('StackPanel').Children.Remove($TitleBar)
    }

    # Add the Content
    If ($Content -is [String])
    {
        # Replace double quotes with single to avoid quote issues in strings
        If ($Content -match '"')
        {
            $Content = $Content.Replace('"',"'")
        }
        
        # Use a text box for a string value...
        $ContentTextBox = [Windows.Markup.XamlReader]::Load((New-Object -TypeName System.Xml.XmlNodeReader -ArgumentList $ContentTextXaml))
        $Window.FindName('ContentHost').AddChild($ContentTextBox)
    }
    Else
    {
        # ...or add a WPF element as a child
        Try
        {
            $Window.FindName('ContentHost').AddChild($Content) 
        }
        Catch
        {
            $_
        }        
    }

    # Enable window to move when dragged
    $Window.FindName('Grid').Add_MouseLeftButtonDown({
        $Window.DragMove()
    })

    # Activate the window on loading
    If ($OnLoaded)
    {
        $Window.Add_Loaded({
            $This.Activate()
            Invoke-Command $OnLoaded
        })
    }
    Else
    {
        $Window.Add_Loaded({
            $This.Activate()
        })
    }
    

    # Stop the dispatcher timer if exists
    If ($OnClosed)
    {
        $Window.Add_Closed({
            If ($DispatcherTimer)
            {
                $DispatcherTimer.Stop()
            }
            Invoke-Command $OnClosed
        })
    }
    Else
    {
        $Window.Add_Closed({
            If ($DispatcherTimer)
            {
                $DispatcherTimer.Stop()
            }
        })
    }
    

    # If a window host is provided assign it as the owner
    If ($WindowHost)
    {
        $Window.Owner = $WindowHost
        $Window.WindowStartupLocation = "CenterOwner"
    }

    # If a timeout value is provided, use a dispatcher timer to close the window when timeout is reached
    If ($Timeout)
    {
        $Stopwatch = New-object System.Diagnostics.Stopwatch
        $TimerCode = {
            If ($Stopwatch.Elapsed.TotalSeconds -ge $Timeout)
            {
                $Stopwatch.Stop()
                $Window.Close()
            }
        }
        $DispatcherTimer = New-Object -TypeName System.Windows.Threading.DispatcherTimer
        $DispatcherTimer.Interval = [TimeSpan]::FromSeconds(1)
        $DispatcherTimer.Add_Tick($TimerCode)
        $Stopwatch.Start()
        $DispatcherTimer.Start()
    }

    # Play a sound
    If ($($PSBoundParameters.Sound))
    {
        $SoundFile = "$env:SystemDrive\Windows\Media\$($PSBoundParameters.Sound).wav"
        $SoundPlayer = New-Object System.Media.SoundPlayer -ArgumentList $SoundFile
        $SoundPlayer.Add_LoadCompleted({
            $This.Play()
            $This.Dispose()
        })
        $SoundPlayer.LoadAsync()
    }

    # Display the window
    $null = $window.Dispatcher.InvokeAsync{$window.ShowDialog()}.Wait()

    }
}
function Run-Elevated ($scriptblock)
{
  # TODO: make -NoExit a parameter
  # TODO: just open PS (no -Command parameter) if $scriptblock -eq ''
  $sh = new-object -com 'Shell.Application'
  $sh.ShellExecute('powershell', "-NoExit -Command $scriptblock", '', 'runas')
}
function Create-WPFWindow {
    Param($global:hash)

    $Window = New-Object System.Windows.Window
    $Window.SizeToContent = [System.Windows.SizeToContent]::WidthAndHeight
    $window.title = "GoPro Metaxtractor"
    $window.WindowStartupLocation = [System.Windows.WindowStartupLocation]::CenterScreen
    $window.ResizeMode = [System.Windows.ResizeMode]::NoResize

    $IntroBlock = New-object System.Windows.Controls.TextBlock
    $introblock.HorizontalAlignment = "Left"
    $IntroBlock.VerticalAlignment = "Center"
    $IntroBlock.TextWrapping = "Wrap"
    $introblock.Height = 100
    $introblock.Width = 700
    $global:hash.IntroBlock = $IntroBlock

    $singleFileRadio = new-object System.Windows.Controls.RadioButton
    $singleFileRadio.GroupName = "selectorGroup"
    $singleFileRadio.Content = "Process Single File"
    $singleFileRadio.IsChecked = $True
    $global:hash.singleFileRadio = $singleFileRadio

    $folderRadio = new-object System.Windows.Controls.RadioButton
    $folderRadio.GroupName = "selectorGroup"
    $folderRadio.Content = "Process Folder of Files"
    $folderRadio.IsChecked = $false
    $global:hash.folderRadio = $folderRadio

    $singleFileText = new-object System.Windows.Controls.TextBox
    $singleFileText.Height = 20
    $singleFileText.Width = 500
    $singleFileText.AllowDrop = $True
    $global:hash.singleFileText = $singleFileText

    $folderFileText = new-object System.Windows.Controls.TextBlock
    $folderFileText.Height = 20
    $folderFileText.Width = 500
    
    $global:hash.folderFileText = $folderFileText

    $fileBrowseButton = new-object System.Windows.Controls.Button
    $fileBrowseButton.Content = "Browse for File"
    $fileBrowseButton.Height = 24
    $fileBrowseButton.Width = 120
    $fileBrowseButton.Margin = 5
    $global:hash.fileBrowseButton = $fileBrowseButton

    $statusBar = new-object System.Windows.Controls.ProgressBar
    $statusBar.Height = 24
    $statusBar.Value = 0
    $statusBar.Width = 600
    $global:hash.statusbar = $statusbar

    $statusText = new-object System.Windows.Controls.TextBlock
    $statusText.Height = 24
    $statustext.Width = 150
    $statustext.VerticalAlignment = "Center"
    $statusText.HorizontalAlignment = "Left"
    $global:hash.statusText = $statusText

    $folderBrowseButton = new-object System.Windows.Controls.Button
    $folderbrowsebutton.Content = "Browse for Folder"
    $folderBrowseButton.Height = 24
    $folderBrowseButton.width = 120
    $folderBrowseButton.Margin = 5
    $folderBrowseButton.IsEnabled = $false
    $global:hash.folderBrowseButton = $folderBrowseButton

    $goButton = new-object System.Windows.Controls.Button
    $goButton.Height = 48
    $goButton.width = 120
    $goButton.Content = "Begin Processing"
    $goButton.Margin = 5
    $goButton.IsEnabled = $false
    $global:hash.goButton = $goButton

    $singleFileStack = new-object System.Windows.Controls.StackPanel
    $singleFileStack.Orientation = "Horizontal"
    $singleFileStack.Margin = "5,5,5,5"
    $singleFileStack.AddChild($fileBrowseButton)
    $singleFileStack.AddChild($singleFileText)

    $folderStack = new-object System.Windows.Controls.StackPanel
    $folderStack.Orientation = "Horizontal"
    $folderStack.Margin = "5,5,5,5"
    $folderStack.AddChild($folderBrowseButton)
    $folderStack.AddChild($folderFileText)

    $statusStack = new-object System.Windows.Controls.StackPanel
    $statusStack.Orientation = "Horizontal"
    $statusStack.AddChild($statusText)
    $statusStack.AddChild($statusBar)

    $aboutButton = new-object System.Windows.Controls.Button
    $aboutButton.Height = 24
    $aboutbutton.Content = "About"
    $aboutbutton.Width = 60
    $global:hash.aboutButton = $aboutButton

    $introStack = new-object System.Windows.Controls.StackPanel
    $introStack.Orientation = "Horizontal"
    $introStack.AddChild($introblock)
    $introStack.AddChild($aboutButton)


    $vStackPanel = new-object system.windows.controls.StackPanel
    $vStackPanel.Orientation = "Vertical"
    $vStackPanel.Margin = "5,5,5,5"
    $vStackPanel.AddChild($introStack)
    $vStackPanel.AddChild($singleFileRadio)
    $vStackPanel.AddChild($folderRadio)
    $vStackPanel.AddChild($singleFileStack)
    $vStackPanel.AddChild($folderStack)
    $vStackPanel.AddChild($goButton)
    $vstackPanel.AddChild($statusStack)
    $window.AddChild($vStackPanel)
    $global:hash.Window = $Window
    

}

function Check-Dependencies{
    $WarningParams = @{
        Title = "WARNING"
        TitleFontSize = 20
        TitleBackground = 'Orange'
        TitleTextForeground = 'Black'
    }
    $list = @()

    

    try{
        choco -v
        $global:choco = $true
    }
    catch{
        $global:choco = $false
        $list += "choco"
    }
    try{
        ffmpeg
        $global:ffmpeg = $true
    }
    catch{
        $global:ffmpeg = $false
        $list += "ffmpeg"
    }
    try{
        python -V
        $global:python = $true
    }catch{
        $global:python = $false
        $list += "python"
    }
    try{
        gopro2gpx
        $global:gopro2gpx = $true
    }catch{
        $global:gopro2gpx = $false
        $list += "gopro2gpx"
    }
    try{
        git
        $global:git = $true
    }catch{
        $global:git = $false
        $list += "git"
    }
    if($list.Count -ne 0){
        $listdisplay = $list | out-string
        New-WPFMessageBox @WarningParams -Content "Looks like we're missing the following packages on this system: $listdisplay 
        
        Would you like me to install these for you?" -ButtonType Yes-No
        if($WPFMessageBoxOutput -eq "Yes"){
            Install-Dependencies
        }
    }else{
        New-WPFMessageBox -Title "We're good!" -Content "Just go ahead and run this app again!" -ButtonType 'OK' -Timeout 10
        echo "Made ya look!" > ./GoPro-Metaxtractor.ini
        Exit
    }

}

Function Install-Dependencies{

    $chocoblock = @"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    exit
"@

    $pythonblock = @"
    winget install --id Python.Python.3.12 --accept-package-agreements --accept-source-agreements
    exit
"@
    $ffmpegblock = @"
    choco install ffmpeg -y
    exit
"@
    $gopro2gpxblock = @"
    pip3 install git+https://github.com/juanmcasillas/gopro2gpx
    exit
"@
    $gitblock = @"
    choco install git -y
    exit
"@

$installerparams = @{
    Title = "Installing... this might take a few..."
    ContentBackground = "WhiteSmoke"
    ButtonType = 'None'
    Timeout = 60
}

New-WPFMessageBox @installerparams -content "It may look like it's doing nothing. Please don't close or interact with any windows until installs are completed" -ButtonType OK -Timeout 10
try{
if(!$global:choco){
    $code = {
    Run-Elevated $chocoblock
    }
New-WPFMessageBox -Title "Installing... This might take a few.." -ContentBackground "WhiteSmoke" -ButtonType "None" -Timeout 60 -content "Installing Choco.." -OnLoaded $code
}
if(!$global:python){
    $code = {
    Run-Elevated $pythonblock
    }
New-WPFMessageBox -Title "Installing... This might take a few.." -ContentBackground "WhiteSmoke" -ButtonType "None" -Timeout 60 -Content "Installing Python.." -OnLoaded $code
}
if(!$global:ffmpeg){
    $code = {
    Run-Elevated $ffmpegblock
}
New-WPFMessageBox -Title "Installing... This might take a few.." -ContentBackground "WhiteSmoke" -ButtonType 'None' -Timeout 15 -Content "Installing ffmpeg" -OnLoaded $code
}
if(!$global:git){
    $code = {
        Run-Elevated $gitblock 
    }
    New-WPFMessageBox -Content "Installing git" -Title "Installing... This might take a few.." -ContentBackground "WhiteSmoke" -ButtonType 'None' -Timeout 20 -OnLoaded $code
}
if(!$global:gopro2gpx){
    $code = {
        Run-Elevated $gopro2gpxblock
    }
    New-WPFMessageBox -Title "Installing... This might take a few.." -ContentBackground "WhiteSmoke" -ButtonType "None" -Timeout 5 -Content "Installing GoPro2GPX" -OnLoaded $code
}
echo "Made ya look!" > ./GoPro-Metaxtractor.ini
$InfoParams = @{
    Title = "SUCCESS!"
    TitleFontSize = 20
    TitleBackground = 'LightSkyBlue'
    TitleTextForeground = 'Black'
}
New-WPFMessageBox @InfoParams -Content "Looks like everything is already installed or installed ok. The app will now exit, please run it again."
Exit
}catch{
    write-host $Error
    $ErrorParams = @{
        FontFamily = 'Verdana'
        Title = ":("
        TitleFontSize = 80
        TitleTextForeground = 'White'
        TitleBackground = 'SteelBlue'
        ButtonType = 'OK'
        ContentFontSize = 16
        ContentTextForeground = 'White'
        ContentBackground = 'SteelBlue'
        ButtonTextForeground = 'White'
        BorderThickness = 0
    }
    New-WPFMessageBox @ErrorParams -Content "Something went pearshaped during install.. You're going to have to troubleshoot this yourself.  I'm just a guy.  Sorry...
     
    0x80042069 -- Not a real error code."
    exit
}
Function global:Update-Status($percent,$status){
    $global:hash.statusbar.Value = $percent
    $global:hash.statusText.Text = $status
}
}
$DependencyParams = @{
    Content = "Looks like this is your first run or you're missing critical dependencies.  I can install them for you if you like or you can refer to my github page for the list of dependencies if you'd rather install them yourself.  Install them now?"
    Title = "First Run Setup"
    TitleFontSize = 20
    TitleBackground = 'Green'
    TitleTextForeground = 'White'
    ButtonType = 'yes-no'
    
}
$DoneParams = @{
    Content = "Job has completed"
    Title = "Glorious Success!"
    TitleFontSize = 20
    TitleBackground = 'Green'
    TitleTextForeground = 'White'
    ButtonType = 'Ok'
    
}

if (!(Test-Path -path ./GoPro-Metaxtractor.ini)){
    New-WPFMessageBox @DependencyParams
    if($WPFMessageBoxOutput -eq "Yes"){
        Check-Dependencies
    }else{Exit}
}
$global:hash = @{}
Create-WPFWindow $global:hash

$global:hash.IntroBlock.Text = "Welcome to GoPro Metaxtractor.  This will extract GPX files from GoPro camera video files.  It's kinda garbage right now but hopefully someone will find it useful as the current alternatives are some paid stuff on that website or get dirty with python, java or some other shizz.  Iono. Do what you want, I'm not the police.  Enjoy!!"
$global:hash.statustext.Text = "Ready.."
$global:hash.statusbar.Value = 0
$global:hash.singleFileRadio.Add_Click{
    $global:hash.folderBrowseButton.IsEnabled = $false;
    $global:hash.singleFileText.IsEnabled = $true;
    $global:hash.fileBrowseButton.IsEnabled = $true;
    $global:singlemode = $true
}
$global:hash.folderRadio.Add_Click{
    $global:hash.singleFileText.IsEnabled = $false;
    $global:singlemode = $false
    $global:hash.fileBrowseButton.IsEnabled = $false;
    $global:hash.folderBrowseButton.IsEnabled = $true;
}

$global:hash.fileBrowseButton.Add_Click{
    Add-Type -AssemblyName System.Windows.Forms
    $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
        InitialDirectory = [Environment]::GetFolderPath('Desktop')
        Filter = 'GoPro MP4 (*.mp4)|*.mp4|GoPro MOV (*.mov)|*.mov'
    }
    $null = $FileBrowser.ShowDialog()
    if ($filebrowser.filename -ne ""){
        $global:hash.singleFileText.Text = $filebrowser.FileName
        $global:singlevid = $filebrowser.FileName
        $global:hash.goButton.IsEnabled = $true
    }
    

}
$global:hash.aboutButton.Add_Click{
    New-WPFMessageBox -title "About" -Content "GoPro Metaxtractor v0.1.0b
    Created by Joe Hancuff
    Look, I know this is a heaping pile of shit but I wanted to take a stab at making something relatively EASY for Windows users that they didn't have to manually install a bunch of libraries or other apps to get this hot buttery garbage working. I'm working on it, but I can't gaurantee that I can devote a bunch of time to this.  If it worked for you, awesome.  If not, well it was free, don't bitch at me too loudly about it.

    So yeah...  Watch this space I guess, I dunno.  ¯\_(ツ)_/¯" -TitleFontSize 30 -TitleBackground 'Navy' -TitleTextForeground 'White' -CornerRadius 80 -ShadowDepth 10 -BlurRadius 10 -BorderThickness 1 -BorderBrush 'Black'
}
$global:hash.goButton.Add_Click{
    
    $global:hash.statusbar.Value = 0
    $global:hash.statusText.Text = "Processing..."
    if($global:singlemode){
    $vidfile = $global:singlevid
    $vidfilePath = $vidfile.substring(0,$vidfile.length-12)
    $noext = $vidfile.Substring(0,$vidfile.Length-4)
    $binfile = $noext + ".bin"
    $lonefile = $noext.Substring($vidfile.Length-12)
    ffmpeg -y -i "$vidfile" -codec copy -map 0:3 -f rawvideo "$binfile"
    gopro2gpx -s -b "$binfile" $lonefile
    $gpx = $lonefile + ".gpx"
    mv "./$gpx" "$vidfilepath"
    rm $binfile
    $global:hash.statusbar.Value = 100
    $global:hash.statusText.Text = "Done!"
    New-WPFMessageBox -Content "Job has completed" -Title "Glorious Success!" -Titlefontsize 20 -TitleBackground 'Green' -TitleTextForeground 'White' -ButtonType 'Ok'
    }
    else{
        $path = $global:filepath
        $vidfiles = get-childitem "$path" -Filter *.MP4
        $numfiles = $vidfiles.Length
        $donefiles = 0
        foreach($vidfile in $vidfiles.fullname){
            $noext = $vidfile.Substring(0,$vidfile.Length-4)
            $binfile = $noext + ".bin"
            $lonefile = $noext.Substring($vidfile.Length-12)
            ffmpeg -y -i "$vidfile" -codec copy -map 0:3 -f rawvideo "$binfile"
            start-sleep -seconds 1
            gopro2gpx -s -b "$binfile" $lonefile
            $gpx = $lonefile + ".gpx"
            mv "./$gpx" "$path"
            rm $binfile
            $donefiles++
            $global:hash.statusbar.Value = $(($donefiles / $numfiles)*100)
            }
        $global:hash.statusbar.Value = 100
        $global:hash.statusText.Text = "Done!"
        New-WPFMessageBox -Content "Job has completed" -Title "Glorious Success!" -Titlefontsize 20 -TitleBackground 'Green' -TitleTextForeground 'White' -ButtonType 'Ok'

    }

}

$global:hash.folderBrowseButton.Add_Click{
    Add-Type -AssemblyName system.windows.Forms
    $folder = new-object System.Windows.Forms.FolderBrowserDialog
    $null = $folder.ShowDialog()
    if($folder.SelectedPath -ne ""){
    $global:hash.folderFileText.Text = $folder.SelectedPath
    $global:filepath = $folder.SelectedPath
    $global:hash.goButton.IsEnabled = $true
    }
}
[void]$global:hash.Window.Dispatcher.InvokeAsync{$global:hash.Window.ShowDialog()}.Wait()