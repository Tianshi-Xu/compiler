declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
define dso_local void @move(i32 %u1, i32 %u2) {
    %u3 = alloca i32
    store i32 %u1, i32* %u3
    %u4 = alloca i32
    store i32 %u2, i32* %u4
    %u5 = load i32, i32* %u3
    call void @putint(i32  %u5)
    call void @putch(i32  32)
    %u6 = load i32, i32* %u4
    call void @putint(i32  %u6)
    call void @putch(i32  44)
    call void @putch(i32  32)
    ret void
}
define dso_local void @hanoi(i32 %u7, i32 %u8, i32 %u9, i32 %u10) {
    %u11 = alloca i32
    store i32 %u7, i32* %u11
    %u12 = alloca i32
    store i32 %u8, i32* %u12
    %u13 = alloca i32
    store i32 %u9, i32* %u13
    %u14 = alloca i32
    store i32 %u10, i32* %u14
    %u15 = load i32, i32* %u11
    %u16 = icmp eq i32  %u15,1
    br i1 %u16, label %x1, label %x2

x1:
    %u17 = load i32, i32* %u12
    %u18 = load i32, i32* %u14
    call void @move(i32  %u17, i32  %u18)
    br label %x3

x2:
    %u19 = load i32, i32* %u11
    %u20 = sub i32  %u19,  1
    %u21 = load i32, i32* %u12
    %u22 = load i32, i32* %u14
    %u23 = load i32, i32* %u13
    call void @hanoi(i32  %u20, i32  %u21, i32  %u22, i32  %u23)
    call void @move(i32  %u21, i32  %u22)
    %u24 = sub i32  %u19,  1
    call void @hanoi(i32  %u24, i32  %u23, i32  %u21, i32  %u22)
    br label %x3

x3:
    ret void
}
define dso_local i32 @main() {
    %u25 = alloca i32
    %u26 = alloca i32
    %u27 = call i32 @getint()
    store i32  %u27, i32* %u26
    br label %x4

x4:
    %u28 = load i32, i32* %u26
    %u29 = icmp sgt  i32  %u28,0
    br i1 %u29, label %x5, label %x6

x5:
    %u30 = call i32 @getint()
    call void @hanoi(i32  %u30, i32 1, i32 2, i32 3)
    call void @putch(i32  10)
    %u31 = load i32, i32* %u26
    %u32 = sub i32  %u31,  1
    store i32  %u32, i32* %u26
    %u33 = load i32, i32* %u26
    br label %x4

x6:
    ret i32  0
}
