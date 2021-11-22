declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
define dso_local i32 @main(){
    %u1 = alloca i32
    store i32  1, i32* %u1
    br label %x1

x1:
    %u2 = load i32, i32* %u1
    %u3 = icmp slt  i32  %u2,12
    br i1 %u3, label %x2, label %x11

x2:
    %u4 = alloca i32
    store i32  0, i32* %u4
    br label %x3

x3:
    %u5 = icmp eq i32 1,1
    br i1 %u5, label %x4, label %x10

x4:
    %u6 = load i32, i32* %u4
    %u7 = srem i32  %u6,  3
    %u8 = icmp eq i32  %u7,1
    br i1 %u8,label %x5, label %x6

x5:
    %u9 = add i32  48,  1
    call void @putch(i32  %u9)
    br label %x7

x6:
    call void @putch(i32  48)
    br label %x7

x7:
    %u10 = load i32, i32* %u4
    %u11 = add i32  %u10,  1
    store i32  %u11, i32* %u4
    %u12 = load i32, i32* %u4
    %u13 = load i32, i32* %u1
    %u14 = mul i32  2,  %u13
    %u15 = sub i32  %u14,  1
    %u16 = icmp sge  i32  %u12, %u15
    br i1 %u16,label %x8, label %x9

x8:
    br label %x10
    br label %x9

x9:
    br label %x3

x10:
    call void @putch(i32  10)
    %u17 = load i32, i32* %u1
    %u18 = add i32  %u17,  1
    store i32  %u18, i32* %u1
    %u19 = load i32, i32* %u1
    br label %x1
    br label %x1

x11:
    ret i32  0
}