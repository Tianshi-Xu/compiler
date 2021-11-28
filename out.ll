declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
@maxn = dso_local constant i32 4
@mod = dso_local constant i32 1000000007
@dp = dso_local global [7168 x i32] zeroinitializer
@list = dso_local global [200 x i32] zeroinitializer
define dso_local i32 @equal(i32 %u1, i32 %u2) {
    %u3 = alloca i32
    store i32 %u1, i32* %u3
    %u4 = alloca i32
    store i32 %u2, i32* %u4
    %u5 = load i32, i32* %u3
    %u6 = load i32, i32* %u4
    %u7 = icmp eq i32  %u5, %u6
    br i1 %u7, label %x1, label %x2

x1:
    ret i32  1

x2:
    ret i32  0
}
define dso_local i32 @dfs(i32 %u8, i32 %u9, i32 %u10, i32 %u11, i32 %u12, i32 %u13) {
    %u14 = alloca i32
    store i32 %u8, i32* %u14
    %u15 = alloca i32
    store i32 %u9, i32* %u15
    %u16 = alloca i32
    store i32 %u10, i32* %u16
    %u17 = alloca i32
    store i32 %u11, i32* %u17
    %u18 = alloca i32
    store i32 %u12, i32* %u18
    %u19 = alloca i32
    store i32 %u13, i32* %u19
    %u20 = load i32, i32* %u14
    %u21 = load i32, i32* %u15
    %u22 = load i32, i32* %u16
    %u23 = load i32, i32* %u17
    %u24 = load i32, i32* %u18
    %u25 = load i32, i32* %u19
    %u26 = mul i32  %u24, 7
    %u27 = add i32  %u25, %u26
    %u28 = mul i32  %u23, 28
    %u29 = add i32 %u27, %u28
    %u30 = mul i32  %u22, 112
    %u31 = add i32 %u29, %u30
    %u32 = mul i32  %u21, 448
    %u33 = add i32 %u31, %u32
    %u34 = mul i32  %u20, 1792
    %u35 = add i32 %u33, %u34
    %u36 = getelementptr [7168 x i32],[7168 x i32]*  @dp, i32 0, i32 %u35
    %u37 = load i32, i32* %u36
    %u38 = icmp ne i32  %u37,-1
    br i1 %u38, label %x3, label %x4

x3:
    %u39 = load i32, i32* %u14
    %u40 = load i32, i32* %u15
    %u41 = load i32, i32* %u16
    %u42 = load i32, i32* %u17
    %u43 = load i32, i32* %u18
    %u44 = load i32, i32* %u19
    %u45 = mul i32  %u43, 7
    %u46 = add i32  %u44, %u45
    %u47 = mul i32  %u42, 28
    %u48 = add i32 %u46, %u47
    %u49 = mul i32  %u41, 112
    %u50 = add i32 %u48, %u49
    %u51 = mul i32  %u40, 448
    %u52 = add i32 %u50, %u51
    %u53 = mul i32  %u39, 1792
    %u54 = add i32 %u52, %u53
    %u55 = getelementptr [7168 x i32],[7168 x i32]*  @dp, i32 0, i32 %u54
    %u56 = load i32, i32* %u55
    ret i32  %u56

x4:
    %u57 = load i32, i32* %u15
    %u58 = load i32, i32* %u14
    %u59 = add i32  %u58,  %u57
    %u60 = load i32, i32* %u16
    %u61 = add i32  %u59,  %u60
    %u62 = load i32, i32* %u17
    %u63 = add i32  %u61,  %u62
    %u64 = load i32, i32* %u18
    %u65 = add i32  %u63,  %u64
    %u66 = icmp eq i32  %u65,0
    br i1 %u66, label %x5, label %x6

x5:
    ret i32  1

x6:
    %u67 = alloca i32
    %u68 = alloca i32
    store i32  0, i32* %u68
    %u84 = load i32, i32* %u14
    %u85 = icmp ne i32  %u84, 0
    br i1 %u85, label %x7, label %x8

x7:
    %u69 = load i32, i32* %u19
    %u70 = call i32 @equal(i32  %u69, i32 2)
    %u71 = load i32, i32* %u14
    %u72 = sub i32  %u71,  %u70
    %u73 = sub i32  %u71,  1
    %u74 = load i32, i32* %u15
    %u75 = load i32, i32* %u16
    %u76 = load i32, i32* %u17
    %u77 = load i32, i32* %u18
    %u78 = call i32 @dfs(i32  %u73, i32  %u74, i32  %u75, i32  %u76, i32  %u77, i32 1)
    %u79 = mul i32  %u72,  %u78
    %u80 = load i32, i32* %u68
    %u81 = add i32  %u80,  %u79
    %u82 = srem i32  %u81,  1000000007
    store i32  %u82, i32* %u68
    %u83 = load i32, i32* %u68
    br label %x8

x8:
    %u102 = load i32, i32* %u15
    %u103 = icmp ne i32  %u102, 0
    br i1 %u103, label %x9, label %x10

x9:
    %u86 = load i32, i32* %u19
    %u87 = call i32 @equal(i32  %u86, i32 3)
    %u88 = load i32, i32* %u15
    %u89 = sub i32  %u88,  %u87
    %u90 = load i32, i32* %u14
    %u91 = add i32  %u90,  1
    %u92 = sub i32  %u88,  1
    %u93 = load i32, i32* %u16
    %u94 = load i32, i32* %u17
    %u95 = load i32, i32* %u18
    %u96 = call i32 @dfs(i32  %u91, i32  %u92, i32  %u93, i32  %u94, i32  %u95, i32 2)
    %u97 = mul i32  %u89,  %u96
    %u98 = load i32, i32* %u68
    %u99 = add i32  %u98,  %u97
    %u100 = srem i32  %u99,  1000000007
    store i32  %u100, i32* %u68
    %u101 = load i32, i32* %u68
    br label %x10

x10:
    %u120 = load i32, i32* %u16
    %u121 = icmp ne i32  %u120, 0
    br i1 %u121, label %x11, label %x12

x11:
    %u104 = load i32, i32* %u19
    %u105 = call i32 @equal(i32  %u104, i32 4)
    %u106 = load i32, i32* %u16
    %u107 = sub i32  %u106,  %u105
    %u108 = load i32, i32* %u15
    %u109 = add i32  %u108,  1
    %u110 = sub i32  %u106,  1
    %u111 = load i32, i32* %u14
    %u112 = load i32, i32* %u17
    %u113 = load i32, i32* %u18
    %u114 = call i32 @dfs(i32  %u111, i32  %u109, i32  %u110, i32  %u112, i32  %u113, i32 3)
    %u115 = mul i32  %u107,  %u114
    %u116 = load i32, i32* %u68
    %u117 = add i32  %u116,  %u115
    %u118 = srem i32  %u117,  1000000007
    store i32  %u118, i32* %u68
    %u119 = load i32, i32* %u68
    br label %x12

x12:
    %u138 = load i32, i32* %u17
    %u139 = icmp ne i32  %u138, 0
    br i1 %u139, label %x13, label %x14

x13:
    %u122 = load i32, i32* %u19
    %u123 = call i32 @equal(i32  %u122, i32 5)
    %u124 = load i32, i32* %u17
    %u125 = sub i32  %u124,  %u123
    %u126 = load i32, i32* %u16
    %u127 = add i32  %u126,  1
    %u128 = sub i32  %u124,  1
    %u129 = load i32, i32* %u14
    %u130 = load i32, i32* %u15
    %u131 = load i32, i32* %u18
    %u132 = call i32 @dfs(i32  %u129, i32  %u130, i32  %u127, i32  %u128, i32  %u131, i32 4)
    %u133 = mul i32  %u125,  %u132
    %u134 = load i32, i32* %u68
    %u135 = add i32  %u134,  %u133
    %u136 = srem i32  %u135,  1000000007
    store i32  %u136, i32* %u68
    %u137 = load i32, i32* %u68
    br label %x14

x14:
    %u153 = load i32, i32* %u18
    %u154 = icmp ne i32  %u153, 0
    br i1 %u154, label %x15, label %x16

x15:
    %u140 = load i32, i32* %u17
    %u141 = add i32  %u140,  1
    %u142 = load i32, i32* %u18
    %u143 = sub i32  %u142,  1
    %u144 = load i32, i32* %u14
    %u145 = load i32, i32* %u15
    %u146 = load i32, i32* %u16
    %u147 = call i32 @dfs(i32  %u144, i32  %u145, i32  %u146, i32  %u141, i32  %u143, i32 5)
    %u148 = mul i32  %u142,  %u147
    %u149 = load i32, i32* %u68
    %u150 = add i32  %u149,  %u148
    %u151 = srem i32  %u150,  1000000007
    store i32  %u151, i32* %u68
    %u152 = load i32, i32* %u68
    br label %x16

x16:
    %u155 = load i32, i32* %u14
    %u156 = load i32, i32* %u15
    %u157 = load i32, i32* %u16
    %u158 = load i32, i32* %u17
    %u159 = load i32, i32* %u18
    %u160 = load i32, i32* %u19
    %u161 = mul i32  %u159, 7
    %u162 = add i32  %u160, %u161
    %u163 = mul i32  %u158, 28
    %u164 = add i32 %u162, %u163
    %u165 = mul i32  %u157, 112
    %u166 = add i32 %u164, %u165
    %u167 = mul i32  %u156, 448
    %u168 = add i32 %u166, %u167
    %u169 = mul i32  %u155, 1792
    %u170 = add i32 %u168, %u169
    %u171 = getelementptr [7168 x i32],[7168 x i32]*  @dp, i32 0, i32 %u170
    %u172 = load i32, i32* %u171
    %u173 = load i32, i32* %u68
    %u174 = srem i32  %u173,  1000000007
    store i32  %u174, i32* %u171
    %u175 = mul i32  %u159, 7
    %u176 = add i32  %u160, %u175
    %u177 = mul i32  %u158, 28
    %u178 = add i32 %u176, %u177
    %u179 = mul i32  %u157, 112
    %u180 = add i32 %u178, %u179
    %u181 = mul i32  %u156, 448
    %u182 = add i32 %u180, %u181
    %u183 = mul i32  %u155, 1792
    %u184 = add i32 %u182, %u183
    %u185 = getelementptr [7168 x i32],[7168 x i32]*  @dp, i32 0, i32 %u184
    %u186 = load i32, i32* %u185
    ret i32  %u186
}
@cns = dso_local global [20 x i32] zeroinitializer
define dso_local i32 @main() {
    %u187 = alloca i32
    %u188 = alloca i32
    %u189 = call i32 @getint()
    store i32  %u189, i32* %u188
    %u190 = alloca i32
    %u191 = alloca i32
    store i32  0, i32* %u191
    br label %x17

x17:
    %u192 = load i32, i32* %u191
    %u193 = icmp slt  i32  %u192,4
    br i1 %u193, label %x18, label %x34

x18:
    %u194 = alloca i32
    %u195 = alloca i32
    store i32  0, i32* %u195
    br label %x19

x19:
    %u196 = load i32, i32* %u195
    %u197 = icmp slt  i32  %u196,4
    br i1 %u197, label %x20, label %x33

x20:
    %u198 = alloca i32
    %u199 = alloca i32
    store i32  0, i32* %u199
    br label %x21

x21:
    %u200 = load i32, i32* %u199
    %u201 = icmp slt  i32  %u200,4
    br i1 %u201, label %x22, label %x32

x22:
    %u202 = alloca i32
    %u203 = alloca i32
    store i32  0, i32* %u203
    br label %x23

x23:
    %u204 = load i32, i32* %u203
    %u205 = icmp slt  i32  %u204,4
    br i1 %u205, label %x24, label %x31

x24:
    %u206 = alloca i32
    %u207 = alloca i32
    store i32  0, i32* %u207
    br label %x25

x25:
    %u208 = load i32, i32* %u207
    %u209 = icmp slt  i32  %u208,4
    br i1 %u209, label %x26, label %x30

x26:
    %u210 = alloca i32
    %u211 = alloca i32
    store i32  0, i32* %u211
    br label %x27

x27:
    %u212 = load i32, i32* %u211
    %u213 = icmp slt  i32  %u212,7
    br i1 %u213, label %x28, label %x29

x28:
    call void @putint(i32  8)
    %u214 = load i32, i32* %u191
    %u215 = load i32, i32* %u195
    %u216 = load i32, i32* %u199
    %u217 = load i32, i32* %u203
    %u218 = load i32, i32* %u207
    %u219 = load i32, i32* %u211
    %u220 = mul i32  %u218, 7
    %u221 = add i32  %u219, %u220
    %u222 = mul i32  %u217, 28
    %u223 = add i32 %u221, %u222
    %u224 = mul i32  %u216, 112
    %u225 = add i32 %u223, %u224
    %u226 = mul i32  %u215, 448
    %u227 = add i32 %u225, %u226
    %u228 = mul i32  %u214, 1792
    %u229 = add i32 %u227, %u228
    %u230 = getelementptr [7168 x i32],[7168 x i32]*  @dp, i32 0, i32 %u229
    %u231 = load i32, i32* %u230
    store i32  -1, i32* %u230
    %u232 = add i32  %u219,  1
    store i32  %u232, i32* %u211
    %u233 = load i32, i32* %u211
    br label %x27

x29:
    %u234 = load i32, i32* %u207
    %u235 = add i32  %u234,  1
    store i32  %u235, i32* %u207
    %u236 = load i32, i32* %u207
    br label %x25

x30:
    %u237 = load i32, i32* %u203
    %u238 = add i32  %u237,  1
    store i32  %u238, i32* %u203
    %u239 = load i32, i32* %u203
    br label %x23

x31:
    %u240 = load i32, i32* %u199
    %u241 = add i32  %u240,  1
    store i32  %u241, i32* %u199
    %u242 = load i32, i32* %u199
    br label %x21

x32:
    %u243 = load i32, i32* %u195
    %u244 = add i32  %u243,  1
    store i32  %u244, i32* %u195
    %u245 = load i32, i32* %u195
    br label %x19

x33:
    %u246 = load i32, i32* %u191
    %u247 = add i32  %u246,  1
    store i32  %u247, i32* %u191
    %u248 = load i32, i32* %u191
    br label %x17

x34:
    store i32  0, i32* %u191
    br label %x35

x35:
    %u249 = load i32, i32* %u191
    %u250 = load i32, i32* %u188
    %u251 = icmp slt  i32  %u249, %u250
    br i1 %u251, label %x36, label %x37

x36:
    %u252 = load i32, i32* %u191
    %u253 = getelementptr [200 x i32],[200 x i32]*  @list, i32 0, i32  %u252
    %u254 = load i32, i32* %u253
    %u255 = call i32 @getint()
    store i32  %u255, i32* %u253
    %u256 = getelementptr [200 x i32],[200 x i32]*  @list, i32 0, i32  %u252
    %u257 = load i32, i32* %u256
    %u258 = getelementptr [20 x i32],[20 x i32]*  @cns, i32 0, i32  %u257
    %u259 = load i32, i32* %u258
    %u260 = getelementptr [200 x i32],[200 x i32]*  @list, i32 0, i32  %u252
    %u261 = load i32, i32* %u260
    %u262 = getelementptr [20 x i32],[20 x i32]*  @cns, i32 0, i32  %u261
    %u263 = load i32, i32* %u262
    %u264 = add i32  %u263,  1
    store i32  %u264, i32* %u258
    %u265 = add i32  %u252,  1
    store i32  %u265, i32* %u191
    %u266 = load i32, i32* %u191
    br label %x35

x37:
    %u267 = alloca i32
    %u268 = alloca i32
    %u269 = getelementptr [20 x i32],[20 x i32]*  @cns, i32 0, i32 1
    %u270 = load i32, i32* %u269
    %u271 = getelementptr [20 x i32],[20 x i32]*  @cns, i32 0, i32 2
    %u272 = load i32, i32* %u271
    %u273 = getelementptr [20 x i32],[20 x i32]*  @cns, i32 0, i32 3
    %u274 = load i32, i32* %u273
    %u275 = getelementptr [20 x i32],[20 x i32]*  @cns, i32 0, i32 4
    %u276 = load i32, i32* %u275
    %u277 = getelementptr [20 x i32],[20 x i32]*  @cns, i32 0, i32 5
    %u278 = load i32, i32* %u277
    %u279 = call i32 @dfs(i32  %u270, i32  %u272, i32  %u274, i32  %u276, i32  %u278, i32 0)
    store i32  %u279, i32* %u268
    %u280 = load i32, i32* %u268
    call void @putint(i32  %u280)
    ret i32  0
}
