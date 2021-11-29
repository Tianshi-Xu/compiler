declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
define dso_local i32 @f() {
    call void @putint(i32  0)
    ret i32  0
}
define dso_local i32 @g() {
    call void @putint(i32  1)
    ret i32  1
}
define dso_local i32 @main() {
    %u1 = call i32 @f()
    %u2 = icmp ne i32  %u1, 0
    br i1  %u2, label %x1, label %x5

x1:
    %u3 = call i32 @g()
    %u4 = icmp ne i32  %u3, 0
    br i1  %u4, label %x4, label %x42

x2:
    %u5 = call i32 @f()
    %u6 = icmp eq i32  %u5, 0
    br i1  %u6, label %x3, label %x5

x3:
    %u7 = call i32 @g()
    %u8 = icmp ne i32  %u7, 0
    br i1 %u8, label %x4, label %x5

x4:
    ret i32  0

x5:
    ret i32  1
}
