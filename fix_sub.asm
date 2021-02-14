%ifndef era
%include "io.inc"
%endif

section .data
global fix_sub_asm

%ifndef era
global main
%endif

section .text

;You can add stuff to main as well
%ifndef era
main:
    ;14.5 - 5
    ;push 5
    push 0
    push 335544320
    ;push 14.5
    push 0
    push 973078528
    call fix_sub_asm

    add esp, 16

    ;result in edx:eax
    ret
%endif

;ASSIGNMENT START: fix_sub_asm

fix_sub_asm:
  push ebp
  mov ebp, esp
  push ebx
  mov eax, [ebp + 8]
  mov edx, [ebp + 16]
  sub eax, edx

  mov edx, [ebp + 12]
  mov ebx, [ebp + 20]
  JNC sub1
  dec edx
sub1:   sub edx, ebx
        pop ebx
        pop ebp
        ret

;ASSIGNMENT END: fix_sub_asm

cont:
;multiply lower - lower - ergebnis:52 nachkomma
mov eax, [ebp + 8]
mov ebx, [ebp + 16]
mul ebx
shr eax, 26
mov ebx, edx
shr ebx, 26
shl edx, 6
add eax, edx
mov ecx,eax
mov esi, ebx


; crossmult higher-lower - ergebnis:20 nachkomma
mov eax, [ebp+8]
mov ebx, [ebp+20]
mul ebx
shl edx, 6
mov ebx, eax
shr ebx, 26
add edx, ebx
shl eax, 6
add ecx, eax
add esi, edx

;crossmult lower-higher - ergebnis:20 nachkomma
mov eax, [ebp+16]
mov ebx, [ebp+12]
mul ebx
shl edx, 6
mov ebx, eax
shr ebx, 26
add edx, ebx
shl eax, 6
add ecx, eax
add esi, edx

;mult higher-higher - ergebnis:12 vorkomma
mov eax, [ebp + 12]
mov ebx, [ebp + 20]
mul ebx
shl eax, 12
add esi, eax
