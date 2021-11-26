declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
define dso_local i32 @sum2d(i32* %u1) {
    %u2 = alloca i32
    %u3 = alloca i32
    store i32  0, i32* %u3
    %u4 = alloca i32
    %u5 = alloca i32
    store i32  0, i32* %u5
    br label %x1

x1:
    %u6 = load i32, i32* %u3
    %u7 = icmp slt  i32  %u6,2
    br i1 %u7, label %x2, label %x6

x2:
    %u8 = alloca i32
    %u9 = alloca i32
    store i32  0, i32* %u9
    br label %x3

x3:
    %u10 = load i32, i32* %u9
    %u11 = icmp slt  i32  %u10,3
    br i1 %u11, label %x4, label %x5

x4:
    %u12 = load i32, i32* %u3
    %u13 = load i32, i32* %u9
    %u14 = mul i32  %u12, 3
    %u15 = add i32  %u13, %u14
    %u16 = getelementptr i32, i32*  %u1, i32 %u15
    %u17 = load i32, i32* %u16
    %u18 = load i32, i32* %u5
    %u19 = add i32  %u18,  %u17
    store i32  %u19, i32* %u5
    %u20 = load i32, i32* %u5
    %u21 = add i32  %u13,  1
    store i32  %u21, i32* %u9
    %u22 = load i32, i32* %u9
    br label %x3

x5:
    %u23 = load i32, i32* %u3
    %u24 = add i32  %u23,  1
    store i32  %u24, i32* %u3
    %u25 = load i32, i32* %u3
    br label %x1

x6:
    %u26 = load i32, i32* %u5
    ret i32  %u26
}
define dso_local i32 @main() {
    %u27 = alloca [6 x i32]
    %u28 = getelementptr [6 x i32],[6 x i32]* %u27, i32 0, i32 0
    call void @memset(i32* %u28 ,i32 0,i32 24)
    %u29 = getelementptr [6 x i32],[6 x i32]* %u27, i32 0, i32 0
    store i32 1, i32* %u29
    %u30 = getelementptr [6 x i32],[6 x i32]* %u27, i32 0, i32 1
    store i32 2, i32* %u30
    %u31 = getelementptr [6 x i32],[6 x i32]* %u27, i32 0, i32 2
    store i32 3, i32* %u31
    %u32 = getelementptr [6 x i32],[6 x i32]* %u27, i32 0, i32 3
    store i32 4, i32* %u32
    %u33 = getelementptr [6 x i32],[6 x i32]* %u27, i32 0, i32 4
    store i32 5, i32* %u33
    %u34 = getelementptr [6 x i32],[6 x i32]*  %u27, i32 0, i32 0
    %u35 = call i32 @sum2d(i32*  %u34)
    call void @putint(i32  %u35)
    ret i32  0
}
