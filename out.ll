declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
define dso_local i32 @main(){
    %u1 = alloca i32
    store i32  10, i32* %u1
    %u2 = load i32, i32* %u1
    %u3 = icmp eq i32  %u2, 0
    %u4 = icmp eq i1  %u3, 0
    %u5 = icmp eq i1  %u4, 0
    %u6 = zext i1  %u5 to i32
    %u7 = sub i32 0, %u6
    %u8 = trunc i32  %u7 to i1
    br i1 %u8,label %x1, label %x2

x1:
    store i32  -1, i32* %u1
    br label %x3

x2:
    store i32  0, i32* %u1
    br label %x3

x3:
    %u9 = load i32, i32* %u1
    call void @putint(i32  %u9)
    ret i32  0
}