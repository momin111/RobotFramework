*** Settings ***
Library           SeleniumLibrary
Test Teardown     Close Browser


*** Variables ***
${SERVER}         www.w3schools.com
${BROWSER}        Chrome
${DELAY}          0
${HOMEPAGE URL}      https://${SERVER}/


*** Test Cases ***
Open Homepage
	Given Go to URL "${HOMEPAGE URL}"
	When Log 	${HOMEPAGE URL}
	Then Verify URL is "${HOMEPAGE URL}"
	
Open Html Tutorial
	Given Go to URL "${HOMEPAGE URL}"
	When Click On Learn HTML Menu
	Then Verify URL is "https://www.w3schools.com/html/default.asp"
	
Search For Tutorial
	Given Go to URL "${HOMEPAGE URL}"
	When Search CSS Tutorial
	Then Verify URL is "https://www.w3schools.com/css/default.asp"
	And Verify Title is "CSS Tutorial"
	
Visit Link Using Partial Link Text
	Given Go to URL "${HOMEPAGE URL}"
	When Click Using Partial Link Text
	Then Verify URL is "https://www.w3schools.com/where_to_start.asp"


*** Keywords ***
Go to URL "${url}"
	Open Browser    ${url}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
	
Verify URL is "${url}"
	${Current URL}  Get Location
    Log     URL is ${Current URL}
	Should Match    ${Current URL}    ${url}
	
Verify Title is "${title}"
	Title Should Be		${title}
	
Check For Privacy Dialog
	${count}	Get Count		xpath://div[@id="accept-choices"]	div
	Log to console		${count}
	Run Keyword If	${count} > 0	Accept Cookies
	
Accept Cookies
	Log to console 	"Accepting cookies"
	Wait Until Element Is Visible	id:accept-choices
	Click Element	id:accept-choices
	
Click On Learn HTML Menu
	Check For Privacy Dialog
	Click Element	id:navbtn_tutorials
	Click Element	xpath://a[@class="w3-bar-item w3-button" and contains(text(), "Learn HTML")]
	
Search CSS Tutorial
	Check For Privacy Dialog
	Input Text		id:search2	CSS Tutorial
	Click Element 	id:learntocode_searchbtn

Click Using Partial Link Text
	Check For Privacy Dialog
	When Click Element		partial link:Not Sure Where
	