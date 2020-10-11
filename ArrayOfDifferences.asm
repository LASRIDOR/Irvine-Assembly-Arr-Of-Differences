TITLE the array of differences

; This program Print the array of differences array location is in Data.inc


; Student Name: Dor Lasri

INCLUDE Irvine32.inc
INCLUDE Data.inc

.data
header BYTE "Dor Lasri",13,10,0
seperation BYTE ", "
.code
myMain PROC

    ; Write header to the user
    mov edx,offset header
    call writeString

    push LENGTHOF Arr_1
    push offset Arr_2
    push offset Arr_1
    call print_diff_arr
    call crlf ; new line

    exit
myMain ENDP

set_diff PROC
    N1 = 8
    N2 = N1+2
    SumPtr = N2+2
    push ebp
    mov ebp,esp

    push eax
    push ebx

    mov bx,[ebp+N1]
    sub bx,[ebp+N2]
    mov eax, [ebp+SumPtr]
    mov [eax],bx

    pop ebx
    pop eax

    mov esp, ebp
    pop ebp
    ret 8
set_diff ENDP

print_word_arr PROC
    ArrPtr = 8
    ArrSize = ArrPtr+4

    push ebp
    mov ebp, esp

    push esi
    push edx
    push ecx
    push ebx

    mov esi, 0
    mov ebx, [ebp + ArrPtr]
    mov ecx, [ebp + ArrSize]

    loop1:
        movsx eax,WORD PTR [ebx+(esi*2)]
        call writeInt
        mov edx, offset seperation
        call writeString
        inc esi
    loop loop1

    pop ebx
    pop ecx
    pop edx
    pop esi

    mov esp, ebp
    pop ebp
    ret 8
print_word_arr ENDP


print_diff_arr PROC
    ArrPtr1 = 8
    ArrPtr2 = ArrPtr1 + 4
    ArrSize = ArrPtr2 + 4
    push ebp
    mov ebp, esp

    sub esp, [ebp +ArrSize ]
    sub esp, [ebp +ArrSize ]
    push esi
    lea esi, [esp]

    push eax
    push ebx
    push edx
    push ecx
    push edi

    mov edi, esi
    mov ebx, [ebp + ArrPtr2]
    mov edx , [ebp + ArrPtr1]
    mov ecx, [ebp + ArrSize]
    loopSetDiff:
    push edi
    push WORD PTR [ebx]
    push WORD PTR [edx]
    call set_diff
    add edi, 2
    add ebx, 2
    add edx, 2
    loop loopSetDiff

    mov edx, offset msg1
    call writeString

    push [ebp + ArrSize]
    push esi
    call print_word_arr

    pop edi
    pop ecx
    pop edx
    pop ebx
    pop eax
    pop esi

    mov esp, ebp
    pop ebp
    ret 12
print_diff_arr ENDP

END myMain