_start:
    nop
_init:
    nop
main:
    
    li  x1,0x80000
    lui  x2,0x80001 
    addi x3, x0, 44
    addi x4, x0, 321
    addi x5, x0, 600
    addi x6, x0, 43
    addi x7, x0, 13
    addi x8, x0, 20
    addi x9, x0, 29
    addi x10, x0, 100
    addi x11, x0, 31
    addi x12, x0, 32
    addi x13, x0, 97
    addi x14, x0, 155
    addi x15, x0, 191
    addi x16, x0, 174
    addi x17, x0, -100
    addi x18, x0, -123
    addi x19, x0, 3
    addi x20, x0, -411
    addi x21, x0, 99
    addi x22, x0, 98
    addi x23, x0, 81
    addi x24, x0, 88
    addi x25, x0, 55
    addi x26, x0, -44
    addi x27, x0, 615
    addi x28, x0, 1
    addi x29, x0, 2
    addi x30, x0, 3
    addi x31, x0, -1

    
    add x20, x13, x10
    sub x5, x20, x10
    and x7, x20, x8
    or x10, x20, x21
    slli x30, x20, 5
    sra x31, x18, x16

    addi x23, x0, 1
    addi x24, x0, 1
    beq x23, x24, label_beq
    addi x23, x0, 5
    addi x24, x0, 6

    label_beq:
    slt x25, x23, x24
    bne x23, x24, label_beq

    label_store_load_1:
    addi x15, x0, 5
    addi x16, x0, 388
    addi x14, x0, 10
    add x16, x16, x2
    sw x15, 0(x16)
    lw x17, 0(x16)
    add x18, x17, x14

    label_store_load_2:
    addi x25, x0, 523
    addi x26, x0, 1550
    and x27,x25,x26
    add x27,x27,x2
    andi x27, x27, ~0x3
    sw x25, 0(x27)
    lb x28, 0(x27)
    lh x29, 0(x27)
    lw x30, 0(x27)
    lbu x11, 0(x27)
    lhu x12, 0(x27)
    blt x25,x26, label_store_load_3
    addi x4, x0, 0
    addi x5, x0,0

    label_store_load_3:
    addi x7, x0, 1333
    addi x8, x0, 1222
    xor x9, x7,x8
    add x9, x9, x2
    andi x9, x9, ~0x1
    sh x7, 0(x9)
    lb x8, 0(x9)

    label_raw:
    addi x22, x0, 55
    nop
    nop
    addi x23, x22, 5

    label_load_use:
    addi x15, x0, 155
    addi x3, x2, 0xc
    andi x3, x3, ~0x3
    sw x15, 0(x3)
    lw x16, 0(x3)
    add x17, x16, x15

    label_zbb:
    addi x13, x0, 144
    clz x14, x13
    cpop x15, x13
    ctz x16, x13


    j exit

.align 12
exit:
    j exit
