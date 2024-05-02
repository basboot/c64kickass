.const charmem = $fb
.const charmemtop = $fd
.const jifflow = $a2

*=$1000

main:
  lda #0
  pha         // push start color on stack

repeat:
  lda #$e0    // store address of middle screen row, twice to start from
  sta charmem
  sta charmemtop
  lda #$05
  sta charmem + 1
  sta charmemtop + 1

  pla         // pop start color from stac
  clc
  adc #1      // increment accumulator (start color)
  pha         // push start color back to stack
  pha         // push current colot to stack
  
  ldx #0

outerloop:  
  ldy #0

loop:
  lda #224
  sta (charmem), y
  sta (charmemtop), y

  lda charmem + 1
  clc
  adc #$d4
  sta charmem + 1

  lda charmemtop + 1
  clc
  adc #$d4
  sta charmemtop + 1

  pla       // pop color from stack, and push back for future use
  pha
  sta (charmem), y
  sta (charmemtop), y

  lda charmem + 1
  sec
  sbc #$d4
  sta charmem + 1

  lda charmemtop + 1
  sec
  sbc #$d4
  sta charmemtop + 1

  iny
  cpy #40

  bne loop

  pla     // pop current color from stack
  clc
  adc #1  // decrease by one (easier than increase for scrolling color)
  pha     // push new color to stack

  clc
  lda charmem
  adc #40 // next line
  sta charmem
  lda charmem + 1
  adc #0 // carry
  sta charmem + 1

  sec
  lda charmemtop
  sbc #40 // prev line
  sta charmemtop
  lda charmemtop + 1
  sbc #0 // carry
  sta charmemtop + 1

  inx

  cpx #13

  bne outerloop

  pla     // remove current color from stack

delay:
  lda #8
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