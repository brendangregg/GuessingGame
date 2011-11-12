@ECHO OFF
REM guess.bat - guessing game in batch scripting (MSDOS, Win95, Win98)
REM
REM This is written to demonstrate this language versus the same program
REM written in other languages.
REM
REM Writing this program as a batch script is like pulling teeth.
REM Batch scripts cannot,
REM	add numbers (1 + 1)
REM	compare using greater/less than (>, <)
REM	read strings to variables
REM 	manipulate strings
REM	input from files to variables
REM	generate random numbers
REM 	...
REM hence this is not a complete implementation of the game (numbers are
REM only from 1 to 9, the random number is not very random (differs once
REM per 60 seconds), entering your name is awkward, and the highscore file
REM has a different format).
REM (4 temporary files are used - temp1.bat, temp2.bat, temp2.tmp, temp3.tmp)
REM
REM 26-Oct-2003	Brendan Gregg	Created this.

SET num=1
SET scorefile=highscores_bat

ECHO Guess.bat - Guess a number between 1 and 9
ECHO.


REM *** Generate random number ***
REM
REM (the number is based on the timestamp (minutes) of temp2.tmp)

ECHO (generating random number...)
dir > temp2.tmp
dir temp2.tmp | find "temp2.tmp" > temp1.bat
ECHO SET date=%%5 > temp2.bat
call temp1.bat
GOTO :random

:start

ECHO.
set answer=%random%


REM *** Play game ***
:game
	CHOICE /N /C:123456789 Enter guess %num%: 
	IF ERRORLEVEL 1 SET GUESS=1
	IF ERRORLEVEL 2 SET GUESS=2
	IF ERRORLEVEL 3 SET GUESS=3
	IF ERRORLEVEL 4 SET GUESS=4
	IF ERRORLEVEL 5 SET GUESS=5
	IF ERRORLEVEL 6 SET GUESS=6
	IF ERRORLEVEL 7 SET GUESS=7
	IF ERRORLEVEL 8 SET GUESS=8
	IF ERRORLEVEL 9 SET GUESS=9
	IF %guess%==%answer% GOTO :end
	SET check=0
	SET found=0
	GOTO :check
:game1

	SET add=%num%
	SET return=:game2
	GOTO :add
:game2
	SET num=%add%

GOTO :game


REM (generate random number. inputs the %date% variable and runs)
REM (a modulus algorithm on the minutes)

:random
	SET count=00
	SET random=1
	SET max=10
:random1
	ECHO %date% | find ":%count%" > NUL
	IF ERRORLEVEL 1 GOTO :random2
	GOTO :start
:random2
	SET add=%count%
	SET return=:random3
	GOTO :add
:random3
	SET count=%add%
	SET add=%random%
	SET return=:random4
	GOTO :add
:random4
	SET random=%add%
	IF %random%==%max% SET random=1
	IF %count%==101 GOTO :random5
	GOTO :random1
:random5
	REM (something failed, default to 5)
	SET random=5
	GOTO :start


REM (check whether the guess was higher or lower)

:check
	IF %check%==11 GOTO :game1

	SET add=%check%
	SET return=:check2
	GOTO :add
:check2
	SET check=%add%

	IF %check%==%answer% SET found=1
	IF %check%==%guess% GOTO :check3
	GOTO :check
:check3
	IF %found%==1 ECHO Lower...
	IF %found%==0 ECHO Higher...
GOTO :game1


REM (increment a number by 1. batch scripts can't normally do math)

:add
	if %add%==100 set add=101
	if %add%==99 set add=100
	if %add%==98 set add=99
	if %add%==97 set add=98
	if %add%==96 set add=97
	if %add%==95 set add=96
	if %add%==94 set add=95
	if %add%==93 set add=94
	if %add%==92 set add=93
	if %add%==91 set add=92
	if %add%==90 set add=91
	if %add%==89 set add=90
	if %add%==88 set add=89
	if %add%==87 set add=88
	if %add%==86 set add=87
	if %add%==85 set add=86
	if %add%==84 set add=85
	if %add%==83 set add=84
	if %add%==82 set add=83
	if %add%==81 set add=82
	if %add%==80 set add=81
	if %add%==79 set add=80
	if %add%==78 set add=79
	if %add%==77 set add=78
	if %add%==76 set add=77
	if %add%==75 set add=76
	if %add%==74 set add=75
	if %add%==73 set add=74
	if %add%==72 set add=73
	if %add%==71 set add=72
	if %add%==70 set add=71
	if %add%==69 set add=70
	if %add%==68 set add=69
	if %add%==67 set add=68
	if %add%==66 set add=67
	if %add%==65 set add=66
	if %add%==64 set add=65
	if %add%==63 set add=64
	if %add%==62 set add=63
	if %add%==61 set add=62
	if %add%==60 set add=61
	if %add%==59 set add=60
	if %add%==58 set add=59
	if %add%==57 set add=58
	if %add%==56 set add=57
	if %add%==55 set add=56
	if %add%==54 set add=55
	if %add%==53 set add=54
	if %add%==52 set add=53
	if %add%==51 set add=52
	if %add%==50 set add=51
	if %add%==49 set add=50
	if %add%==48 set add=49
	if %add%==47 set add=48
	if %add%==46 set add=47
	if %add%==45 set add=46
	if %add%==44 set add=45
	if %add%==43 set add=44
	if %add%==42 set add=43
	if %add%==41 set add=42
	if %add%==40 set add=41
	if %add%==39 set add=40
	if %add%==38 set add=39
	if %add%==37 set add=38
	if %add%==36 set add=37
	if %add%==35 set add=36
	if %add%==34 set add=35
	if %add%==33 set add=34
	if %add%==32 set add=33
	if %add%==31 set add=32
	if %add%==30 set add=31
	if %add%==29 set add=30
	if %add%==28 set add=29
	if %add%==27 set add=28
	if %add%==26 set add=27
	if %add%==25 set add=26
	if %add%==24 set add=25
	if %add%==23 set add=24
	if %add%==22 set add=23
	if %add%==21 set add=22
	if %add%==20 set add=21
	if %add%==19 set add=20
	if %add%==18 set add=19
	if %add%==17 set add=18
	if %add%==16 set add=17
	if %add%==15 set add=16
	if %add%==14 set add=15
	if %add%==13 set add=14
	if %add%==12 set add=13
	if %add%==11 set add=12
	if %add%==10 set add=11
	if %add%==09 set add=10
	if %add%==08 set add=09
	if %add%==07 set add=08
	if %add%==06 set add=07
	if %add%==05 set add=06
	if %add%==04 set add=05
	if %add%==03 set add=04
	if %add%==02 set add=03
	if %add%==01 set add=02
	if %add%==00 set add=01
	if %add%==9 set add=10
	if %add%==8 set add=9
	if %add%==7 set add=8
	if %add%==6 set add=7
	if %add%==5 set add=6
	if %add%==4 set add=5
	if %add%==3 set add=4
	if %add%==2 set add=3
	if %add%==1 set add=2
	if %add%==0 set add=1
GOTO %return%

:end
ECHO Correct! That took %num% guesses
ECHO.


REM *** Save high score ***

ECHO Type in your name (then enter, ctrl-Z, enter),
COPY CON temp3.tmp
type temp3.tmp >> %scorefile%
ECHO %num% >> %scorefile%


REM *** Print high scores ***
ECHO.
ECHO Previous high scores,
type %scorefile%

del temp1.bat
del temp2.tmp
del temp2.bat
del temp3.tmp

