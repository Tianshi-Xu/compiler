declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
define dso_local i32 @func1(i32 %u1, i32 %u2, i32 %u3) {
    %u4 = alloca i32
    store i32 %u1, i32* %u4
    %u5 = alloca i32
    store i32 %u2, i32* %u5
    %u6 = alloca i32
    store i32 %u3, i32* %u6
    %u7 = load i32, i32* %u6
    %u8 = icmp eq i32  %u7,0
    br i1 %u8, label %x1, label %x2

x1:
    %u9 = load i32, i32* %u5
    %u10 = load i32, i32* %u4
    %u11 = mul i32  %u10,  %u9
    ret i32  %u11

x2:
    %u12 = load i32, i32* %u6
    %u13 = load i32, i32* %u5
    %u14 = sub i32  %u13,  %u12
    %u15 = load i32, i32* %u4
    %u16 = call i32 @func1(i32  %u15, i32  %u14, i32 0)
    ret i32  %u16
}
define dso_local i32 @func2(i32 %u17, i32 %u18) {
    %u19 = alloca i32
    store i32 %u17, i32* %u19
    %u20 = alloca i32
    store i32 %u18, i32* %u20
    %u26 = load i32, i32* %u20
    %u27 = icmp ne i32  %u26, 0
    br i1 %u27, label %x3, label %x4

x3:
    %u21 = load i32, i32* %u20
    %u22 = load i32, i32* %u19
    %u23 = srem i32  %u22,  %u21
    %u24 = call i32 @func2(i32  %u23, i32 0)
    ret i32  %u24

x4:
    %u25 = load i32, i32* %u19
    ret i32  %u25
}
define dso_local i32 @func3(i32 %u28, i32 %u29) {
    %u30 = alloca i32
    store i32 %u28, i32* %u30
    %u31 = alloca i32
    store i32 %u29, i32* %u31
    %u32 = load i32, i32* %u31
    %u33 = icmp eq i32  %u32,0
    br i1 %u33, label %x5, label %x6

x5:
    %u34 = load i32, i32* %u30
    %u35 = add i32  %u34,  1
    ret i32  %u35

x6:
    %u36 = load i32, i32* %u31
    %u37 = load i32, i32* %u30
    %u38 = add i32  %u37,  %u36
    %u39 = call i32 @func3(i32  %u38, i32 0)
    ret i32  %u39
}
define dso_local i32 @func4(i32 %u40, i32 %u41, i32 %u42) {
    %u43 = alloca i32
    store i32 %u40, i32* %u43
    %u44 = alloca i32
    store i32 %u41, i32* %u44
    %u45 = alloca i32
    store i32 %u42, i32* %u45
    %u48 = load i32, i32* %u43
    %u49 = icmp ne i32  %u48, 0
    br i1 %u49, label %x7, label %x8

x7:
    %u46 = load i32, i32* %u44
    ret i32  %u46

x8:
    %u47 = load i32, i32* %u45
    ret i32  %u47
}
define dso_local i32 @func5(i32 %u50) {
    %u51 = alloca i32
    store i32 %u50, i32* %u51
    %u52 = load i32, i32* %u51
    %u53 = sub i32 0,  %u52
    ret i32  %u53
}
define dso_local i32 @func6(i32 %u54, i32 %u55) {
    %u56 = alloca i32
    store i32 %u54, i32* %u56
    %u57 = alloca i32
    store i32 %u55, i32* %u57
    %u58 = load i32, i32* %u56
    %u59 = icmp ne i32  %u58, 0
    %u60 = load i32, i32* %u57
    %u61 = icmp ne i32  %u60, 0
    %u62 = and i1  %u59, %u61
    br i1 %u62, label %x9, label %x10

x9:
    ret i32  1

x10:
    ret i32  0
}
define dso_local i32 @func7(i32 %u63) {
    %u64 = alloca i32
    store i32 %u63, i32* %u64
    %u65 = load i32, i32* %u64
    %u66 = icmp eq i32  %u65, 0
    br i1 %u66, label %x11, label %x12

x11:
    ret i32  1

x12:
    ret i32  0
}
define dso_local i32 @main() {
    %u67 = alloca i32
    %u68 = alloca i32
    %u69 = call i32 @getint()
    store i32  %u69, i32* %u68
    %u70 = alloca i32
    %u71 = alloca i32
    %u72 = call i32 @getint()
    store i32  %u72, i32* %u71
    %u73 = alloca i32
    %u74 = alloca i32
    %u75 = call i32 @getint()
    store i32  %u75, i32* %u74
    %u76 = alloca i32
    %u77 = alloca i32
    %u78 = call i32 @getint()
    store i32  %u78, i32* %u77
    %u79 = alloca [10 x i32]
    %u80 = getelementptr [10 x i32],[10 x i32]* %u79, i32 0, i32 0
    call void @memset(i32* %u80 ,i32 0,i32 40)
    %u81 = alloca i32
    %u82 = alloca i32
    store i32  0, i32* %u82
    br label %x13

x13:
    %u83 = load i32, i32* %u82
    %u84 = icmp slt  i32  %u83,10
    br i1 %u84, label %x14, label %x15

x14:
    %u85 = load i32, i32* %u82
    %u86 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32  %u85
    %u87 = load i32, i32* %u86
    %u88 = call i32 @getint()
    store i32  %u88, i32* %u86
    %u89 = add i32  %u85,  1
    store i32  %u89, i32* %u82
    %u90 = load i32, i32* %u82
    br label %x13

x15:
    %u91 = alloca i32
    %u92 = alloca i32
    %u93 = load i32, i32* %u68
    %u94 = call i32 @func7(i32  %u93)
    %u95 = load i32, i32* %u71
    %u96 = call i32 @func5(i32  %u95)
    %u97 = call i32 @func6(i32  %u94, i32  %u96)
    %u98 = load i32, i32* %u74
    %u99 = call i32 @func2(i32  %u97, i32  %u98)
    %u100 = load i32, i32* %u77
    %u101 = call i32 @func3(i32  %u99, i32  %u100)
    %u102 = call i32 @func5(i32  %u101)
    %u103 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 0
    %u104 = load i32, i32* %u103
    %u105 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 1
    %u106 = load i32, i32* %u105
    %u107 = call i32 @func5(i32  %u106)
    %u108 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 2
    %u109 = load i32, i32* %u108
    %u110 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 3
    %u111 = load i32, i32* %u110
    %u112 = call i32 @func7(i32  %u111)
    %u113 = call i32 @func6(i32  %u109, i32  %u112)
    %u114 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 4
    %u115 = load i32, i32* %u114
    %u116 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 5
    %u117 = load i32, i32* %u116
    %u118 = call i32 @func7(i32  %u117)
    %u119 = call i32 @func2(i32  %u115, i32  %u118)
    %u120 = call i32 @func4(i32  %u107, i32  %u113, i32  %u119)
    %u121 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 6
    %u122 = load i32, i32* %u121
    %u123 = call i32 @func3(i32  %u120, i32  %u122)
    %u124 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 7
    %u125 = load i32, i32* %u124
    %u126 = call i32 @func2(i32  %u123, i32  %u125)
    %u127 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 8
    %u128 = load i32, i32* %u127
    %u129 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 9
    %u130 = load i32, i32* %u129
    %u131 = call i32 @func7(i32  %u130)
    %u132 = call i32 @func3(i32  %u128, i32  %u131)
    %u133 = call i32 @func1(i32  %u126, i32  %u132, i32  %u93)
    %u134 = call i32 @func4(i32  %u102, i32  %u104, i32  %u133)
    %u135 = call i32 @func7(i32  %u98)
    %u136 = call i32 @func3(i32  %u135, i32  %u100)
    %u137 = call i32 @func2(i32  %u95, i32  %u136)
    %u138 = call i32 @func3(i32  %u134, i32  %u137)
    %u139 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 0
    %u140 = load i32, i32* %u139
    %u141 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 1
    %u142 = load i32, i32* %u141
    %u143 = call i32 @func1(i32  %u138, i32  %u140, i32  %u142)
    %u144 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 2
    %u145 = load i32, i32* %u144
    %u146 = call i32 @func2(i32  %u143, i32  %u145)
    %u147 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 3
    %u148 = load i32, i32* %u147
    %u149 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 4
    %u150 = load i32, i32* %u149
    %u151 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 5
    %u152 = load i32, i32* %u151
    %u153 = call i32 @func5(i32  %u152)
    %u154 = call i32 @func3(i32  %u150, i32  %u153)
    %u155 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 6
    %u156 = load i32, i32* %u155
    %u157 = call i32 @func5(i32  %u156)
    %u158 = call i32 @func2(i32  %u154, i32  %u157)
    %u159 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 7
    %u160 = load i32, i32* %u159
    %u161 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 8
    %u162 = load i32, i32* %u161
    %u163 = call i32 @func7(i32  %u162)
    %u164 = call i32 @func1(i32  %u158, i32  %u160, i32  %u163)
    %u165 = getelementptr [10 x i32],[10 x i32]*  %u79, i32 0, i32 9
    %u166 = load i32, i32* %u165
    %u167 = call i32 @func5(i32  %u166)
    %u168 = call i32 @func2(i32  %u164, i32  %u167)
    %u169 = call i32 @func3(i32  %u168, i32  %u93)
    %u170 = call i32 @func1(i32  %u146, i32  %u148, i32  %u169)
    store i32  %u170, i32* %u92
    %u171 = load i32, i32* %u92
    call void @putint(i32  %u171)
    ret i32  0
}
