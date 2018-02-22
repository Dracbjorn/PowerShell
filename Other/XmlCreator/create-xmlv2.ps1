$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0) 

Function Display-Inputbox 
{
     
    Add-Type -AssemblyName System.Windows.Forms 
    Add-Type -AssemblyName System.Drawing 
    $MyForm = New-Object System.Windows.Forms.Form 
    $MyForm.Text="MyForm" 
    $MyForm.Size = New-Object System.Drawing.Size(600,350) 
     
 
        $minputLabel = New-Object System.Windows.Forms.Label 
                $minputLabel.Text="Input File Path" 
                $minputLabel.Top="20" 
                $minputLabel.Left="5" 
                $minputLabel.Anchor="Left,Top" 
        $minputLabel.Size = New-Object System.Drawing.Size(100,25) 
        $MyForm.Controls.Add($minputLabel) 
         
 
        $minputTextBox = New-Object System.Windows.Forms.TextBox 
                $minputTextBox.Text="$($env:USERPROFILE)\Documents" 
                $minputTextBox.Top="45" 
                $minputTextBox.Left="5" 
                $minputTextBox.Anchor="Left,Top" 
        $minputTextBox.Size = New-Object System.Drawing.Size(450,25) 
        $MyForm.Controls.Add($minputTextBox) 
        
        $browseInputButton = New-Object System.Windows.Forms.Button 
        $browseInputButton.Location = New-Object System.Drawing.Size(465, 42) 
        $browseInputButton.Size = New-Object System.Drawing.Size(100,25) 
        $browseInputButton.Text = "Browse" 
        $browseInputButton.Add_Click({$minputTextBox.Text = Get-FileName($minputTextBox.Text)}) 
        $MyForm.Controls.Add($browseInputButton) 
         
 
        $moutputLabel = New-Object System.Windows.Forms.Label 
                $moutputLabel.Text="Output Folder Path" 
                $moutputLabel.Top="75" 
                $moutputLabel.Left="5" 
                $moutputLabel.Anchor="Left,Top" 
        $moutputLabel.Size = New-Object System.Drawing.Size(100,25) 
        $MyForm.Controls.Add($moutputLabel) 
         
 
        $moutputTextBox = New-Object System.Windows.Forms.TextBox 
                $moutputTextBox.Text ="$($env:USERPROFILE)\Documents"  
                $moutputTextBox.Top="100" 
                $moutputTextBox.Left="5" 
                $moutputTextBox.Anchor="Left,Top" 
        $moutputTextBox.Size = New-Object System.Drawing.Size(450,25) 
        $MyForm.Controls.Add($moutputTextBox) 

        $browseOutputButton = New-Object System.Windows.Forms.Button 
        $browseOutputButton.Location = New-Object System.Drawing.Size(465, 98) 
        $browseOutputButton.Size = New-Object System.Drawing.Size(100,25) 
        $browseOutputButton.Text = "Browse" 
        $browseOutputButton.Add_Click({$moutputTextBox.Text = Select-FolderDialog}) 
        $MyForm.Controls.Add($browseOutputButton) 
       
 
        $mtestIDTextBox = New-Object System.Windows.Forms.TextBox 
                $mtestIDTextBox.Text="CQC001_E000_M000_S000_I000_ModExam_X000" 
                $mtestIDTextBox.Top="155" 
                $mtestIDTextBox.Left="5" 
                $mtestIDTextBox.Anchor="Left,Top" 
        $mtestIDTextBox.Size = New-Object System.Drawing.Size(450,23) 
        $MyForm.Controls.Add($mtestIDTextBox) 
         
 
        $mtestIDLabel = New-Object System.Windows.Forms.Label 
                $mtestIDLabel.Text="Test ID" 
                $mtestIDLabel.Top="130" 
                $mtestIDLabel.Left="5" 
                $mtestIDLabel.Anchor="Left,Top" 
        $mtestIDLabel.Size = New-Object System.Drawing.Size(100,25) 
        $MyForm.Controls.Add($mtestIDLabel) 
         
 
        $mweightLabel = New-Object System.Windows.Forms.Label 
                $mweightLabel.Text="Test Weight" 
                $mweightLabel.Top="185" 
                $mweightLabel.Left="5" 
                $mweightLabel.Anchor="Left,Top" 
        $mweightLabel.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mweightLabel) 
         
 
        $mweightTextBox = New-Object System.Windows.Forms.TextBox 
                $mweightTextBox.Text="100" 
                $mweightTextBox.Top="210" 
                $mweightTextBox.Left="5" 
                $mweightTextBox.Anchor="Left,Top" 
        $mweightTextBox.Size = New-Object System.Drawing.Size(100,25) 
        $MyForm.Controls.Add($mweightTextBox) 
         
 
        $mokButton = New-Object System.Windows.Forms.Button 
                $mokButton.Text="OK" 
                $mokButton.Top="254" 
                $mokButton.Left="315" 
                $mokButton.Anchor="Left,Top" 
                $mokButton.DialogResult=[System.Windows.Forms.DialogResult]::OK
        $mokButton.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mokButton) 
        $MyForm.AcceptButton = $mokButton
         
 
        $mcancelButton = New-Object System.Windows.Forms.Button 
                $mcancelButton.Text="Cancel" 
                $mcancelButton.Top="253" 
                $mcancelButton.Left="426" 
                $mcancelButton.Anchor="Left,Top" 
                $mcancelButton.DialogResult=[System.Windows.Forms.DialogResult]::Cancel
        $mcancelButton.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mcancelButton) 
        $MyForm.CancelButton = $mcancelButton
    
        $mModExam = New-Object System.Windows.Forms.CheckBox 
                $mModExam.Text="ModExam" 
                $mModExam.Top="250" 
                $mModExam.Left="105" 
                $mModExam.Anchor="Left,Top" 
        $mModExam.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mModExam) 
         
 
        $mCaseStudy = New-Object System.Windows.Forms.CheckBox 
                $mCaseStudy.Text="CaseStudy" 
                $mCaseStudy.Top="250" 
                $mCaseStudy.Left="15" 
                $mCaseStudy.Anchor="Left,Top" 
        $mCaseStudy.Size = New-Object System.Drawing.Size(100,23) 
        $MyForm.Controls.Add($mCaseStudy) 


    
    #Show dialog and get response    
    $dialogResult = $MyForm.ShowDialog()
         
    # If the OK button is selected
    if ($dialogResult -eq "OK"){return $minputTextBox.Text, $moutputTextBox.Text, $mtestIDTextBox.Text, $mweightTextBox.Text, $mModExam.Checked, $mCaseStudy.Checked}
    else {exit}
}

Function Get-FileName($initialDirectory)
{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    #$OpenFileDialog.filter = "TXT (*.txt)| *.txt"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filename
}

Function Select-FolderDialog 
{
    param([string]$Description="Select Folder",[string]$RootFolder="Desktop")

 [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") |
     Out-Null     

   $objForm = New-Object System.Windows.Forms.FolderBrowserDialog
        $objForm.Rootfolder = $RootFolder
        $objForm.Description = $Description
        $Show = $objForm.ShowDialog()
        If ($Show -eq "OK")
        {
            Return $objForm.SelectedPath
        }
        Else
        {
            Write-Error "Operation cancelled by user."
        }
    }

function Create-Test-Xml ($testName, $testData, $file, $testWeight, $type) 
{

if($type -eq "modexam") {

#Setting XML Doc up
$xmlWriter = New-Object System.XMl.XmlTextWriter($file,$Null)
$xmlWriter.Formatting = 'Indented'
$xmlWriter.Indentation = 1
$XmlWriter.IndentChar = "`t"
$xmlWriter.WriteStartDocument()
$xmlWriter.WriteComment('Document Generated by XML Creator v1.0')


#Begin Question Pool
#$xmlWriter.WriteStartElement('questionPool')
#$xmlWriter.WriteElementString('hid', $testName)
#$xmlWriter.WriteElementString('name', $testName)

#tags
#$xmlWriter.WriteStartElement('tags')
#$xmlWriter.WriteElementString('tag', 'import')
#$xmlWriter.WriteEndElement()

#Beging Question Pool Set
$xmlWriter.WriteStartElement('questionPoolSet')
#$XmlWriter.WriteAttributeString('weight',$testWeight)
#$XmlWriter.WriteAttributeString('pick',$testData.Length)

#Get automatic question weight
$qweight = $testWeight / $testData.Length

##################################################
#Start looping through data to create questions###
##################################################

for($i=0;$i -lt $testData.Length;$i++) {

#Setting up variables
if ([string]::IsNullOrWhitespace($testData[0].Random)) {$random="true"} else {$random="false"}

#Setting Question Numbers
if (![string]::IsNullOrWhitespace($testData[$i].Num)) {$qnum = $testData[$i].Num -as [int]} 
else {$qnum = $i+1}
$tripDigNum = "{0:D2}" -f $qnum
$questionName = $testName + "_Q" + $tripDigNum + "0"


#QUESTION METADATA
$xmlWriter.WriteStartElement('question')
if ([string]::IsNullOrWhitespace($testData[$i].Weight)) {$XmlWriter.WriteAttributeString('weight',$qweight)}
if ([string]::IsNullOrWhitespace($testData[$i].Random)) {$XmlWriter.WriteAttributeString('random',$random)}
$xmlWriter.WriteElementString('hid', $questionName)
$xmlWriter.WriteElementString('name', $questionName)
$xmlWriter.WriteStartElement('tags')
$xmlWriter.WriteElementString('tag', 'import')
$xmlWriter.WriteEndElement()
$xmlWriter.WriteElementString('qtype','multipleChoice') #Look for type if there put there, else If wrong answer 3 is blank then MC

#QUESTION
$xmlWriter.WriteStartElement('richText')
$xmlWriter.WriteCData($testData[$i].Question)
$xmlWriter.WriteEndElement()

#FEEDBACK
$xmlWriter.WriteStartElement('feedback')
$xmlWriter.WriteCData($testData[$i].Feedback)
$xmlWriter.WriteEndElement()

#NOTE
$xmlWriter.WriteStartElement('note')
if (![string]::IsNullOrWhitespace($testData[$i].Note)) {$xmlWriter.WriteCData($testData[$i].Note)}
$xmlWriter.WriteEndElement()

#LEARNING OBJECTIVES
$xmlWriter.WriteStartElement('learningObjectives')
if (![string]::IsNullOrWhitespace($testData[$i].'Learning Objective')) {$xmlWriter.WriteCData($testData[$i].'Learning Objective')}
$xmlWriter.WriteEndElement()

############################
###MOVING INTO ANSWER SET###
############################
$xmlWriter.WriteStartElement('answers')

#ANSWER:1
$xmlWriter.WriteStartElement('answer')
$xmlWriter.WriteElementString('correct', 'true')
$xmlWriter.WriteElementString('points', '100')
$xmlWriter.WriteStartElement('value')
$xmlWriter.WriteCData($testData[$i].'Correct Answer')
$xmlWriter.WriteEndElement() #End Value
$xmlWriter.WriteEndElement() #End Answer

#ANSWER:2
$xmlWriter.WriteStartElement('answer')
$xmlWriter.WriteElementString('correct', 'false')
$xmlWriter.WriteElementString('points', '0')
$xmlWriter.WriteStartElement('value')
$xmlWriter.WriteCData($testData[$i].'Wrong Answer 1')
$xmlWriter.WriteEndElement() #End Value
$xmlWriter.WriteEndElement() #End Answer

#ANSWER:3
$xmlWriter.WriteStartElement('answer')
$xmlWriter.WriteElementString('correct', 'false')
$xmlWriter.WriteElementString('points', '0')
$xmlWriter.WriteStartElement('value')
$xmlWriter.WriteCData($testData[$i].'Wrong Answer 2')
$xmlWriter.WriteEndElement() #End Value
$xmlWriter.WriteEndElement() #End Answer

#ANSWER:4
$xmlWriter.WriteStartElement('answer')
$xmlWriter.WriteElementString('correct', 'false')
$xmlWriter.WriteElementString('points', '0')
$xmlWriter.WriteStartElement('value')
$xmlWriter.WriteCData($testData[$i].'Wrong Answer 3')
$xmlWriter.WriteEndElement() #End Value
$xmlWriter.WriteEndElement() #End Answer


$xmlWriter.WriteEndElement() #Ends answers

#####################
#LEAVING ANSWER SET##
#####################

#HINT
$xmlWriter.WriteStartElement('hints')
if (![string]::IsNullOrWhitespace($testData[$i].Hints)) {$xmlWriter.WriteCData($testData[$i].Hints)}
#$xmlWriter.WriteCData($testData[$i].Hints)
$xmlWriter.WriteEndElement()


$xmlWriter.WriteEndElement() #Ends question

}

#####################
##END OF QUESTIONS###
#####################

#Close Question Pool
#$xmlWriter.WriteEndElement()
$xmlWriter.WriteEndElement()
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()
}

}

function Create-Test-Xml-CaseStudy ($testName, $testData, $file, $testWeight, $type) 
{

if($type -eq "modexam") {

#Setting XML Doc up
$xmlWriter = New-Object System.XMl.XmlTextWriter($file,$Null)
$xmlWriter.Formatting = 'Indented'
$xmlWriter.Indentation = 1
$XmlWriter.IndentChar = "`t"
$xmlWriter.WriteStartDocument()
$xmlWriter.WriteComment('Document Generated by XML Creator v1.0')

#Beging Question Pool Set
$xmlWriter.WriteStartElement('questionPoolSet')


##################################################
#Start looping through data to create questions###
##################################################

for($i=0;$i -lt $testData.Length;$i++) {

#Setting Question Numbers
if (![string]::IsNullOrWhitespace($testData[$i].Num)) {$qnum = $testData[$i].Num -as [int]} 
else {$qnum = $i+1}
$tripDigNum = "{0:D2}" -f $qnum
$questionName = $testName + "_Q" + $tripDigNum + "0"



#QUESTION METADATA
$xmlWriter.WriteStartElement('question')
$xmlWriter.WriteElementString('hid', $questionName)
$xmlWriter.WriteElementString('name', $questionName)
$xmlWriter.WriteStartElement('tags')
$xmlWriter.WriteElementString('tag', 'import')
$xmlWriter.WriteEndElement()
$xmlWriter.WriteElementString('qtype','freeResponse') #Look for type if there put there, else default to freeResponse

#QUESTION
$xmlWriter.WriteStartElement('richText')
$xmlWriter.WriteCData($testData[$i].Question)
$xmlWriter.WriteEndElement()

#FEEDBACK
$xmlWriter.WriteStartElement('feedback')
$xmlWriter.WriteCData("Answer: " + $testData[$i].'Correct Answer' + "<br><br>" + $testData[$i].Feedback)
$xmlWriter.WriteEndElement()

#NOTE
$xmlWriter.WriteStartElement('note')
if (![string]::IsNullOrWhitespace($testData[$i].Note)) {$xmlWriter.WriteCData($testData[$i].Note)}
$xmlWriter.WriteEndElement()

#LEARNING OBJECTIVES
$xmlWriter.WriteStartElement('learningObjectives')
if (![string]::IsNullOrWhitespace($testData[$i].'Learning Objective')) {$xmlWriter.WriteCData($testData[$i].'Learning Objective')}
$xmlWriter.WriteEndElement()

############################
###MOVING INTO ANSWER SET###
############################
$xmlWriter.WriteStartElement('answers')
$xmlWriter.WriteEndElement() #Ends answers

#####################
#LEAVING ANSWER SET##
#####################

#HINT
$xmlWriter.WriteStartElement('hints')
if (![string]::IsNullOrWhitespace($testData[$i].Hints)) {$xmlWriter.WriteCData($testData[$i].Hints)}
#$xmlWriter.WriteCData($testData[$i].Hints)
$xmlWriter.WriteEndElement()


$xmlWriter.WriteEndElement() #Ends question

}

#####################
##END OF QUESTIONS###
#####################

#Close Question Pool
#$xmlWriter.WriteEndElement()
$xmlWriter.WriteEndElement()
$xmlWriter.WriteEndDocument()
$xmlWriter.Flush()
$xmlWriter.Close()
}

}

function Import-Excel
{
  param (
    [string]$FileName,
    [string]$WorksheetName,
    [bool]$DisplayProgress = $true
  )

  if ($FileName -eq "") {
    throw "Please provide path to the Excel file"
    Exit
  }

  if (-not (Test-Path $FileName)) {
    throw "Path '$FileName' does not exist."
    exit
  }

  $FileName = Resolve-Path $FileName
  $excel = New-Object -com "Excel.Application"
  $excel.Visible = $false
  $workbook = $excel.workbooks.open($FileName)

  sleep 10

  if (-not $WorksheetName) {
    Write-Warning "Defaulting to the first worksheet in workbook."
    $sheet = $workbook.ActiveSheet
  } else {
    $sheet = $workbook.Sheets.Item($WorksheetName)
  }
  
  if (-not $sheet)
  {
    throw "Unable to open worksheet $WorksheetName"
    exit
  }
  
  $sheetName = $sheet.Name
  $columns = $sheet.UsedRange.Columns.Count
  $lines = $sheet.UsedRange.Rows.Count
  
  Write-Warning "Worksheet $sheetName contains $columns columns and $lines lines of data"
  
  $fields = @()
  
  sleep 10

  for ($column = 1; $column -le $columns; $column ++) {
    $fieldName = $sheet.Cells.Item.Invoke(1, $column).Value2
    if ($fieldName -eq $null) {
      $fieldName = "Column" + $column.ToString()
    }
    $fields += $fieldName
  }
  
  $line = 2
  
  
  for ($line = 2; $line -le $lines; $line ++) {
    $values = New-Object object[] $columns
    for ($column = 1; $column -le $columns; $column++) {
      $values[$column - 1] = $sheet.Cells.Item.Invoke($line, $column).Value2
    }  
  
    $row = New-Object psobject
    $fields | foreach-object -begin {$i = 0} -process {
      $row | Add-Member -MemberType noteproperty -Name $fields[$i] -Value $values[$i]; $i++
    }
    $row
    $percents = [math]::round((($line/$lines) * 100), 0)
    if ($DisplayProgress) {
      Write-Progress -Activity:"Importing from Excel file $FileName" -Status:"Imported $line of total $lines lines ($percents%)" -PercentComplete:$percents
    }
  }
  $workbook.Close()
  $excel.Quit()
}

Function Main 
{
    #Get Input File, Output Folder, Test Name, and Test Weight
    $inputFile, $saveFolder, $name, $weight, $modExam, $caseStudy = display-inputbox

    #Convert to CSV
    #$tabDelimData = Import-Csv -Delimiter "`t" $inputfile
    #$tabDelimData = Import-Excel -FileName $inputFile

    $FileName = Resolve-Path $inputFile
    $excel = New-Object -com "Excel.Application"
    $excel.Visible = $false
    $workbook = $excel.workbooks.open($FileName)
    
    sleep 10

    $workSheetList = [System.Collections.ArrayList]@()
    $count = $workbook.Sheets.Count
    for($i=1; $i -le $count; $i++) {
    
    
        #Import data from excel from worksheet
        $tabDelimData = Import-Excel -FileName $FileName -WorksheetName $workbook.Worksheets.Item($i).Name

        #Set File Name from Test Name
        $saveFile = $saveFolder + "\" + $name + "_C0" + $i + "0" + ".xml"

        #Create Test
        if ($modExam -eq $true -and $caseStudy -eq $true) {exit}      
        if ($modExam -eq $true) {Create-Test-Xml $name $tabDelimData $saveFile $weight "modexam"}
        if ($caseStudy -eq $true) {Create-Test-Xml-CaseStudy $name $tabDelimData $saveFile $weight "modexam"}


        #Open your newly created XML File, try notepad++ first then notepad
        $noteExists = Test-Path 'C:\Program Files\Notepad++\notepad++.exe'
        $note32Exists = Test-Path 'C:\Program Files (x86)\Notepad++\notepad++.exe'
        if ($noteExists -eq "True") {& 'C:\Program Files\Notepad++\notepad++.exe' $saveFile}
        elseif ($noteExists -eq "True") {& 'C:\Program Files (x86)\Notepad++\notepad++.exe' $saveFile}
        else {& 'C:\Windows\System32\notepad.exe' $saveFile }
        }

}

Main


