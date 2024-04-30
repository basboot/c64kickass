.const charmem = $fb
.const color = $fd

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
  ldy #0

outerloop:  

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

  jmp repeat // endless repeat

  rts

