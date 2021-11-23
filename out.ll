declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
@n = dso_local global i32 0
define dso_local i32 @main(){
    store i32  10, i32* @n
    %u1 = alloca [10 x i32]
    %u2 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 0
    %u3 = load i32, i32* %u2
    store i32  4, i32* %u2
    %u4 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 1
    %u5 = load i32, i32* %u4
    store i32  3, i32* %u4
    %u6 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 2
    %u7 = load i32, i32* %u6
    store i32  9, i32* %u6
    %u8 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 3
    %u9 = load i32, i32* %u8
    store i32  2, i32* %u8
    %u10 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 4
    %u11 = load i32, i32* %u10
    store i32  0, i32* %u10
    %u12 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 5
    %u13 = load i32, i32* %u12
    store i32  1, i32* %u12
    %u14 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 6
    %u15 = load i32, i32* %u14
    store i32  6, i32* %u14
    %u16 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 7
    %u17 = load i32, i32* %u16
    store i32  5, i32* %u16
    %u18 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 8
    %u19 = load i32, i32* %u18
    store i32  7, i32* %u18
    %u20 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32 9
    %u21 = load i32, i32* %u20
    store i32  8, i32* %u20
    %u22 = alloca i32
    store i32  1, i32* %u22
    br label %x1

x1:
    %u23 = load i32, i32* %u22
    %u24 = load i32, i32* @n
    %u25 = icmp slt  i32  %u23, %u24
    br i1 %u25, label %x2, label %x6

x2:
    %u26 = alloca i32
    %u27 = load i32, i32* %u22
    %u28 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32  %u27
    %u29 = load i32, i32* %u28
    store i32  %u29, i32* %u26
    %u30 = alloca i32
    %u31 = sub i32  %u27,  1
    store i32  %u31, i32* %u30
    br label %x3

x3:
    %u32 = load i32, i32* %u30
    %u33 = icmp sgt  i32  %u32,-1
    %u34 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32  %u32
    %u35 = load i32, i32* %u34
    %u36 = load i32, i32* %u26
    %u37 = icmp slt  i32  %u36, %u35
    %u38 = and i1  %u33, %u37
    br i1 %u38, label %x4, label %x5

x4:
    %u39 = load i32, i32* %u30
    %u40 = add i32  %u39,  1
    %u41 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32  %u40
    %u42 = load i32, i32* %u41
    %u43 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32  %u39
    %u44 = load i32, i32* %u43
    store i32  %u44, i32* %u41
    %u45 = sub i32  %u39,  1
    store i32  %u45, i32* %u30
    %u46 = load i32, i32* %u30
    br label %x3

x5:
    %u47 = load i32, i32* %u30
    %u48 = add i32  %u47,  1
    %u49 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32  %u48
    %u50 = load i32, i32* %u49
    %u51 = load i32, i32* %u26
    store i32  %u51, i32* %u49
    %u52 = load i32, i32* %u22
    %u53 = add i32  %u52,  1
    store i32  %u53, i32* %u22
    %u54 = load i32, i32* %u22
    br label %x1

x6:
    store i32  0, i32* %u22
    br label %x7

x7:
    %u55 = load i32, i32* %u22
    %u56 = load i32, i32* @n
    %u57 = icmp slt  i32  %u55, %u56
    br i1 %u57, label %x8, label %x9

x8:
    %u58 = alloca i32
    %u59 = load i32, i32* %u22
    %u60 = getelementptr [10 x i32],[10 x i32]*  %u1, i32 0, i32  %u59
    %u61 = load i32, i32* %u60
    store i32  %u61, i32* %u58
    %u62 = load i32, i32* %u58
    call void @putint(i32  %u62)
    store i32  10, i32* %u58
    %u63 = load i32, i32* %u58
    call void @putch(i32  %u63)
    %u64 = add i32  %u59,  1
    store i32  %u64, i32* %u22
    %u65 = load i32, i32* %u22
    br label %x7

x9:
    ret i32  0
}