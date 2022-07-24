include		windows.inc 
include		kernel32.inc 
include		user32.inc 
include     gdi32.inc  
include 	shell32.inc
include		winmm.inc
include		masm32.inc
include		msvcrt.inc
include		comctl32.inc
include		oleaut32.inc
include		ole32.inc
include		advapi32.inc
include		comdlg32.inc
include     /masm32/macros/macros.asm

includelib	kernel32.lib
includelib	user32.lib 
includelib 	gdi32.lib
includelib 	shell32.lib
includelib	winmm.lib
includelib 	masm32.lib
includelib	msvcrt.lib
includelib	comctl32.lib
includelib  oleaut32.lib
includelib  ole32.lib
includelib	advapi32.lib
includelib	comdlg32.lib

include btnt.inc

include MagicV2mEngine.inc
includelib MagicV2mEngine.lib

DlgProc			PROTO	:DWORD,:DWORD,:DWORD,:DWORD

.const
IDD_MAIN	equ	1000
IDD_ABOUT	equ	2000
IDB_EXIT	equ	1001
IDB_ABOUT	equ	1002
IDB_COPY	equ	1003
IDC_NAME	equ	1004
IDC_MAIL	equ	1005
IDC_SERIAL	equ	1006

.data
include flowers.inc
WindowTitle	db	"Gmail Notifier Pro 5.3.5 Keygen",0
DefaultName	db  "Al0hA^PRF",0
DefaultMail	db	"husene@tatabandit.tk",0
TxtFont		LOGFONT <8,8,0,0,FW_DONTCARE,0,0,0,DEFAULT_CHARSET,OUT_DEFAULT_PRECIS,CLIP_DEFAULT_PRECIS,DEFAULT_QUALITY, 0,"terminal">
r3kt			RECT	<>
DELAY_VALUE			equ		6
Transparency		dd		?
TRANSPARENT_VALUE	equ 254

.data?
hInstance	dd	?
xWnd		dd	?
hFont			dd	?
hSerial			dd	?
hName			dd	?
hMail			dd	?
hIMG			dd  ?
WndRect		RECT	<>
NameRect	RECT	<>
XndRect		RECT	<>
SerialRect	RECT	<>
YndRect		RECT	<>
MailRect	RECT	<>
nHeight    		dd ?
nWidth			dd ?
hBrush			dd ?