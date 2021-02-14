%ifndef era
%include "io.inc"
%endif

;including fix sub.asm did not work


section .data
global fix_mul_asm
flag db 0
flag2 db 0

%ifndef era
global main
%endif

section .text

;You can add stuff to main as well
%ifndef era
main:
    ;calculate 13 * 2.5
    ;push 2.5
    push 0
    push 167772160
    ;push 13
    push 0
    push 872415232
    call fix_mul_asm
    add esp, 16
    ;value in edx:eax
    ;...do other stuff
    ret
%endif

;ASSIGNMENT START: fix_mul_asm
;edx:eax
negate:
push ecx
mov ecx, [flag]
xor ecx, 1
mov [flag], ecx
push edx
push eax
push 0; werte negieren  0 - negativ
push 0
call fix_sub_asm
add esp, 16
pop ecx
ret


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




fix_mul_asm:
push ebp
mov ebp, esp
push ebx
push ecx; übertrag -lower
push esi; üebertrag -higher
xor ecx, ecx
xor esi, esi

;check if negative
mov edx, [ebp + 12]
mov eax, [ebp + 8]
cmp edx, 0
jge test2
call negate
mov [ebp + 12], edx
mov [ebp + 8], eax

test2:
mov edx, [ebp + 20]
mov eax, [ebp + 16]
cmp edx, 0
jge cont
call negate
mov [ebp + 20], edx
mov [ebp + 16], eax


increment1:



; new try from here
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
JNC here2 ; if carry then add 1 to higher
inc esi
here2:
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
JNC here ; if carry then add 1 to higher
inc esi
here:
add esi, edx

;mult higher-higher - ergebnis:12 vorkomma
mov eax, [ebp + 12]
mov ebx, [ebp + 20]
mul ebx
shl eax, 6
add esi, eax

;final
mov eax, ecx
mov edx, esi

;check if supposed to be negative
mov ecx, [flag]
cmp ecx, 0
je ende
call negate



ende:
pop esi
pop ecx
pop ebx
pop ebp
ret







;ASSIGNMENT END: fix_mul_asm
