.const charmem = $fb
.const color = $fd
.const jifflow = $a2

*=$1000

main:
  lda #0
  sta color // start color

repeat:
  lda #$00
  sta charmem
  lda #$04
  sta charmem + 1

  
  ldx #0

outerloop:  
  ldy #0

loop:
  lda #224
  sta (charmem), y

  lda charmem + 1
  clc
  adc #$d4
  sta charmem + 1

  // lda #7
  // txa
  lda color
  sta (charmem), y

  lda charmem + 1
  sec
  sbc #$d4
  sta charmem + 1

  clc

  iny
  cpy #40

  bne loop

  clc
  lda charmem
  adc #40 // next line
  sta charmem
  lda charmem + 1
  adc #0 // carry
  sta charmem + 1

  inc color

  inx
  cpx #25

  bne outerloop

//   // delay
//   ldx #0
delay:
  lda #60
  jsr jiffwait

  jmp repeat // endless repeat

  rts

// https://retrocomputing.stackexchange.com/questions/26983/assembly-delay-function-for-c64
// Subroutine to wait for 0 to 4.25 seconds
// called using JSR with
// time to wait in A in 1/60 seconds 

jiffwait:
  clc
  adc jifflow     // Add time to wait to 'now'

jiffwtlp:
  ldx jifflow
  cmp jifflow     // Are we there yet
  bne jiffwtlp    // No -> Continue waiting
  rts             // Done waiting