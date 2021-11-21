declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
    %u1 = alloca i32
    store i32  1, i32* %u1
    %u2 = alloca i32
    store i32  3, i32* %u2
define dso_local i32 @main(){
    %u3 = call i32 @getint()
    store i32  %u3, i32* %u1
    %u4 = load i32, i32* %u1
    store i32  %u4, i32* %u2
    %u5 = load i32, i32* %u2
    store i32  %u5, i32* %u1
    %u6 = load i32, i32* %u1
    store i32  %u6, i32* %u2
    %u7 = load i32, i32* %u2
    store i32  %u6, i32* %u2
    %u8 = load i32, i32* %u2
    store i32  %u8, i32* %u1
    %u9 = load i32, i32* %u1
    store i32  %u9, i32* %u2
    %u10 = load i32, i32* %u2
    store i32  %u10, i32* %u1
    %u11 = load i32, i32* %u1
    store i32  %u10, i32* %u1
    %u12 = load i32, i32* %u1
    store i32  %u12, i32* %u2
    %u13 = load i32, i32* %u2
    %u14 = call i32 @getint()
    store i32  %u14, i32* %u1
    %u15 = load i32, i32* %u1
    call void @putint(i32  %u15)
    call void @putint(i32  %u13)
    ret i32  0
}