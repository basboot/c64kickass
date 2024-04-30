.const charmem = $fb
.const colormem = $fd

*=$1000

main:
  lda #$00
  sta charmem
  sta colormem
  lda #$04
  sta charmem + 1
  lda #$d8
  sta colormem + 1

  ldy #0
  

loop:
  lda #224
  sta (charmem), y
  lda #7
  sta (colormem), y

  iny
  cpy #40

  bne loop


  rts

