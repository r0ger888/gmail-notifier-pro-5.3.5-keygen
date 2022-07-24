
include sha1.asm

Hex2ch 		PROTO	:DWORD,:DWORD,:DWORD
GenKey		PROTO	:DWORD

.data
NoName		 db	"insert ur name .",0
NoMail		 db	"insert ur mail .",0
ShaFinalHash	 db	100h	dup(0)

.data?
NameBuffer	 db	60h 	dup(?) 
MagicBuff	 db	60h 	dup(?)
MailBuffer	 db	60h 	dup(?)
SrlBuffer 	 db	60h 	dup(?)
hLen		 dd	?

.code
Hex2ch proc HexValue:DWORD,CharValue:DWORD,HexLength:DWORD
    mov esi,[ebp+8]
    mov edi,[ebp+0Ch]
    mov ecx,[ebp+10h]
    @HexToChar:
      lodsb
      mov ah, al
      and ah, 0Fh
      shr al, 4
      add al, '0'
      add ah, '0'
       .if al > '9'
          add al, 'A'-'9'-1
       .endif
       .if ah > '9'
          add ah, 'A'-'9'-1
       .endif
      stosw
    loopd @HexToChar
    ret
Hex2ch endp

GenKey proc hWin:DWORD
	
	invoke GetDlgItemText,hWin,IDC_NAME,addr NameBuffer,sizeof NameBuffer
	invoke GetDlgItemText,hWin,IDC_MAIL,addr MailBuffer,sizeof MailBuffer

	invoke lstrlen, addr NameBuffer
	mov edi,eax
	
	.if eax == 0
		invoke SetDlgItemText,hWin,IDC_SERIAL,addr NoName
		invoke GetDlgItem,hWin,IDB_COPY
		invoke EnableWindow,eax,FALSE
		ret
	.endif
	
	invoke lstrlen, addr MailBuffer
	
	.if eax == 0
		invoke SetDlgItemText,hWin,IDC_SERIAL,addr NoMail
		invoke GetDlgItem,hWin,IDB_COPY
		invoke EnableWindow,eax,FALSE
		ret
	.endif
	
	; these registers retrieve only the chars from a-z, UPPERCASE and lowercase, only in the name buffer.
	; so it doesn't include the numbers and special chars such as [^] , [&] , [#] , etc.
	
	xor eax,eax
	xor ecx,ecx
	xor edx,edx
	
	begin_keygeneration:
		
		movzx eax, byte ptr ds:[NameBuffer+ecx]
		cmp al,041h
		jl generation1
		cmp al,05Ah
		jg generation1
		mov byte ptr [MagicBuff+edx],al
		inc edx
		jmp generation2
		
		generation1:
			
			cmp al,061h	
			jl generation2	
			cmp al,07Ah
			jg generation2
			mov byte ptr [MagicBuff+edx],al
			inc edx
			
		generation2:
			
			inc ecx
			cmp ecx,edi ; save the ecx register to the name buffer
			jnz begin_keygeneration
			
		invoke lstrcat,addr MagicBuff, addr MailBuffer
		xor eax,eax
		
		invoke lstrlen,addr MagicBuff	
		mov hLen,eax						
		invoke SHA1Init										
		invoke SHA1Update,addr MagicBuff,hLen			
		invoke SHA1Final										
		invoke Hex2ch,addr SHA1Digest,addr ShaFinalHash,32
	
	xor eax,eax
	xor ecx,ecx
	
	; formatting the serial in SHA1 string of 16 chars consisting of the begin_keygeneration procedure that includes
	; ripped structures and values from olly . and this time i haven't used IDA pro for that,only olly.
	
	finalization:
		
		movzx eax,byte ptr ds:[ShaFinalHash+ecx]
		mov byte ptr ds:[SrlBuffer+ecx],al
		inc ecx
		cmp ecx,16
		
	jnz finalization
	
	invoke SetDlgItemText,hWin,IDC_SERIAL,addr SrlBuffer	
	invoke GetDlgItem,hWin,IDB_COPY
	invoke EnableWindow,eax,TRUE
	call Clean
	
	ret
	
GenKey endp

Clean proc
	invoke RtlZeroMemory,addr SrlBuffer,sizeof SrlBuffer
	invoke RtlZeroMemory,addr ShaFinalHash,sizeof ShaFinalHash
	invoke RtlZeroMemory,addr MagicBuff,sizeof MagicBuff
	Ret
Clean endp