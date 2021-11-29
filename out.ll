declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
@a = dso_local global i32 -1
@b = dso_local global i32 1
define dso_local i32 @inc_a() {
    %u1 = alloca i32
    %u2 = alloca i32
    %u3 = load i32, i32* @a
    store i32  %u3, i32* %u2
    %u4 = load i32, i32* %u2
    %u5 = add i32  %u4,  1
    store i32  %u5, i32* %u2
    %u6 = load i32, i32* %u2
    store i32  %u6, i32* @a
    %u7 = load i32, i32* @a
    %u8 = load i32, i32* @a
    ret i32  %u8
}
define dso_local i32 @main() {
    %u9 = alloca i32
    %u10 = alloca i32
    store i32  5, i32* %u10
    br label %x1

x1:
    %u11 = load i32, i32* %u10
    %u12 = icmp sge  i32  %u11,0
    br i1 %u12, label %x2, label %x12

x2:
    %u13 = call i32 @inc_a()
    %u14 = icmp ne i32  %u13, 0
    br i1  %u14, label %x3, label %x6

x3:
    %u15 = call i32 @inc_a()
    %u16 = icmp ne i32  %u15, 0
    %u17 = icmp ne i32  %u15, 0
    br i1  %u17, label %x4, label %x6

x4:
    %u18 = call i32 @inc_a()
    %u19 = icmp ne i32  %u18, 0
    br i1 %u19, label %x5, label %x6

x5:
    %u20 = load i32, i32* @a
    call void @putint(i32  %u20)
    call void @putch(i32  32)
    %u21 = load i32, i32* @b
    call void @putint(i32  %u21)
    call void @putch(i32  10)
    br label %x6

x6:
    %u22 = call i32 @inc_a()
    %u23 = icmp slt  i32  %u22,14
    br i1  %u23, label %x9, label %x7

x7:
    %u24 = call i32 @inc_a()
    %u25 = icmp ne i32  %u24, 0
    br i1  %u25, label %x8, label %x9

x8:
    %u26 = call i32 @inc_a()
    %u27 = call i32 @inc_a()
    %u28 = sub i32  %u26,  %u27
    %u29 = add i32  %u28,  1
    %u30 = icmp ne i32  %u29, 0
    br i1 %u30, label %x9, label %x10

x9:
    %u31 = load i32, i32* @a
    call void @putint(i32  %u31)
    call void @putch(i32  10)
    %u32 = load i32, i32* @b
    %u33 = mul i32  %u32,  2
    store i32  %u33, i32* @b
    %u34 = load i32, i32* @b
    br label %x11

x10:
    %u35 = call i32 @inc_a()
    br label %x11

x11:
    %u36 = load i32, i32* %u10
    %u37 = sub i32  %u36,  1
    store i32  %u37, i32* %u10
    %u38 = load i32, i32* %u10
    br label %x1

x12:
    %u39 = load i32, i32* @a
    call void @putint(i32  %u39)
    call void @putch(i32  32)
    %u40 = load i32, i32* @b
    call void @putint(i32  %u40)
    call void @putch(i32  10)
    ret i32  0
}
