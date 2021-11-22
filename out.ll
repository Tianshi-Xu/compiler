declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
define dso_local i32 @main(){
    br label %x1

x1:
    %u2 = trunc i32 1 to i1
    br i1 %u2,label %x2, label %x5

x2:
    %u1 = icmp eq i32 1,2
    br i1 %u1,label %x3, label %x4

x3:
    br label %x5
    br label %x4

x4:
    br label %x1

x5:
    ret i32  0
}