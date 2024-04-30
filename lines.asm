.const charmem = $fb

*=$1000

main:
  lda #$00
  sta charmem
  lda #$04
  sta charmem + 1

  ldy #0
  

loop:
  lda #224
  sta (charmem), y

  lda charmem + 1
  clc
  adc #$d4
  sta charmem + 1

  lda #7
  sta (charmem), y

  lda charmem + 1
  sec
  sbc #$d4
  sta charmem + 1

  clc

  iny
  cpy #40

  bne loop

  rts

