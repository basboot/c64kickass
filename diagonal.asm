.const chrout = $ffd2
.const clear = $e544
.const plot = $fff0

*=$1000

main:
    jsr clear
    ldx #0
    ldy #0
    lda #18 // char for inverse
    jsr chrout
    lda #153 // char for light green
    jsr chrout

start:
    clc
    jsr plot
    lda #32 // space
    jsr chrout
    inx
    iny
    cpx #25
    bne start
    rts