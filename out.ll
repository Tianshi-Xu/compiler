declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
@array = dso_local global [110 x i32] zeroinitializer
@n = dso_local global i32 0
define dso_local void @init(i32 %u1) {
    %u2 = alloca i32
    store i32 %u1, i32* %u2
    %u3 = alloca i32
    %u4 = alloca i32
    store i32  1, i32* %u4
    br label %x1

x1:
    %u5 = load i32, i32* %u2
    %u6 = mul i32  %u5,  %u5
    %u7 = add i32  %u6,  1
    %u8 = load i32, i32* %u4
    %u9 = icmp sle  i32  %u8, %u7
    br i1 %u9, label %x2, label %x3

x2:
    %u10 = load i32, i32* %u4
    %u11 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u10
    %u12 = load i32, i32* %u11
    store i32  -1, i32* %u11
    %u13 = add i32  %u10,  1
    store i32  %u13, i32* %u4
    %u14 = load i32, i32* %u4
    br label %x1

x3:
    ret void
}
define dso_local i32 @findfa(i32 %u15) {
    %u16 = alloca i32
    store i32 %u15, i32* %u16
    %u17 = load i32, i32* %u16
    %u18 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u17
    %u19 = load i32, i32* %u18
    %u20 = icmp eq i32  %u19, %u17
    br i1 %u20, label %x4, label %x5

x4:
    %u21 = load i32, i32* %u16
    ret i32  %u21

x5:
    %u22 = load i32, i32* %u16
    %u23 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u22
    %u24 = load i32, i32* %u23
    %u25 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u22
    %u26 = load i32, i32* %u25
    %u27 = call i32 @findfa(i32  %u26)
    store i32  %u27, i32* %u23
    %u28 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u22
    %u29 = load i32, i32* %u28
    ret i32  %u29
}
define dso_local void @mmerge(i32 %u30, i32 %u31) {
    %u32 = alloca i32
    store i32 %u30, i32* %u32
    %u33 = alloca i32
    store i32 %u31, i32* %u33
    %u34 = alloca i32
    %u35 = alloca i32
    %u36 = load i32, i32* %u32
    %u37 = call i32 @findfa(i32  %u36)
    store i32  %u37, i32* %u35
    %u38 = alloca i32
    %u39 = alloca i32
    %u40 = load i32, i32* %u33
    %u41 = call i32 @findfa(i32  %u40)
    store i32  %u41, i32* %u39
    %u42 = load i32, i32* %u35
    %u43 = load i32, i32* %u39
    %u44 = icmp ne i32  %u42, %u43
    br i1 %u44, label %x6, label %x7

x6:
    %u45 = load i32, i32* %u35
    %u46 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u45
    %u47 = load i32, i32* %u46
    %u48 = load i32, i32* %u39
    store i32  %u48, i32* %u46
    br label %x7

x7:
    ret void
}
define dso_local i32 @main() {
    %u49 = alloca i32
    %u50 = alloca i32
    %u51 = alloca i32
    %u52 = alloca i32
    store i32  1, i32* %u49
    br label %x8

x8:
    %u53 = load i32, i32* %u49
    %u166 = icmp ne i32  %u53, 0
    br i1 %u166, label %x9, label %x37

x9:
    %u54 = load i32, i32* %u49
    %u55 = sub i32  %u54,  1
    store i32  %u55, i32* %u49
    %u56 = load i32, i32* %u49
    store i32  4, i32* @n
    store i32  10, i32* %u50
    %u57 = alloca i32
    %u58 = alloca i32
    store i32  0, i32* %u58
    %u59 = alloca i32
    %u60 = alloca i32
    store i32  0, i32* %u60
    %u61 = load i32, i32* @n
    call void @init(i32  %u61)
    %u62 = alloca i32
    %u63 = alloca i32
    %u64 = load i32, i32* @n
    %u65 = load i32, i32* @n
    %u66 = mul i32  %u65,  %u64
    %u67 = add i32  %u66,  1
    store i32  %u67, i32* %u63
    br label %x10

x10:
    %u68 = load i32, i32* %u58
    %u69 = load i32, i32* %u50
    %u70 = icmp slt  i32  %u68, %u69
    br i1 %u70, label %x11, label %x34

x11:
    %u71 = call i32 @getint()
    store i32  %u71, i32* %u51
    %u72 = call i32 @getint()
    store i32  %u72, i32* %u52
    %u73 = load i32, i32* %u60
    %u74 = icmp eq i32  %u73, 0
    br i1 %u74, label %x12, label %x33

x12:
    %u75 = alloca i32
    %u76 = alloca i32
    %u77 = load i32, i32* %u51
    %u78 = sub i32  %u77,  1
    %u79 = load i32, i32* @n
    %u80 = mul i32  %u79,  %u78
    %u81 = load i32, i32* %u52
    %u82 = add i32  %u80,  %u81
    store i32  %u82, i32* %u76
    %u83 = load i32, i32* %u76
    %u84 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u83
    %u85 = load i32, i32* %u84
    store i32  %u83, i32* %u84
    %u86 = icmp eq i32  %u77,1
    br i1 %u86, label %x13, label %x14

x13:
    %u87 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32 0
    %u88 = load i32, i32* %u87
    store i32  0, i32* %u87
    %u89 = load i32, i32* %u76
    call void @mmerge(i32  %u89, i32 0)
    br label %x14

x14:
    %u90 = load i32, i32* %u51
    %u91 = load i32, i32* @n
    %u92 = icmp eq i32  %u90, %u91
    br i1 %u92, label %x15, label %x16

x15:
    %u93 = load i32, i32* %u63
    %u94 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u93
    %u95 = load i32, i32* %u94
    store i32  %u93, i32* %u94
    %u96 = load i32, i32* %u76
    call void @mmerge(i32  %u96, i32  %u93)
    br label %x16

x16:
    %u97 = load i32, i32* %u52
    %u98 = load i32, i32* @n
    %u99 = icmp slt  i32  %u97, %u98
    br i1  %u99, label %x17, label %x19

x17:
    %u100 = load i32, i32* %u76
    %u101 = add i32  %u100,  1
    %u102 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u101
    %u103 = load i32, i32* %u102
    %u104 = icmp ne i32  %u103,-1
    br i1 %u104, label %x18, label %x19

x18:
    %u106 = load i32, i32* %u76
    %u107 = add i32  %u106,  1
    call void @mmerge(i32  %u106, i32  %u107)
    br label %x19

x19:
    %u108 = load i32, i32* %u52
    %u109 = icmp sgt  i32  %u108,1
    br i1  %u109, label %x20, label %x22

x20:
    %u110 = load i32, i32* %u76
    %u111 = sub i32  %u110,  1
    %u112 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u111
    %u113 = load i32, i32* %u112
    %u114 = icmp ne i32  %u113,-1
    br i1 %u114, label %x21, label %x22

x21:
    %u116 = load i32, i32* %u76
    %u117 = sub i32  %u116,  1
    call void @mmerge(i32  %u116, i32  %u117)
    br label %x22

x22:
    %u118 = load i32, i32* %u51
    %u119 = load i32, i32* @n
    %u120 = icmp slt  i32  %u118, %u119
    br i1  %u120, label %x23, label %x25

x23:
    %u121 = load i32, i32* @n
    %u122 = load i32, i32* %u76
    %u123 = add i32  %u122,  %u121
    %u124 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u123
    %u125 = load i32, i32* %u124
    %u126 = icmp ne i32  %u125,-1
    br i1 %u126, label %x24, label %x25

x24:
    %u128 = load i32, i32* @n
    %u129 = load i32, i32* %u76
    %u130 = add i32  %u129,  %u128
    call void @mmerge(i32  %u129, i32  %u130)
    br label %x25

x25:
    %u131 = load i32, i32* %u51
    %u132 = icmp sgt  i32  %u131,1
    br i1  %u132, label %x26, label %x28

x26:
    %u133 = load i32, i32* @n
    %u134 = load i32, i32* %u76
    %u135 = sub i32  %u134,  %u133
    %u136 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u135
    %u137 = load i32, i32* %u136
    %u138 = icmp ne i32  %u137,-1
    br i1 %u138, label %x27, label %x28

x27:
    %u140 = load i32, i32* @n
    %u141 = load i32, i32* %u76
    %u142 = sub i32  %u141,  %u140
    call void @mmerge(i32  %u141, i32  %u142)
    br label %x28

x28:
    %u143 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32 0
    %u144 = load i32, i32* %u143
    %u145 = icmp ne i32  %u144,-1
    br i1  %u145, label %x29, label %x32

x29:
    %u146 = load i32, i32* %u63
    %u147 = getelementptr [110 x i32],[110 x i32]*  @array, i32 0, i32  %u146
    %u148 = load i32, i32* %u147
    %u149 = icmp ne i32  %u148,-1
    br i1  %u149, label %x30, label %x32

x30:
    %u151 = call i32 @findfa(i32 0)
    %u152 = load i32, i32* %u63
    %u153 = call i32 @findfa(i32  %u152)
    %u154 = icmp eq i32  %u151, %u153
    br i1 %u154, label %x31, label %x32

x31:
    store i32  1, i32* %u60
    %u156 = alloca i32
    %u157 = alloca i32
    %u158 = load i32, i32* %u58
    %u159 = add i32  %u158,  1
    store i32  %u159, i32* %u157
    %u160 = load i32, i32* %u157
    call void @putint(i32  %u160)
    call void @putch(i32  10)
    br label %x32

x32:
    br label %x33

x33:
    %u161 = load i32, i32* %u58
    %u162 = add i32  %u161,  1
    store i32  %u162, i32* %u58
    %u163 = load i32, i32* %u58
    br label %x10

x34:
    %u164 = load i32, i32* %u60
    %u165 = icmp eq i32  %u164, 0
    br i1 %u165, label %x35, label %x36

x35:
    call void @putint(i32  -1)
    call void @putch(i32  10)
    br label %x36

x36:
    br label %x8

x37:
    ret i32  0
}
