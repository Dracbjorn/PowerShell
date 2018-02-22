param($xml)
$ErrorActionPreference="SilentlyContinue"
Stop-Transcript | out-null
$ErrorActionPreference = "Continue"
Start-Transcript -path ./output.txt -append

#Turn the exame xml into an object
[xml]$survey = Get-Content $xml

#Pull out the top level object
$caseStudy = $survey.caseStudy

#Narrow in on the actual questions related to the exam
$questions = $survey.caseStudy.question

#Total number of questions in the exam
$totalNum = $questions.length

Write-Host -f cyan "Questions and Answers"
Write-Host "---------------------------------"

#List containing all the details for all questions in the exam
$questionsList = @{}
$outerNum = 1
foreach ($question in $questions){

    #Created a nested List in the master list to hold all data for this particular question
    $questionsList.Add("question$outerNum", @{})
    #Point value out of 100 for the question
    $questionsList["question$outerNum"].Add("weight", $question.weight)
    #Is the questions answers set to be randomized
    $questionsList["question$outerNum"].Add("isRandom", $question.random)
    #Name of the exam the question belongs to
    $questionsList["question$outerNum"].Add("name", $question.name)
    #The actual question asked in the exam
    $questionsList["question$outerNum"].Add("question_string", $question.richText)
    #Any feedback given to the student post exam
    $questionsList["question$outerNum"].Add("feedback", $question.feedback)
    #Any notes added to the question for reference
    $questionsList["question$outerNum"].Add("note", $question.note)
    #Any additional comments added to the question
    $questionsList["question$outerNum"].Add("comment", $question.'#comment')
    
    #A list of the available answers for this question
    $answers = $question.answers.answer
    #List of all answers for the question
    $answerList = @{}
    $innerNum = 1
    foreach ($answer in $answers){
        $answerDetails = @{"correct" = $answer.correct ; "points" = $answer.points ; "value" = $answer.value}
        $answerList.Add("answer$innerNum", $answerDetails)
        $innerNum++
    }

    #Add all of the answers to the question
    $questionsList["question$outerNum"].Add("answers", $answerList)

    #Print the Question, Answers, and Learning Objective to the screen
    #Learning Objective for this question
    $qComment = $questionsList["question$outerNum"].comment
    #Feedback for the question
    $qFeedback = $questionsList["question$outerNum"].feedback.InnerText
    #Note for the question
    $qNote = $questionsList["question$outerNum"].note.InnerText
    #Actual question being asked
    $qAsked = $questionsList["question$outerNum"].question_string.InnerText

    Write-Host -f white "Question ${outerNum}:`n"
    Write-Host -f Cyan "$qAsked`n"
    Write-Host -f Cyan "Answers:"

    #Get the number of available answers
    $count = $questionsList["question$outerNum"].answers.count
    #Print each answer to the screen
    foreach ($num3 in 1..$count){
        $ans = $questionsList["question$outerNum"].answers["answer$num3"].value.InnerText
        #$questionsList["question1"].answers["answer$num3"].value.InnerText | get-member
        $tOrF = $questionsList["question$outerNum"].answers["answer$num3"].correct

        if ($tOrF -eq "true"){
            Write-Host -f green "`t$tOrF : $ans"
        } elseif ($tOrF -eq "false"){
            Write-Host -f red "`t$tOrF : $ans"
        } else {
            Write-Host -f yellow "`tDATA MISSING"
        }
    }

    #print a newline then notes related to the question
    Write-Host ""
    Write-Host -f white -NoNewline "Learning Objective: "
    Write-Host -f Gray "$qComment`n"
    Write-Host -f white -NoNewline "Instructor Feedback: "
    Write-Host -f Gray "$qFeedback`n"
    Write-Host -f white -NoNewline "Notes: "
    Write-Host -f Gray "$qNote`n"
    Write-Host "======================================================"
    #increment to parse next question
    $outerNum++
}

$learnObjList = @{}
$learnObjList.Add('Kernel Basics and Config Files', @{'code' = '1';'number' = 0})
$learnObjList.Add('Shells and Scripting', @{'code' = '2';'number' = 0})
$learnObjList.Add('Filesystems', @{'code' = '3,4';'number' = 0})
$learnObjList.Add('Boot Init and Login', @{'code' = '5,6';'number' = 0})
$learnObjList.Add('Processes and Signals', @{'code' = '7';'number' = 0})
$learnObjList.Add('Networking and Name Resolution', @{'code' = '8,9,10';'number' = 0})
$learnObjList.Add('Users and Permissions', @{'code' = '11,12,13,14,15';'number' = 0})
$learnObjList.Add('UNIX Logging', @{'code' = '16,17,18,19,20,21,22,23,24,25';'number' = 0})
$learnObjList.Add('IPtables and Snort', @{'code' = '23,24,25';'number' = 0})
$learnObjList.Add('UNIX Survey Methodology', @{'code' = '26,27,28,29,30';'number' = 0})


Write-Host -f cyan "`nLearning Objectives and Code IDs"
Write-Host "---------------------------------"
$count = $questionsList.count
$num = 1
foreach ($qNum in 1..$count){
    $a = $questionsList["question$qNum"].comment
    $b = $a -replace '(.*)\D+(\d+)\D+(.*)','$2'
    foreach ($c in $b){
        
        switch -regex ($c){
            '1'{
                $learnObjList['Kernel Basics and Config Files'].number += 1
            }
            '2'{
                $learnObjList['Shells and Scripting'].number += 1
            }
            '3|4'{
                $learnObjList['Filesystems'].number += 1
            }
            '5|6'{
                $learnObjList['Boot Init and Login'].number += 1
            }
            '7'{
                $learnObjList['Processes and Signals'].number += 1
            }
            '8|9|10'{
                $learnObjList['Networking and Name Resolution'].number += 1
            }
            '11|12|13|14|15'{
                $learnObjList['Users and Permissions'].number += 1
            }
            '16|17|18|19|20|21|22'{
                $learnObjList['UNIX Logging'].number += 1
            }
            '23|24|25'{
                $learnObjList['IPtables and Snort'].number += 1
            }
            '26|27|28|29|30'{
                $learnObjList['UNIX Survey Methodology'].number += 1
            }
            default{
                Write-Host -f yellow "NOT A LEARNING OBJECTIVE!"
                Write-Host -f red "$c $a"
                $num--
            }
        }
        if ($c -match "[0-9]{1,2}"){
            Write-Host -f green -NoNewline "$c : "
            Write-Host -f white "$a"
        }
    }
    $num++
}
$num -= 1
Write-Host -f magenta -NoNewline "$num : "
Write-Host -f yellow "TOTAL OBJECTIVES PARSED`n"

Write-Host -f cyan "Questions Per Learning Objectives"
Write-Host "---------------------------------"
foreach ($i in $learnObjList.Keys){
    foreach ($j in $learnObjList["$i"]){
        Write-Host -f green -NoNewline $j.number" : " 
        Write-Host -f white $i
    }
}
Write-Host -f magenta -NoNewline $count" : "
Write-Host -f yellow "TOTAL QUESTIONS"

# do some stuff
Stop-Transcript