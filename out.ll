declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
@n = dso_local global i32 0
define dso_local i32 @bubblesort(i32* %u1) {
    %u2 = alloca i32
    %u3 = alloca i32
    store i32  0, i32* %u2
    br label %x1

x1:
    %u4 = load i32, i32* @n
    %u5 = sub i32  %u4,  1
    %u6 = load i32, i32* %u2
    %u7 = icmp slt  i32  %u6, %u5
    br i1 %u7, label %x2, label %x8

x2:
    store i32  0, i32* %u3
    br label %x3

x3:
    %u8 = load i32, i32* %u2
    %u9 = load i32, i32* @n
    %u10 = sub i32  %u9,  %u8
    %u11 = sub i32  %u10,  1
    %u12 = load i32, i32* %u3
    %u13 = icmp slt  i32  %u12, %u11
    br i1 %u13, label %x4, label %x7

x4:
    %u14 = load i32, i32* %u3
    %u15 = getelementptr i32, i32*  %u1, i32  %u14
    %u16 = load i32, i32* %u15
    %u17 = add i32  %u14,  1
    %u18 = getelementptr i32, i32*  %u1, i32  %u17
    %u19 = load i32, i32* %u18
    %u20 = icmp sgt  i32  %u16, %u19
    br i1 %u20,label %x5, label %x6

x5:
    %u21 = alloca i32
    %u22 = load i32, i32* %u3
    %u23 = add i32  %u22,  1
    %u24 = getelementptr i32, i32*  %u1, i32  %u23
    %u25 = load i32, i32* %u24
    store i32  %u25, i32* %u21
    %u26 = add i32  %u22,  1
    %u27 = getelementptr i32, i32*  %u1, i32  %u26
    %u28 = load i32, i32* %u27
    %u29 = getelementptr i32, i32*  %u1, i32  %u22
    %u30 = load i32, i32* %u29
    store i32  %u30, i32* %u27
    %u31 = getelementptr i32, i32*  %u1, i32  %u22
    %u32 = load i32, i32* %u31
    %u33 = load i32, i32* %u21
    store i32  %u33, i32* %u31
    br label %x6

x6:
    %u34 = load i32, i32* %u3
    %u35 = add i32  %u34,  1
    store i32  %u35, i32* %u3
    %u36 = load i32, i32* %u3
    br label %x3

x7:
    %u37 = load i32, i32* %u2
    %u38 = add i32  %u37,  1
    store i32  %u38, i32* %u2
    %u39 = load i32, i32* %u2
    br label %x1

x8:
    ret i32  0
}
define dso_local i32 @insertsort(i32* %u40) {
    %u41 = alloca i32
    store i32  1, i32* %u41
    br label %x9

x9:
    %u42 = load i32, i32* %u41
    %u43 = load i32, i32* @n
    %u44 = icmp slt  i32  %u42, %u43
    br i1 %u44, label %x10, label %x14

x10:
    %u45 = alloca i32
    %u46 = load i32, i32* %u41
    %u47 = getelementptr i32, i32*  %u40, i32  %u46
    %u48 = load i32, i32* %u47
    store i32  %u48, i32* %u45
    %u49 = alloca i32
    %u50 = sub i32  %u46,  1
    store i32  %u50, i32* %u49
    br label %x11

x11:
    %u51 = load i32, i32* %u49
    %u52 = icmp sgt  i32  %u51,-1
    %u53 = getelementptr i32, i32*  %u40, i32  %u51
    %u54 = load i32, i32* %u53
    %u55 = load i32, i32* %u45
    %u56 = icmp slt  i32  %u55, %u54
    %u57 = and i1  %u52, %u56
    br i1 %u57, label %x12, label %x13

x12:
    %u58 = load i32, i32* %u49
    %u59 = add i32  %u58,  1
    %u60 = getelementptr i32, i32*  %u40, i32  %u59
    %u61 = load i32, i32* %u60
    %u62 = getelementptr i32, i32*  %u40, i32  %u58
    %u63 = load i32, i32* %u62
    store i32  %u63, i32* %u60
    %u64 = sub i32  %u58,  1
    store i32  %u64, i32* %u49
    %u65 = load i32, i32* %u49
    br label %x11

x13:
    %u66 = load i32, i32* %u49
    %u67 = add i32  %u66,  1
    %u68 = getelementptr i32, i32*  %u40, i32  %u67
    %u69 = load i32, i32* %u68
    %u70 = load i32, i32* %u45
    store i32  %u70, i32* %u68
    %u71 = load i32, i32* %u41
    %u72 = add i32  %u71,  1
    store i32  %u72, i32* %u41
    %u73 = load i32, i32* %u41
    br label %x9

x14:
    ret i32  0
}
define dso_local i32 @QuickSort(i32* %u74, i32 %u75, i32 %u76) {
    %u77 = icmp slt  i32  %u75, %u76
    br i1 %u77,label %x15, label %x29

x15:
    %u78 = alloca i32
    store i32  %u75, i32* %u78
    %u79 = alloca i32
    store i32  %u76, i32* %u79
    %u80 = alloca i32
    %u81 = getelementptr i32, i32*  %u74, i32  %u75
    %u82 = load i32, i32* %u81
    store i32  %u82, i32* %u80
    br label %x16

x16:
    %u83 = load i32, i32* %u78
    %u84 = load i32, i32* %u79
    %u85 = icmp slt  i32  %u83, %u84
    br i1 %u85, label %x17, label %x28

x17:
    br label %x18

x18:
    %u86 = load i32, i32* %u78
    %u87 = load i32, i32* %u79
    %u88 = icmp slt  i32  %u86, %u87
    %u89 = getelementptr i32, i32*  %u74, i32  %u87
    %u90 = load i32, i32* %u89
    %u91 = load i32, i32* %u80
    %u92 = sub i32  %u91,  1
    %u93 = icmp sgt  i32  %u90, %u92
    %u94 = and i1  %u88, %u93
    br i1 %u94, label %x19, label %x20

x19:
    %u95 = load i32, i32* %u79
    %u96 = sub i32  %u95,  1
    store i32  %u96, i32* %u79
    %u97 = load i32, i32* %u79
    br label %x18

x20:
    %u98 = load i32, i32* %u78
    %u99 = load i32, i32* %u79
    %u100 = icmp slt  i32  %u98, %u99
    br i1 %u100,label %x21, label %x22

x21:
    %u101 = load i32, i32* %u78
    %u102 = getelementptr i32, i32*  %u74, i32  %u101
    %u103 = load i32, i32* %u102
    %u104 = load i32, i32* %u79
    %u105 = getelementptr i32, i32*  %u74, i32  %u104
    %u106 = load i32, i32* %u105
    store i32  %u106, i32* %u102
    %u107 = add i32  %u101,  1
    store i32  %u107, i32* %u78
    %u108 = load i32, i32* %u78
    br label %x22

x22:
    br label %x23

x23:
    %u109 = load i32, i32* %u78
    %u110 = load i32, i32* %u79
    %u111 = icmp slt  i32  %u109, %u110
    %u112 = getelementptr i32, i32*  %u74, i32  %u109
    %u113 = load i32, i32* %u112
    %u114 = load i32, i32* %u80
    %u115 = icmp slt  i32  %u113, %u114
    %u116 = and i1  %u111, %u115
    br i1 %u116, label %x24, label %x25

x24:
    %u117 = load i32, i32* %u78
    %u118 = add i32  %u117,  1
    store i32  %u118, i32* %u78
    %u119 = load i32, i32* %u78
    br label %x23

x25:
    %u120 = load i32, i32* %u78
    %u121 = load i32, i32* %u79
    %u122 = icmp slt  i32  %u120, %u121
    br i1 %u122,label %x26, label %x27

x26:
    %u123 = load i32, i32* %u79
    %u124 = getelementptr i32, i32*  %u74, i32  %u123
    %u125 = load i32, i32* %u124
    %u126 = load i32, i32* %u78
    %u127 = getelementptr i32, i32*  %u74, i32  %u126
    %u128 = load i32, i32* %u127
    store i32  %u128, i32* %u124
    %u129 = sub i32  %u123,  1
    store i32  %u129, i32* %u79
    %u130 = load i32, i32* %u79
    br label %x27

x27:
    br label %x16

x28:
    %u131 = load i32, i32* %u78
    %u132 = getelementptr i32, i32*  %u74, i32  %u131
    %u133 = load i32, i32* %u132
    %u134 = load i32, i32* %u80
    store i32  %u134, i32* %u132
    %u135 = alloca i32
    %u136 = sub i32  %u131,  1
    store i32  %u136, i32* %u135
    %u137 = getelementptr i32, i32*  %u74, i32 0
    %u138 = load i32, i32* %u135
    %u139 = call i32 @QuickSort(i32*  %u137, i32  %u75, i32  %u138)
    store i32  %u139, i32* %u135
    %u140 = load i32, i32* %u135
    %u141 = add i32  %u131,  1
    store i32  %u141, i32* %u135
    %u142 = load i32, i32* %u135
    %u143 = getelementptr i32, i32*  %u74, i32 0
    %u144 = call i32 @QuickSort(i32*  %u143, i32  %u142, i32  %u76)
    store i32  %u144, i32* %u135
    %u145 = load i32, i32* %u135
    br label %x29

x29:
    ret i32  0
}
define dso_local i32 @getMid(i32* %u146) {
    %u147 = alloca i32
    %u148 = load i32, i32* @n
    %u149 = srem i32  %u148,  2
    %u150 = icmp eq i32  %u149,0
    br i1 %u150,label %x30, label %x31

x30:
    %u151 = load i32, i32* @n
    %u152 = sdiv i32  %u151,  2
    store i32  %u152, i32* %u147
    %u153 = load i32, i32* %u147
    %u154 = getelementptr i32, i32*  %u146, i32  %u153
    %u155 = load i32, i32* %u154
    %u156 = sub i32  %u153,  1
    %u157 = getelementptr i32, i32*  %u146, i32  %u156
    %u158 = load i32, i32* %u157
    %u159 = add i32  %u155,  %u158
    %u160 = sdiv i32  %u159,  2
    ret i32  %u160
    br label %x32

x31:
    %u161 = load i32, i32* @n
    %u162 = sdiv i32  %u161,  2
    store i32  %u162, i32* %u147
    %u163 = load i32, i32* %u147
    %u164 = getelementptr i32, i32*  %u146, i32  %u163
    %u165 = load i32, i32* %u164
    ret i32  %u165
    br label %x32

x32:
}
define dso_local i32 @getMost(i32* %u166) {
    %u167 = alloca [1000 x i32]
    %u168 = getelementptr [1000 x i32],[1000 x i32]* %u167, i32 0, i32 0
    call void @memset(i32* %u168 ,i32 0,i32 4000)
    %u169 = alloca i32
    store i32  0, i32* %u169
    br label %x33

x33:
    %u170 = load i32, i32* %u169
    %u171 = icmp slt  i32  %u170,1000
    br i1 %u171, label %x34, label %x35

x34:
    %u172 = load i32, i32* %u169
    %u173 = getelementptr [1000 x i32],[1000 x i32]*  %u167, i32 0, i32  %u172
    %u174 = load i32, i32* %u173
    store i32  0, i32* %u173
    %u175 = add i32  %u172,  1
    store i32  %u175, i32* %u169
    %u176 = load i32, i32* %u169
    br label %x33

x35:
    store i32  0, i32* %u169
    %u177 = alloca i32
    %u178 = alloca i32
    store i32  0, i32* %u177
    br label %x36

x36:
    %u179 = load i32, i32* %u169
    %u180 = load i32, i32* @n
    %u181 = icmp slt  i32  %u179, %u180
    br i1 %u181, label %x37, label %x40

x37:
    %u182 = alloca i32
    %u183 = load i32, i32* %u169
    %u184 = getelementptr i32, i32*  %u166, i32  %u183
    %u185 = load i32, i32* %u184
    store i32  %u185, i32* %u182
    %u186 = load i32, i32* %u182
    %u187 = getelementptr [1000 x i32],[1000 x i32]*  %u167, i32 0, i32  %u186
    %u188 = load i32, i32* %u187
    %u189 = getelementptr [1000 x i32],[1000 x i32]*  %u167, i32 0, i32  %u186
    %u190 = load i32, i32* %u189
    %u191 = add i32  %u190,  1
    store i32  %u191, i32* %u187
    %u192 = getelementptr [1000 x i32],[1000 x i32]*  %u167, i32 0, i32  %u186
    %u193 = load i32, i32* %u192
    %u194 = load i32, i32* %u177
    %u195 = icmp sgt  i32  %u193, %u194
    br i1 %u195,label %x38, label %x39

x38:
    %u196 = load i32, i32* %u182
    %u197 = getelementptr [1000 x i32],[1000 x i32]*  %u167, i32 0, i32  %u196
    %u198 = load i32, i32* %u197
    store i32  %u198, i32* %u177
    store i32  %u196, i32* %u178
    br label %x39

x39:
    %u199 = load i32, i32* %u169
    %u200 = add i32  %u199,  1
    store i32  %u200, i32* %u169
    %u201 = load i32, i32* %u169
    br label %x36

x40:
    %u202 = load i32, i32* %u178
    ret i32  %u202
}
define dso_local i32 @revert(i32* %u203) {
    %u204 = alloca i32
    %u205 = alloca i32
    %u206 = alloca i32
    store i32  0, i32* %u205
    store i32  0, i32* %u206
    br label %x41

x41:
    %u207 = load i32, i32* %u205
    %u208 = load i32, i32* %u206
    %u209 = icmp slt  i32  %u207, %u208
    br i1 %u209, label %x42, label %x43

x42:
    %u210 = load i32, i32* %u205
    %u211 = getelementptr i32, i32*  %u203, i32  %u210
    %u212 = load i32, i32* %u211
    store i32  %u212, i32* %u204
    %u213 = getelementptr i32, i32*  %u203, i32  %u210
    %u214 = load i32, i32* %u213
    %u215 = load i32, i32* %u206
    %u216 = getelementptr i32, i32*  %u203, i32  %u215
    %u217 = load i32, i32* %u216
    store i32  %u217, i32* %u213
    %u218 = getelementptr i32, i32*  %u203, i32  %u215
    %u219 = load i32, i32* %u218
    %u220 = load i32, i32* %u204
    store i32  %u220, i32* %u218
    %u221 = add i32  %u210,  1
    store i32  %u221, i32* %u205
    %u222 = load i32, i32* %u205
    %u223 = sub i32  %u215,  1
    store i32  %u223, i32* %u206
    %u224 = load i32, i32* %u206
    br label %x41

x43:
    ret i32  0
}
define dso_local i32 @arrCopy(i32* %u225, i32* %u226) {
    %u227 = alloca i32
    store i32  0, i32* %u227
    br label %x44

x44:
    %u228 = load i32, i32* %u227
    %u229 = load i32, i32* @n
    %u230 = icmp slt  i32  %u228, %u229
    br i1 %u230, label %x45, label %x46

x45:
    %u231 = load i32, i32* %u227
    %u232 = getelementptr i32, i32*  %u226, i32  %u231
    %u233 = load i32, i32* %u232
    %u234 = getelementptr i32, i32*  %u225, i32  %u231
    %u235 = load i32, i32* %u234
    store i32  %u235, i32* %u232
    %u236 = add i32  %u231,  1
    store i32  %u236, i32* %u227
    %u237 = load i32, i32* %u227
    br label %x44

x46:
    ret i32  0
}
define dso_local i32 @calSum(i32* %u238, i32 %u239) {
    %u240 = alloca i32
    store i32  0, i32* %u240
    %u241 = alloca i32
    store i32  0, i32* %u241
    br label %x47

x47:
    %u242 = load i32, i32* %u241
    %u243 = load i32, i32* @n
    %u244 = icmp slt  i32  %u242, %u243
    br i1 %u244, label %x48, label %x52

x48:
    %u245 = load i32, i32* %u241
    %u246 = getelementptr i32, i32*  %u238, i32  %u245
    %u247 = load i32, i32* %u246
    %u248 = load i32, i32* %u240
    %u249 = add i32  %u248,  %u247
    store i32  %u249, i32* %u240
    %u250 = load i32, i32* %u240
    %u251 = srem i32  %u245,  %u239
    %u252 = sub i32  %u239,  1
    %u253 = icmp ne i32  %u251, %u252
    br i1 %u253,label %x49, label %x50

x49:
    %u254 = load i32, i32* %u241
    %u255 = getelementptr i32, i32*  %u238, i32  %u254
    %u256 = load i32, i32* %u255
    store i32  0, i32* %u255
    br label %x51

x50:
    %u257 = load i32, i32* %u241
    %u258 = getelementptr i32, i32*  %u238, i32  %u257
    %u259 = load i32, i32* %u258
    %u260 = load i32, i32* %u240
    store i32  %u260, i32* %u258
    store i32  0, i32* %u240
    %u261 = load i32, i32* %u240
    br label %x51

x51:
    %u262 = load i32, i32* %u241
    %u263 = add i32  %u262,  1
    store i32  %u263, i32* %u241
    %u264 = load i32, i32* %u241
    br label %x47

x52:
    ret i32  0
}
define dso_local i32 @avgPooling(i32* %u265, i32 %u266) {
    %u267 = alloca i32
    %u268 = alloca i32
    store i32  0, i32* %u268
    store i32  0, i32* %u267
    %u269 = alloca i32
    br label %x53

x53:
    %u270 = load i32, i32* %u268
    %u271 = load i32, i32* @n
    %u272 = icmp slt  i32  %u270, %u271
    br i1 %u272, label %x54, label %x61

x54:
    %u273 = sub i32  %u266,  1
    %u274 = load i32, i32* %u268
    %u275 = icmp slt  i32  %u274, %u273
    br i1 %u275,label %x55, label %x56

x55:
    %u276 = load i32, i32* %u268
    %u277 = getelementptr i32, i32*  %u265, i32  %u276
    %u278 = load i32, i32* %u277
    %u279 = load i32, i32* %u267
    %u280 = add i32  %u279,  %u278
    store i32  %u280, i32* %u267
    %u281 = load i32, i32* %u267
    br label %x60

x56:
    %u282 = sub i32  %u266,  1
    %u283 = load i32, i32* %u268
    %u284 = icmp eq i32  %u283, %u282
    br i1 %u284,label %x57, label %x58

x57:
    %u285 = getelementptr i32, i32*  %u265, i32 0
    %u286 = load i32, i32* %u285
    store i32  %u286, i32* %u269
    %u287 = getelementptr i32, i32*  %u265, i32 0
    %u288 = load i32, i32* %u287
    %u289 = load i32, i32* %u267
    %u290 = sdiv i32  %u289,  %u266
    store i32  %u290, i32* %u287
    br label %x59

x58:
    %u291 = load i32, i32* %u268
    %u292 = getelementptr i32, i32*  %u265, i32  %u291
    %u293 = load i32, i32* %u292
    %u294 = load i32, i32* %u267
    %u295 = add i32  %u294,  %u293
    %u296 = load i32, i32* %u269
    %u297 = sub i32  %u295,  %u296
    store i32  %u297, i32* %u267
    %u298 = load i32, i32* %u267
    %u299 = sub i32  %u291,  %u266
    %u300 = add i32  %u299,  1
    %u301 = getelementptr i32, i32*  %u265, i32  %u300
    %u302 = load i32, i32* %u301
    store i32  %u302, i32* %u269
    %u303 = load i32, i32* %u269
    %u304 = sub i32  %u291,  %u266
    %u305 = add i32  %u304,  1
    %u306 = getelementptr i32, i32*  %u265, i32  %u305
    %u307 = load i32, i32* %u306
    %u308 = sdiv i32  %u298,  %u266
    store i32  %u308, i32* %u306
    br label %x59

x59:
    br label %x60

x60:
    %u309 = load i32, i32* %u268
    %u310 = add i32  %u309,  1
    store i32  %u310, i32* %u268
    %u311 = load i32, i32* %u268
    br label %x53

x61:
    %u312 = load i32, i32* @n
    %u313 = sub i32  %u312,  %u266
    %u314 = add i32  %u313,  1
    store i32  %u314, i32* %u268
    br label %x62

x62:
    %u315 = load i32, i32* %u268
    %u316 = load i32, i32* @n
    %u317 = icmp slt  i32  %u315, %u316
    br i1 %u317, label %x63, label %x64

x63:
    %u318 = load i32, i32* %u268
    %u319 = getelementptr i32, i32*  %u265, i32  %u318
    %u320 = load i32, i32* %u319
    store i32  0, i32* %u319
    %u321 = add i32  %u318,  1
    store i32  %u321, i32* %u268
    %u322 = load i32, i32* %u268
    br label %x62

x64:
    ret i32  0
}
define dso_local i32 @main() {
    store i32  32, i32* @n
    %u323 = alloca [32 x i32]
    %u324 = getelementptr [32 x i32],[32 x i32]* %u323, i32 0, i32 0
    call void @memset(i32* %u324 ,i32 0,i32 128)
    %u325 = alloca [32 x i32]
    %u326 = getelementptr [32 x i32],[32 x i32]* %u325, i32 0, i32 0
    call void @memset(i32* %u326 ,i32 0,i32 128)
    %u327 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 0
    %u328 = load i32, i32* %u327
    store i32  7, i32* %u327
    %u329 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 1
    %u330 = load i32, i32* %u329
    store i32  23, i32* %u329
    %u331 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 2
    %u332 = load i32, i32* %u331
    store i32  89, i32* %u331
    %u333 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 3
    %u334 = load i32, i32* %u333
    store i32  26, i32* %u333
    %u335 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 4
    %u336 = load i32, i32* %u335
    store i32  282, i32* %u335
    %u337 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 5
    %u338 = load i32, i32* %u337
    store i32  254, i32* %u337
    %u339 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 6
    %u340 = load i32, i32* %u339
    store i32  27, i32* %u339
    %u341 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 7
    %u342 = load i32, i32* %u341
    store i32  5, i32* %u341
    %u343 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 8
    %u344 = load i32, i32* %u343
    store i32  83, i32* %u343
    %u345 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 9
    %u346 = load i32, i32* %u345
    store i32  273, i32* %u345
    %u347 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 10
    %u348 = load i32, i32* %u347
    store i32  574, i32* %u347
    %u349 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 11
    %u350 = load i32, i32* %u349
    store i32  905, i32* %u349
    %u351 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 12
    %u352 = load i32, i32* %u351
    store i32  354, i32* %u351
    %u353 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 13
    %u354 = load i32, i32* %u353
    store i32  657, i32* %u353
    %u355 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 14
    %u356 = load i32, i32* %u355
    store i32  935, i32* %u355
    %u357 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 15
    %u358 = load i32, i32* %u357
    store i32  264, i32* %u357
    %u359 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 16
    %u360 = load i32, i32* %u359
    store i32  639, i32* %u359
    %u361 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 17
    %u362 = load i32, i32* %u361
    store i32  459, i32* %u361
    %u363 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 18
    %u364 = load i32, i32* %u363
    store i32  29, i32* %u363
    %u365 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 19
    %u366 = load i32, i32* %u365
    store i32  68, i32* %u365
    %u367 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 20
    %u368 = load i32, i32* %u367
    store i32  929, i32* %u367
    %u369 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 21
    %u370 = load i32, i32* %u369
    store i32  756, i32* %u369
    %u371 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 22
    %u372 = load i32, i32* %u371
    store i32  452, i32* %u371
    %u373 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 23
    %u374 = load i32, i32* %u373
    store i32  279, i32* %u373
    %u375 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 24
    %u376 = load i32, i32* %u375
    store i32  58, i32* %u375
    %u377 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 25
    %u378 = load i32, i32* %u377
    store i32  87, i32* %u377
    %u379 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 26
    %u380 = load i32, i32* %u379
    store i32  96, i32* %u379
    %u381 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 27
    %u382 = load i32, i32* %u381
    store i32  36, i32* %u381
    %u383 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 28
    %u384 = load i32, i32* %u383
    store i32  39, i32* %u383
    %u385 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 29
    %u386 = load i32, i32* %u385
    store i32  28, i32* %u385
    %u387 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 30
    %u388 = load i32, i32* %u387
    store i32  1, i32* %u387
    %u389 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 31
    %u390 = load i32, i32* %u389
    store i32  290, i32* %u389
    %u391 = alloca i32
    %u392 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 0
    %u393 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u394 = call i32 @arrCopy(i32*  %u392, i32*  %u393)
    store i32  %u394, i32* %u391
    %u395 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u396 = call i32 @revert(i32*  %u395)
    store i32  %u396, i32* %u391
    %u397 = alloca i32
    store i32  0, i32* %u397
    br label %x65

x65:
    %u398 = load i32, i32* %u397
    %u399 = icmp slt  i32  %u398,32
    br i1 %u399, label %x66, label %x67

x66:
    %u400 = load i32, i32* %u397
    %u401 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32  %u400
    %u402 = load i32, i32* %u401
    store i32  %u402, i32* %u391
    %u403 = load i32, i32* %u391
    call void @putint(i32  %u403)
    %u404 = add i32  %u400,  1
    store i32  %u404, i32* %u397
    %u405 = load i32, i32* %u397
    br label %x65

x67:
    %u406 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u407 = call i32 @bubblesort(i32*  %u406)
    store i32  %u407, i32* %u391
    store i32  0, i32* %u397
    br label %x68

x68:
    %u408 = load i32, i32* %u397
    %u409 = icmp slt  i32  %u408,32
    br i1 %u409, label %x69, label %x70

x69:
    %u410 = load i32, i32* %u397
    %u411 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32  %u410
    %u412 = load i32, i32* %u411
    store i32  %u412, i32* %u391
    %u413 = load i32, i32* %u391
    call void @putint(i32  %u413)
    %u414 = add i32  %u410,  1
    store i32  %u414, i32* %u397
    %u415 = load i32, i32* %u397
    br label %x68

x70:
    %u416 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u417 = call i32 @getMid(i32*  %u416)
    store i32  %u417, i32* %u391
    %u418 = load i32, i32* %u391
    call void @putint(i32  %u418)
    %u419 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u420 = call i32 @getMost(i32*  %u419)
    store i32  %u420, i32* %u391
    %u421 = load i32, i32* %u391
    call void @putint(i32  %u421)
    %u422 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 0
    %u423 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u424 = call i32 @arrCopy(i32*  %u422, i32*  %u423)
    store i32  %u424, i32* %u391
    %u425 = load i32, i32* %u391
    %u426 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u427 = call i32 @bubblesort(i32*  %u426)
    store i32  %u427, i32* %u391
    %u428 = load i32, i32* %u391
    store i32  0, i32* %u397
    br label %x71

x71:
    %u429 = load i32, i32* %u397
    %u430 = icmp slt  i32  %u429,32
    br i1 %u430, label %x72, label %x73

x72:
    %u431 = load i32, i32* %u397
    %u432 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32  %u431
    %u433 = load i32, i32* %u432
    store i32  %u433, i32* %u391
    %u434 = load i32, i32* %u391
    call void @putint(i32  %u434)
    %u435 = add i32  %u431,  1
    store i32  %u435, i32* %u397
    %u436 = load i32, i32* %u397
    br label %x71

x73:
    %u437 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 0
    %u438 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u439 = call i32 @arrCopy(i32*  %u437, i32*  %u438)
    store i32  %u439, i32* %u391
    %u440 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u441 = call i32 @insertsort(i32*  %u440)
    store i32  %u441, i32* %u391
    store i32  0, i32* %u397
    br label %x74

x74:
    %u442 = load i32, i32* %u397
    %u443 = icmp slt  i32  %u442,32
    br i1 %u443, label %x75, label %x76

x75:
    %u444 = load i32, i32* %u397
    %u445 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32  %u444
    %u446 = load i32, i32* %u445
    store i32  %u446, i32* %u391
    %u447 = load i32, i32* %u391
    call void @putint(i32  %u447)
    %u448 = add i32  %u444,  1
    store i32  %u448, i32* %u397
    %u449 = load i32, i32* %u397
    br label %x74

x76:
    %u450 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 0
    %u451 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u452 = call i32 @arrCopy(i32*  %u450, i32*  %u451)
    store i32  %u452, i32* %u391
    store i32  0, i32* %u397
    store i32  31, i32* %u391
    %u453 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u454 = load i32, i32* %u397
    %u455 = load i32, i32* %u391
    %u456 = call i32 @QuickSort(i32*  %u453, i32  %u454, i32  %u455)
    store i32  %u456, i32* %u391
    %u457 = load i32, i32* %u391
    br label %x77

x77:
    %u458 = load i32, i32* %u397
    %u459 = icmp slt  i32  %u458,32
    br i1 %u459, label %x78, label %x79

x78:
    %u460 = load i32, i32* %u397
    %u461 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32  %u460
    %u462 = load i32, i32* %u461
    store i32  %u462, i32* %u391
    %u463 = load i32, i32* %u391
    call void @putint(i32  %u463)
    %u464 = add i32  %u460,  1
    store i32  %u464, i32* %u397
    %u465 = load i32, i32* %u397
    br label %x77

x79:
    %u466 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 0
    %u467 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u468 = call i32 @arrCopy(i32*  %u466, i32*  %u467)
    store i32  %u468, i32* %u391
    %u469 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u470 = call i32 @calSum(i32*  %u469, i32 4)
    store i32  %u470, i32* %u391
    store i32  0, i32* %u397
    br label %x80

x80:
    %u471 = load i32, i32* %u397
    %u472 = icmp slt  i32  %u471,32
    br i1 %u472, label %x81, label %x82

x81:
    %u473 = load i32, i32* %u397
    %u474 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32  %u473
    %u475 = load i32, i32* %u474
    store i32  %u475, i32* %u391
    %u476 = load i32, i32* %u391
    call void @putint(i32  %u476)
    %u477 = add i32  %u473,  1
    store i32  %u477, i32* %u397
    %u478 = load i32, i32* %u397
    br label %x80

x82:
    %u479 = getelementptr [32 x i32],[32 x i32]*  %u323, i32 0, i32 0
    %u480 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u481 = call i32 @arrCopy(i32*  %u479, i32*  %u480)
    store i32  %u481, i32* %u391
    %u482 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32 0
    %u483 = call i32 @avgPooling(i32*  %u482, i32 3)
    store i32  %u483, i32* %u391
    store i32  0, i32* %u397
    br label %x83

x83:
    %u484 = load i32, i32* %u397
    %u485 = icmp slt  i32  %u484,32
    br i1 %u485, label %x84, label %x85

x84:
    %u486 = load i32, i32* %u397
    %u487 = getelementptr [32 x i32],[32 x i32]*  %u325, i32 0, i32  %u486
    %u488 = load i32, i32* %u487
    store i32  %u488, i32* %u391
    %u489 = load i32, i32* %u391
    call void @putint(i32  %u489)
    %u490 = add i32  %u486,  1
    store i32  %u490, i32* %u397
    %u491 = load i32, i32* %u397
    br label %x83

x85:
    ret i32  0
}
