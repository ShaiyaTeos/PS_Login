%include    "src/pe.asm"
bits        32

va_section  .text

; ==============================================================================================================================================================
; Teos PS_Login (built on top of the original Ep4 ps_login found at https://archive.shaiya.net/server/ep4.5/PSM_Client/Bin/ps_login.exe)
; ==============================================================================================================================================================

; Patch: Add support for handling custom packets.
va_org      0x40436D
jmp         CUser_OnRecv
times       2 nop

; Patch: Fix invalid RSA payload crash (https://www.elitepvpers.com/forum/shaiya-pserver-guides-releases/4387243-ps_login-handshake-exploit-fix.html#post36452650)
va_org      0x404542
jne         0x4044BE

; Patch: Fix the call to `try_gamelogin_korea`, and the sql injection.
va_org      0x406ED9
push        GameLogin_Exec

; Include read-only resources
va_section  .rdata

; Include mutable data
va_section  .data

; Include custom code.
va_section  .teos
%include    "src/sql.asm"
%include    "src/packets.asm"

; Include the remaining data.
va_org      end