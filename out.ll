declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
declare i32 @getarray(i32*)
declare void @putarray(i32, i32*)
@ints = dso_local global [10000 x i32] zeroinitializer
@intt = dso_local global i32 0
@chas = dso_local global [10000 x i32] zeroinitializer
@chat = dso_local global i32 0
@i = dso_local global i32 0
@ii = dso_local global i32 1
@c = dso_local global i32 0
@get = dso_local global [10000 x i32] zeroinitializer
@get2 = dso_local global [10000 x i32] zeroinitializer
define dso_local i32 @isdigit(i32 %u1) {
    %u2 = alloca i32
    store i32 %u1, i32* %u2
    %u3 = load i32, i32* %u2
    %u4 = icmp sge  i32  %u3,48
    %u5 = icmp sle  i32  %u3,57
    %u6 = and i1  %u4, %u5
    br i1 %u6, label %x1, label %x2

x1:
    ret i32  1

x2:
    ret i32  0
}
define dso_local i32 @power(i32 %u7, i32 %u8) {
    %u9 = alloca i32
    store i32 %u7, i32* %u9
    %u10 = alloca i32
    store i32 %u8, i32* %u10
    %u11 = alloca i32
    %u12 = alloca i32
    store i32  1, i32* %u12
    br label %x3

x3:
    %u13 = load i32, i32* %u10
    %u14 = icmp ne i32  %u13,0
    br i1 %u14, label %x4, label %x5

x4:
    %u15 = load i32, i32* %u9
    %u16 = load i32, i32* %u12
    %u17 = mul i32  %u16,  %u15
    store i32  %u17, i32* %u12
    %u18 = load i32, i32* %u12
    %u19 = load i32, i32* %u10
    %u20 = sub i32  %u19,  1
    store i32  %u20, i32* %u10
    %u21 = load i32, i32* %u10
    br label %x3

x5:
    %u22 = load i32, i32* %u12
    ret i32  %u22
}
define dso_local i32 @getstr(i32* %u23) {
    %u24 = alloca i32
    %u25 = alloca i32
    %u26 = call i32 @getch()
    store i32  %u26, i32* %u25
    %u27 = alloca i32
    %u28 = alloca i32
    store i32  0, i32* %u28
    br label %x6

x6:
    %u29 = load i32, i32* %u25
    %u30 = icmp ne i32  %u29,13
    %u31 = icmp ne i32  %u29,10
    %u32 = and i1  %u30, %u31
    br i1 %u32, label %x7, label %x8

x7:
    %u33 = load i32, i32* %u28
    %u34 = getelementptr i32, i32*  %u23, i32  %u33
    %u35 = load i32, i32* %u34
    %u36 = load i32, i32* %u25
    store i32  %u36, i32* %u34
    %u37 = add i32  %u33,  1
    store i32  %u37, i32* %u28
    %u38 = load i32, i32* %u28
    %u39 = call i32 @getch()
    store i32  %u39, i32* %u25
    %u40 = load i32, i32* %u25
    br label %x6

x8:
    %u41 = load i32, i32* %u28
    ret i32  %u41
}
define dso_local void @intpush(i32 %u42) {
    %u43 = alloca i32
    store i32 %u42, i32* %u43
    %u44 = load i32, i32* @intt
    %u45 = add i32  %u44,  1
    store i32  %u45, i32* @intt
    %u46 = load i32, i32* @intt
    %u47 = load i32, i32* @intt
    %u48 = getelementptr [10000 x i32],[10000 x i32]*  @ints, i32 0, i32  %u47
    %u49 = load i32, i32* %u48
    %u50 = load i32, i32* %u43
    store i32  %u50, i32* %u48
    ret void
}
define dso_local void @chapush(i32 %u51) {
    %u52 = alloca i32
    store i32 %u51, i32* %u52
    %u53 = load i32, i32* @chat
    %u54 = add i32  %u53,  1
    store i32  %u54, i32* @chat
    %u55 = load i32, i32* @chat
    %u56 = load i32, i32* @chat
    %u57 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u56
    %u58 = load i32, i32* %u57
    %u59 = load i32, i32* %u52
    store i32  %u59, i32* %u57
    ret void
}
define dso_local i32 @intpop() {
    %u60 = load i32, i32* @intt
    %u61 = sub i32  %u60,  1
    store i32  %u61, i32* @intt
    %u62 = load i32, i32* @intt
    %u63 = load i32, i32* @intt
    %u64 = add i32  %u63,  1
    %u65 = getelementptr [10000 x i32],[10000 x i32]*  @ints, i32 0, i32  %u64
    %u66 = load i32, i32* %u65
    ret i32  %u66
}
define dso_local i32 @chapop() {
    %u67 = load i32, i32* @chat
    %u68 = sub i32  %u67,  1
    store i32  %u68, i32* @chat
    %u69 = load i32, i32* @chat
    %u70 = load i32, i32* @chat
    %u71 = add i32  %u70,  1
    %u72 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u71
    %u73 = load i32, i32* %u72
    ret i32  %u73
}
define dso_local void @intadd(i32 %u74) {
    %u75 = alloca i32
    store i32 %u74, i32* %u75
    %u76 = load i32, i32* @intt
    %u77 = getelementptr [10000 x i32],[10000 x i32]*  @ints, i32 0, i32  %u76
    %u78 = load i32, i32* %u77
    %u79 = load i32, i32* @intt
    %u80 = getelementptr [10000 x i32],[10000 x i32]*  @ints, i32 0, i32  %u79
    %u81 = load i32, i32* %u80
    %u82 = mul i32  %u81,  10
    store i32  %u82, i32* %u77
    %u83 = load i32, i32* @intt
    %u84 = getelementptr [10000 x i32],[10000 x i32]*  @ints, i32 0, i32  %u83
    %u85 = load i32, i32* %u84
    %u86 = load i32, i32* @intt
    %u87 = getelementptr [10000 x i32],[10000 x i32]*  @ints, i32 0, i32  %u86
    %u88 = load i32, i32* %u87
    %u89 = load i32, i32* %u75
    %u90 = add i32  %u88,  %u89
    store i32  %u90, i32* %u84
    ret void
}
define dso_local i32 @find() {
    %u91 = call i32 @chapop()
    store i32  %u91, i32* @c
    %u92 = load i32, i32* @ii
    %u93 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u92
    %u94 = load i32, i32* %u93
    store i32  32, i32* %u93
    %u95 = load i32, i32* @ii
    %u96 = add i32  %u95,  1
    %u97 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u96
    %u98 = load i32, i32* %u97
    %u99 = load i32, i32* @c
    store i32  %u99, i32* %u97
    %u100 = load i32, i32* @ii
    %u101 = add i32  %u100,  2
    store i32  %u101, i32* @ii
    %u102 = load i32, i32* @ii
    %u103 = load i32, i32* @chat
    %u104 = icmp eq i32  %u103,0
    br i1 %u104, label %x9, label %x10

x9:
    ret i32  0

x10:
    ret i32  1
}
define dso_local i32 @main() {
    store i32  0, i32* @intt
    store i32  0, i32* @chat
    %u105 = alloca i32
    %u106 = alloca i32
    %u107 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32 0
    %u108 = call i32 @getstr(i32*  %u107)
    store i32  %u108, i32* %u106
    br label %x11

x11:
    %u109 = load i32, i32* @i
    %u110 = load i32, i32* %u106
    %u111 = icmp slt  i32  %u109, %u110
    br i1 %u111, label %x12, label %x60

x12:
    %u112 = load i32, i32* @i
    %u113 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u112
    %u114 = load i32, i32* %u113
    %u115 = call i32 @isdigit(i32  %u114)
    %u116 = icmp eq i32  %u115,1
    br i1 %u116, label %x13, label %x14

x13:
    %u117 = load i32, i32* @ii
    %u118 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u117
    %u119 = load i32, i32* %u118
    %u120 = load i32, i32* @i
    %u121 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u120
    %u122 = load i32, i32* %u121
    store i32  %u122, i32* %u118
    %u123 = load i32, i32* @ii
    %u124 = add i32  %u123,  1
    store i32  %u124, i32* @ii
    %u125 = load i32, i32* @ii
    br label %x59

x14:
    %u126 = load i32, i32* @i
    %u127 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u126
    %u128 = load i32, i32* %u127
    %u129 = icmp eq i32  %u128,40
    br i1 %u129, label %x15, label %x16

x15:
    call void @chapush(i32 40)
    br label %x16

x16:
    %u130 = load i32, i32* @i
    %u131 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u130
    %u132 = load i32, i32* %u131
    %u133 = icmp eq i32  %u132,94
    br i1 %u133, label %x17, label %x18

x17:
    call void @chapush(i32 94)
    br label %x18

x18:
    %u134 = load i32, i32* @i
    %u135 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u134
    %u136 = load i32, i32* %u135
    %u137 = icmp eq i32  %u136,41
    br i1 %u137, label %x19, label %x23

x19:
    %u138 = call i32 @chapop()
    store i32  %u138, i32* @c
    br label %x20

x20:
    %u139 = load i32, i32* @c
    %u140 = icmp ne i32  %u139,40
    br i1 %u140, label %x21, label %x22

x21:
    %u141 = load i32, i32* @ii
    %u142 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u141
    %u143 = load i32, i32* %u142
    store i32  32, i32* %u142
    %u144 = load i32, i32* @ii
    %u145 = add i32  %u144,  1
    %u146 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u145
    %u147 = load i32, i32* %u146
    %u148 = load i32, i32* @c
    store i32  %u148, i32* %u146
    %u149 = load i32, i32* @ii
    %u150 = add i32  %u149,  2
    store i32  %u150, i32* @ii
    %u151 = load i32, i32* @ii
    %u152 = call i32 @chapop()
    store i32  %u152, i32* @c
    %u153 = load i32, i32* @c
    br label %x20

x22:
    br label %x23

x23:
    %u154 = load i32, i32* @i
    %u155 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u154
    %u156 = load i32, i32* %u155
    %u157 = icmp eq i32  %u156,43
    br i1 %u157, label %x24, label %x30

x24:
    br label %x25

x25:
    %u158 = load i32, i32* @chat
    %u159 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u158
    %u160 = load i32, i32* %u159
    %u161 = icmp eq i32  %u160,43
    %u162 = load i32, i32* @chat
    %u163 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u162
    %u164 = load i32, i32* %u163
    %u165 = icmp eq i32  %u164,45
    %u166 = or i1  %u161, %u165
    %u167 = load i32, i32* @chat
    %u168 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u167
    %u169 = load i32, i32* %u168
    %u170 = icmp eq i32  %u169,42
    %u171 = or i1  %u166, %u170
    %u172 = load i32, i32* @chat
    %u173 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u172
    %u174 = load i32, i32* %u173
    %u175 = icmp eq i32  %u174,47
    %u176 = or i1  %u171, %u175
    %u177 = load i32, i32* @chat
    %u178 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u177
    %u179 = load i32, i32* %u178
    %u180 = icmp eq i32  %u179,37
    %u181 = or i1  %u176, %u180
    %u182 = load i32, i32* @chat
    %u183 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u182
    %u184 = load i32, i32* %u183
    %u185 = icmp eq i32  %u184,94
    %u186 = or i1  %u181, %u185
    br i1 %u186, label %x26, label %x29

x26:
    %u187 = call i32 @find()
    %u188 = icmp eq i32  %u187,0
    br i1 %u188, label %x27, label %x28

x27:
    br label %x29
    br label %x28

x28:
    br label %x25

x29:
    call void @chapush(i32 43)
    br label %x30

x30:
    %u189 = load i32, i32* @i
    %u190 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u189
    %u191 = load i32, i32* %u190
    %u192 = icmp eq i32  %u191,45
    br i1 %u192, label %x31, label %x37

x31:
    br label %x32

x32:
    %u193 = load i32, i32* @chat
    %u194 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u193
    %u195 = load i32, i32* %u194
    %u196 = icmp eq i32  %u195,43
    %u197 = load i32, i32* @chat
    %u198 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u197
    %u199 = load i32, i32* %u198
    %u200 = icmp eq i32  %u199,45
    %u201 = or i1  %u196, %u200
    %u202 = load i32, i32* @chat
    %u203 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u202
    %u204 = load i32, i32* %u203
    %u205 = icmp eq i32  %u204,42
    %u206 = or i1  %u201, %u205
    %u207 = load i32, i32* @chat
    %u208 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u207
    %u209 = load i32, i32* %u208
    %u210 = icmp eq i32  %u209,47
    %u211 = or i1  %u206, %u210
    %u212 = load i32, i32* @chat
    %u213 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u212
    %u214 = load i32, i32* %u213
    %u215 = icmp eq i32  %u214,37
    %u216 = or i1  %u211, %u215
    %u217 = load i32, i32* @chat
    %u218 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u217
    %u219 = load i32, i32* %u218
    %u220 = icmp eq i32  %u219,94
    %u221 = or i1  %u216, %u220
    br i1 %u221, label %x33, label %x36

x33:
    %u222 = call i32 @find()
    %u223 = icmp eq i32  %u222,0
    br i1 %u223, label %x34, label %x35

x34:
    br label %x36
    br label %x35

x35:
    br label %x32

x36:
    call void @chapush(i32 45)
    br label %x37

x37:
    %u224 = load i32, i32* @i
    %u225 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u224
    %u226 = load i32, i32* %u225
    %u227 = icmp eq i32  %u226,42
    br i1 %u227, label %x38, label %x44

x38:
    br label %x39

x39:
    %u228 = load i32, i32* @chat
    %u229 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u228
    %u230 = load i32, i32* %u229
    %u231 = icmp eq i32  %u230,42
    %u232 = load i32, i32* @chat
    %u233 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u232
    %u234 = load i32, i32* %u233
    %u235 = icmp eq i32  %u234,47
    %u236 = or i1  %u231, %u235
    %u237 = load i32, i32* @chat
    %u238 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u237
    %u239 = load i32, i32* %u238
    %u240 = icmp eq i32  %u239,37
    %u241 = or i1  %u236, %u240
    %u242 = load i32, i32* @chat
    %u243 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u242
    %u244 = load i32, i32* %u243
    %u245 = icmp eq i32  %u244,94
    %u246 = or i1  %u241, %u245
    br i1 %u246, label %x40, label %x43

x40:
    %u247 = call i32 @find()
    %u248 = icmp eq i32  %u247,0
    br i1 %u248, label %x41, label %x42

x41:
    br label %x43
    br label %x42

x42:
    br label %x39

x43:
    call void @chapush(i32 42)
    br label %x44

x44:
    %u249 = load i32, i32* @i
    %u250 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u249
    %u251 = load i32, i32* %u250
    %u252 = icmp eq i32  %u251,47
    br i1 %u252, label %x45, label %x51

x45:
    br label %x46

x46:
    %u253 = load i32, i32* @chat
    %u254 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u253
    %u255 = load i32, i32* %u254
    %u256 = icmp eq i32  %u255,42
    %u257 = load i32, i32* @chat
    %u258 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u257
    %u259 = load i32, i32* %u258
    %u260 = icmp eq i32  %u259,47
    %u261 = or i1  %u256, %u260
    %u262 = load i32, i32* @chat
    %u263 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u262
    %u264 = load i32, i32* %u263
    %u265 = icmp eq i32  %u264,37
    %u266 = or i1  %u261, %u265
    %u267 = load i32, i32* @chat
    %u268 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u267
    %u269 = load i32, i32* %u268
    %u270 = icmp eq i32  %u269,94
    %u271 = or i1  %u266, %u270
    br i1 %u271, label %x47, label %x50

x47:
    %u272 = call i32 @find()
    %u273 = icmp eq i32  %u272,0
    br i1 %u273, label %x48, label %x49

x48:
    br label %x50
    br label %x49

x49:
    br label %x46

x50:
    call void @chapush(i32 47)
    br label %x51

x51:
    %u274 = load i32, i32* @i
    %u275 = getelementptr [10000 x i32],[10000 x i32]*  @get, i32 0, i32  %u274
    %u276 = load i32, i32* %u275
    %u277 = icmp eq i32  %u276,37
    br i1 %u277, label %x52, label %x58

x52:
    br label %x53

x53:
    %u278 = load i32, i32* @chat
    %u279 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u278
    %u280 = load i32, i32* %u279
    %u281 = icmp eq i32  %u280,42
    %u282 = load i32, i32* @chat
    %u283 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u282
    %u284 = load i32, i32* %u283
    %u285 = icmp eq i32  %u284,47
    %u286 = or i1  %u281, %u285
    %u287 = load i32, i32* @chat
    %u288 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u287
    %u289 = load i32, i32* %u288
    %u290 = icmp eq i32  %u289,37
    %u291 = or i1  %u286, %u290
    %u292 = load i32, i32* @chat
    %u293 = getelementptr [10000 x i32],[10000 x i32]*  @chas, i32 0, i32  %u292
    %u294 = load i32, i32* %u293
    %u295 = icmp eq i32  %u294,94
    %u296 = or i1  %u291, %u295
    br i1 %u296, label %x54, label %x57

x54:
    %u297 = call i32 @find()
    %u298 = icmp eq i32  %u297,0
    br i1 %u298, label %x55, label %x56

x55:
    br label %x57
    br label %x56

x56:
    br label %x53

x57:
    call void @chapush(i32 37)
    br label %x58

x58:
    %u299 = load i32, i32* @ii
    %u300 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u299
    %u301 = load i32, i32* %u300
    store i32  32, i32* %u300
    %u302 = load i32, i32* @ii
    %u303 = add i32  %u302,  1
    store i32  %u303, i32* @ii
    %u304 = load i32, i32* @ii
    br label %x59

x59:
    %u305 = load i32, i32* @i
    %u306 = add i32  %u305,  1
    store i32  %u306, i32* @i
    %u307 = load i32, i32* @i
    br label %x11

x60:
    br label %x61

x61:
    %u308 = load i32, i32* @chat
    %u309 = icmp sgt  i32  %u308,0
    br i1 %u309, label %x62, label %x63

x62:
    %u310 = alloca i32
    %u311 = alloca i32
    %u312 = call i32 @chapop()
    store i32  %u312, i32* %u311
    %u313 = load i32, i32* @ii
    %u314 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u313
    %u315 = load i32, i32* %u314
    store i32  32, i32* %u314
    %u316 = load i32, i32* @ii
    %u317 = add i32  %u316,  1
    %u318 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u317
    %u319 = load i32, i32* %u318
    %u320 = load i32, i32* %u311
    store i32  %u320, i32* %u318
    %u321 = load i32, i32* @ii
    %u322 = add i32  %u321,  2
    store i32  %u322, i32* @ii
    %u323 = load i32, i32* @ii
    br label %x61

x63:
    %u324 = load i32, i32* @ii
    %u325 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u324
    %u326 = load i32, i32* %u325
    store i32  64, i32* %u325
    store i32  1, i32* @i
    br label %x64

x64:
    %u327 = load i32, i32* @i
    %u328 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u327
    %u329 = load i32, i32* %u328
    %u330 = icmp ne i32  %u329,64
    br i1 %u330, label %x65, label %x86

x65:
    %u331 = load i32, i32* @i
    %u332 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u331
    %u333 = load i32, i32* %u332
    %u334 = icmp eq i32  %u333,43
    %u335 = load i32, i32* @i
    %u336 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u335
    %u337 = load i32, i32* %u336
    %u338 = icmp eq i32  %u337,45
    %u339 = or i1  %u334, %u338
    %u340 = load i32, i32* @i
    %u341 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u340
    %u342 = load i32, i32* %u341
    %u343 = icmp eq i32  %u342,42
    %u344 = or i1  %u339, %u343
    %u345 = load i32, i32* @i
    %u346 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u345
    %u347 = load i32, i32* %u346
    %u348 = icmp eq i32  %u347,47
    %u349 = or i1  %u344, %u348
    %u350 = load i32, i32* @i
    %u351 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u350
    %u352 = load i32, i32* %u351
    %u353 = icmp eq i32  %u352,37
    %u354 = or i1  %u349, %u353
    %u355 = load i32, i32* @i
    %u356 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u355
    %u357 = load i32, i32* %u356
    %u358 = icmp eq i32  %u357,94
    %u359 = or i1  %u354, %u358
    br i1 %u359, label %x66, label %x79

x66:
    %u360 = alloca i32
    %u361 = alloca i32
    %u362 = call i32 @intpop()
    store i32  %u362, i32* %u361
    %u363 = alloca i32
    %u364 = alloca i32
    %u365 = call i32 @intpop()
    store i32  %u365, i32* %u364
    %u366 = alloca i32
    %u367 = load i32, i32* @i
    %u368 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u367
    %u369 = load i32, i32* %u368
    %u370 = icmp eq i32  %u369,43
    br i1 %u370, label %x67, label %x68

x67:
    %u371 = load i32, i32* %u364
    %u372 = load i32, i32* %u361
    %u373 = add i32  %u372,  %u371
    store i32  %u373, i32* %u366
    br label %x68

x68:
    %u374 = load i32, i32* @i
    %u375 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u374
    %u376 = load i32, i32* %u375
    %u377 = icmp eq i32  %u376,45
    br i1 %u377, label %x69, label %x70

x69:
    %u378 = load i32, i32* %u361
    %u379 = load i32, i32* %u364
    %u380 = sub i32  %u379,  %u378
    store i32  %u380, i32* %u366
    br label %x70

x70:
    %u381 = load i32, i32* @i
    %u382 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u381
    %u383 = load i32, i32* %u382
    %u384 = icmp eq i32  %u383,42
    br i1 %u384, label %x71, label %x72

x71:
    %u385 = load i32, i32* %u364
    %u386 = load i32, i32* %u361
    %u387 = mul i32  %u386,  %u385
    store i32  %u387, i32* %u366
    br label %x72

x72:
    %u388 = load i32, i32* @i
    %u389 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u388
    %u390 = load i32, i32* %u389
    %u391 = icmp eq i32  %u390,47
    br i1 %u391, label %x73, label %x74

x73:
    %u392 = load i32, i32* %u361
    %u393 = load i32, i32* %u364
    %u394 = sdiv i32  %u393,  %u392
    store i32  %u394, i32* %u366
    br label %x74

x74:
    %u395 = load i32, i32* @i
    %u396 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u395
    %u397 = load i32, i32* %u396
    %u398 = icmp eq i32  %u397,37
    br i1 %u398, label %x75, label %x76

x75:
    %u399 = load i32, i32* %u361
    %u400 = load i32, i32* %u364
    %u401 = srem i32  %u400,  %u399
    store i32  %u401, i32* %u366
    br label %x76

x76:
    %u402 = load i32, i32* @i
    %u403 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u402
    %u404 = load i32, i32* %u403
    %u405 = icmp eq i32  %u404,94
    br i1 %u405, label %x77, label %x78

x77:
    %u406 = load i32, i32* %u364
    %u407 = load i32, i32* %u361
    %u408 = call i32 @power(i32  %u406, i32  %u407)
    store i32  %u408, i32* %u366
    br label %x78

x78:
    %u409 = load i32, i32* %u366
    call void @intpush(i32  %u409)
    br label %x85

x79:
    %u410 = load i32, i32* @i
    %u411 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u410
    %u412 = load i32, i32* %u411
    %u413 = icmp ne i32  %u412,32
    br i1 %u413, label %x80, label %x84

x80:
    %u414 = load i32, i32* @i
    %u415 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u414
    %u416 = load i32, i32* %u415
    %u417 = sub i32  %u416,  48
    call void @intpush(i32  %u417)
    store i32  1, i32* @ii
    br label %x81

x81:
    %u418 = load i32, i32* @ii
    %u419 = load i32, i32* @i
    %u420 = add i32  %u419,  %u418
    %u421 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u420
    %u422 = load i32, i32* %u421
    %u423 = icmp ne i32  %u422,32
    br i1 %u423, label %x82, label %x83

x82:
    %u424 = load i32, i32* @ii
    %u425 = load i32, i32* @i
    %u426 = add i32  %u425,  %u424
    %u427 = getelementptr [10000 x i32],[10000 x i32]*  @get2, i32 0, i32  %u426
    %u428 = load i32, i32* %u427
    %u429 = sub i32  %u428,  48
    call void @intadd(i32  %u429)
    %u430 = load i32, i32* @ii
    %u431 = add i32  %u430,  1
    store i32  %u431, i32* @ii
    %u432 = load i32, i32* @ii
    br label %x81

x83:
    %u433 = load i32, i32* @ii
    %u434 = load i32, i32* @i
    %u435 = add i32  %u434,  %u433
    %u436 = sub i32  %u435,  1
    store i32  %u436, i32* @i
    %u437 = load i32, i32* @i
    br label %x84

x84:
    br label %x85

x85:
    %u438 = load i32, i32* @i
    %u439 = add i32  %u438,  1
    store i32  %u439, i32* @i
    %u440 = load i32, i32* @i
    br label %x64

x86:
    %u441 = getelementptr [10000 x i32],[10000 x i32]*  @ints, i32 0, i32 1
    %u442 = load i32, i32* %u441
    call void @putint(i32  %u442)
    ret i32  0
}
