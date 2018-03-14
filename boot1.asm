[org 0]								;메모리의 몇 번지에서 실행해야 하는지 알려주는 선언문
[bits 16]							;이 프로그램이 16비트 단위로 데이터를 처리하는 프로그램임을 알린다.
	jmp 0x07c0:start				;세그먼트:오프셋 논리주소 형식으로, 0x07c0:0x5 주소로 이동한다.
									;이 때 동시에 CS레지스터는 0x0000이, IP에는 0x7c00이 삽입된다.
	
	
start:								;위에서 점프하면 이곳에서 명령을 수행한다.
	mov ax, cs						;AX를 통해 DS를 CS에 저장된 값으로 초기화 한다.
	mov ds, ax						;즉 DS는 0x0000으로 초기화 된다.
	
	mov ax, 0xB800					;ax를 통해 ES를 0xB800으로 초기화 한다. 비디오 메모리 영역
	mov es, ax						
	mov di, 0						;DI를 0으로 초기화 한다.
	mov ax, word [msgBack]			;하단부에 정의된 문자를 워드 단위로 읽어들이고 임시로 AX에 저장한다.
	mov cx, 0x7FF					;CX를 0x7FF로 초기화한다.
	
	
	
	
paint:
	mov word [es:di], ax			;AX 값 [msgBack]을 워드 단위로 논리 주소인 [es:di]에 저장한다.
	add di, 2						;0으로 초기화 되었던 DI레지스터의 주소값을 2바이트씩 더한다.
	dec cx							;0x7FF로 초기화 되었던 cx 값을 1씩 줄인다.
									;CX값이 0이 되면 ZF가 자동으로 0이된다.
									

	jnz paint						;ZF가 0이면 다음으로 넘어가고 1이면 Paint:의 처음으로 돌아가서 반복 실행한다.
	
	
	mov edi, 0
	mov byte [es:edi], 'G'
	inc edi
	mov byte [es:edi], 0x05
	inc edi
	mov byte [es:edi], 'U'
	inc edi
	mov byte [es:edi], 0X16
	inc edi
	mov byte [es:edi], 'A'
	inc edi
	mov byte [es:edi], 0x27
	inc edi
	mov byte [es:edi], 'V'
	inc edi
	mov byte [es:edi], 0x30
	inc edi
	mov byte [es:edi], 'A'
	inc edi
	mov byte [es:edi], 0x41
	inc edi
	
	jmp $
	
msgBack db ' ', 0x17

times 510-($-$$) db 0

dw 0xAA55