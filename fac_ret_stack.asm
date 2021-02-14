;%include "io.inc"
section .data
    message db "Die Fakultät von 0x%08X ist 0x%08X", 10, 0
section .text


; Fakultaetsfunktion
;
; In Hochsprache:
;    retval = fac(n)
;
; 'retval': Wird ueber den _Stack_ zurückgegeben, nicht in einem Register
;   * Aufrufender Code allokiert vorher 4 Bytes auf dem Stack (Tipp: den untenstehenden Code lesen und dies nachvollziehen)
;   * fac function schreibt anschliessend Rückgabewert an diese Speicherstelle (Ihre Aufgabe!)
;
; Parameter 'n' wird (wie üblich) auf dem Stack uebergeben
;
; Achtung: Keine Register dürfen nach dem Aufruf verändert sein!

fac:
    push eax
    push ecx
    mov ecx, [esp+12]
    mov eax, ecx
    cmp ecx, 0
    jle return
    cmp ecx, 1
    je return1
schleife:
    dec ecx
    imul ecx
    cmp ecx, 1
    jne schleife
    mov [esp+16], eax
    pop ecx
    pop eax
    ret

return1:
    mov [esp+16], Dword 1

return:
    pop ecx
    pop eax
    ret



    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; HA STARTET HIER
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


    ;TODO


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; HA ENDET HIER
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

global main
extern printf
main:
    mov ebp, esp; for correct debugging
    mov eax, 0xffffffff
    mov ebx, 0xffffffff
    mov ecx, 0xffffffff
    mov edx, 0xffffffff


    sub esp, 4  ; Speicher fuer Rueckgabewert allokieren
    push 0     ; n=1
    call fac

    push message
    call printf
    add esp, 12

    sub esp, 4  ; Speicher fuer Rueckgabewert allokieren
    push 1      ; n=1
    call fac

    push message
    call printf
    add esp, 12

    sub esp, 4  ; Speicher fuer Rueckgabewert allokieren
    push 2      ; n=2
    call fac

    push message
    call printf
    add esp, 12

    sub esp, 4  ; Speicher fuer Rueckgabewert allokieren
    push 3      ; n=3
    call fac

    push message
    call printf
    add esp, 12

    sub esp, 4  ; Speicher fuer Rueckgabewert allokieren
    push 4      ; n=4
    call fac

    push message
    call printf
    add esp, 12

    sub esp, 4  ; Speicher fuer Rueckgabewert allokieren
    push 5      ; n=5
    call fac

    push message
    call printf
    add esp, 12

    ret
