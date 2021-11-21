declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
@a = dso_local global i32 1
@b = dso_local global i32 3
define dso_local i32 @main(){
    %u1 = call i32 @getint()
    store i32  %u1, i32* @a
    %u2 = load i32, i32* @a
    store i32  %u2, i32* @b
    %u3 = load i32, i32* @b
    store i32  %u3, i32* @a
    %u4 = load i32, i32* @a
    store i32  %u4, i32* @b
    %u5 = load i32, i32* @b
    store i32  %u4, i32* @b
    %u6 = load i32, i32* @b
    store i32  %u6, i32* @a
    %u7 = load i32, i32* @a
    store i32  %u7, i32* @b
    %u8 = load i32, i32* @b
    store i32  %u8, i32* @a
    %u9 = load i32, i32* @a
    store i32  %u8, i32* @a
    %u10 = load i32, i32* @a
    store i32  %u10, i32* @b
    %u11 = load i32, i32* @b
    %u12 = call i32 @getint()
    store i32  %u12, i32* @a
    %u13 = load i32, i32* @a
    call void @putint(i32  %u13)
    call void @putint(i32  %u11)
    ret i32  0
}