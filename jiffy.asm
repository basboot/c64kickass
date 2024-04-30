.const charmem = $0400
.const jifflow = $a2

*=$1000
main:
    lda jifflow
    sta charmem
    lda #60
    jsr jiffwait
    jmp main

jiffwait:
  clc
  adc jifflow     // Add time to wait to 'now'

jiffwtlp:
  ldx jifflow
  cmp jifflow     // Are we there yet
  bne jiffwtlp    // No -> Continue waiting
  rts             // Done waiting