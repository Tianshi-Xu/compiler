declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
define dso_local i32 @main(){
    %u1 = alloca i32
    store i32  5, i32* %u1
    %u2 = alloca i32
    store i32  10, i32* %u2
    %u3 = load i32, i32* %u1
    %u4 = icmp eq i32  %u3,5
    br i1 %u4,label %x1, label %x5

x1:
    %u5 = load i32, i32* %u2
    %u6 = icmp eq i32  %u5,10
    br i1 %u6,label %x2, label %x3

x2:
    store i32  25, i32* %u1
    br label %x4

x3:
    %u7 = load i32, i32* %u1
    %u8 = add i32  %u7,  15
    store i32  %u8, i32* %u1
    %u9 = load i32, i32* %u1
    br label %x4

x4:
    br label %x5

x5:
    %u10 = load i32, i32* %u1
    call void @putint(i32  %u10)
    ret i32  0
}