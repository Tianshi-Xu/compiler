declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
define dso_local i32 @main(){
    %u1 = alloca i32
    store i32  3389, i32* %u1
    %u2 = load i32, i32* %u1
    %u3 = icmp slt  i32  %u2,10000
    br i1 %u3,label %x1, label %x6

x1:
    %u4 = load i32, i32* %u1
    %u5 = add i32  %u4,  1
    store i32  %u5, i32* %u1
    %u6 = load i32, i32* %u1
    %u7 = alloca i32
    store i32  112, i32* %u7
    %u8 = load i32, i32* %u7
    %u9 = icmp sgt  i32  %u8,10
    br i1 %u9,label %x2, label %x5

x2:
    %u10 = load i32, i32* %u7
    %u11 = sub i32  %u10,  88
    store i32  %u11, i32* %u7
    %u12 = load i32, i32* %u7
    %u13 = icmp slt  i32  %u12,1000
    br i1 %u13,label %x3, label %x4

x3:
    %u14 = alloca i32
    store i32  9, i32* %u14
    %u15 = alloca i32
    store i32  11, i32* %u15
    store i32  10, i32* %u14
    %u16 = load i32, i32* %u14
    %u17 = load i32, i32* %u7
    %u18 = sub i32  %u17,  %u16
    store i32  %u18, i32* %u7
    %u19 = load i32, i32* %u7
    %u20 = alloca i32
    store i32  11, i32* %u20
    %u21 = load i32, i32* %u20
    %u22 = add i32  %u19,  %u21
    %u23 = load i32, i32* %u15
    %u24 = add i32  %u22,  %u23
    store i32  %u24, i32* %u7
    %u25 = load i32, i32* %u7
    br label %x4

x4:
    br label %x5

x5:
    %u26 = load i32, i32* %u7
    call void @putint(i32  %u26)
    br label %x6

x6:
    ret i32  0
}