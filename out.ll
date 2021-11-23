declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
@a = dso_local global [12 x i32] zeroinitializer
define dso_local i32 @main(){
    %u1 = alloca i32
    %u2 = alloca i32
    store i32  0, i32* %u2
    %u3 = alloca i32
    %u4 = alloca i32
    store i32  0, i32* %u4
    br label %x1

x1:
    %u5 = add i32  3,  4
    %u6 = sub i32  %u5,  2
    %u7 = load i32, i32* %u2
    %u8 = icmp sle  i32  %u7, %u6
    br i1 %u8, label %x2, label %x8

x2:
    %u9 = alloca i32
    %u10 = alloca i32
    %u11 = load i32, i32* %u2
    store i32  %u11, i32* %u10
    br label %x3

x3:
    %u12 = load i32, i32* %u10
    %u13 = icmp sge  i32  %u12,0
    br i1 %u13, label %x4, label %x7

x4:
    %u14 = load i32, i32* %u10
    %u15 = icmp slt  i32  %u14,4
    %u16 = load i32, i32* %u2
    %u17 = sub i32  %u16,  %u14
    %u18 = icmp slt  i32  %u17,3
    %u19 = and i1  %u15, %u18
    br i1 %u19,label %x5, label %x6

x5:
    %u20 = load i32, i32* %u10
    %u21 = load i32, i32* %u2
    %u22 = sub i32  %u21,  %u20
    %u23 = mul i32  %u22, 4
    %u24 = add i32  %u20, %u23
    %u25 = getelementptr [12 x i32],[12 x i32]*  @a, i32 0, i32 %u24
    %u26 = load i32, i32* %u25
    %u27 = load i32, i32* %u4
    store i32  %u27, i32* %u25
    %u28 = add i32  %u27,  1
    store i32  %u28, i32* %u4
    %u29 = load i32, i32* %u4
    br label %x6

x6:
    %u30 = load i32, i32* %u10
    %u31 = sub i32  %u30,  1
    store i32  %u31, i32* %u10
    %u32 = load i32, i32* %u10
    br label %x3

x7:
    %u33 = load i32, i32* %u2
    %u34 = add i32  %u33,  1
    store i32  %u34, i32* %u2
    %u35 = load i32, i32* %u2
    br label %x1

x8:
    store i32  0, i32* %u2
    %u36 = alloca i32
    %u37 = alloca i32
    store i32  0, i32* %u37
    br label %x9

x9:
    %u38 = load i32, i32* %u2
    %u39 = icmp slt  i32  %u38,3
    br i1 %u39, label %x10, label %x14

x10:
    store i32  0, i32* %u37
    br label %x11

x11:
    %u40 = load i32, i32* %u37
    %u41 = icmp slt  i32  %u40,4
    br i1 %u41, label %x12, label %x13

x12:
    %u42 = load i32, i32* %u2
    %u43 = load i32, i32* %u37
    %u44 = mul i32  %u42, 4
    %u45 = add i32  %u43, %u44
    %u46 = getelementptr [12 x i32],[12 x i32]*  @a, i32 0, i32 %u45
    %u47 = load i32, i32* %u46
    call void @putint(i32  %u47)
    call void @putch(i32  32)
    %u48 = add i32  %u43,  1
    store i32  %u48, i32* %u37
    %u49 = load i32, i32* %u37
    br label %x11

x13:
    call void @putch(i32  10)
    %u50 = load i32, i32* %u2
    %u51 = add i32  %u50,  1
    store i32  %u51, i32* %u2
    %u52 = load i32, i32* %u2
    br label %x9

x14:
    ret i32  0
}