declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
@a1 = dso_local global i32 1
@a2 = dso_local global i32 2
@a3 = dso_local global i32 3
@a4 = dso_local global i32 4
@a5 = dso_local global i32 5
@a6 = dso_local global i32 6
@a7 = dso_local global i32 7
@a8 = dso_local global i32 8
@a9 = dso_local global i32 9
@a10 = dso_local global i32 10
@a11 = dso_local global i32 11
@a12 = dso_local global i32 12
@a13 = dso_local global i32 13
@a14 = dso_local global i32 14
@a15 = dso_local global i32 15
@a16 = dso_local global i32 16
@a17 = dso_local global i32 1
@a18 = dso_local global i32 2
@a19 = dso_local global i32 3
@a20 = dso_local global i32 4
@a21 = dso_local global i32 5
@a22 = dso_local global i32 6
@a23 = dso_local global i32 7
@a24 = dso_local global i32 8
@a25 = dso_local global i32 9
@a26 = dso_local global i32 10
@a27 = dso_local global i32 11
@a28 = dso_local global i32 12
@a29 = dso_local global i32 13
@a30 = dso_local global i32 14
@a31 = dso_local global i32 15
@a32 = dso_local global i32 16
define dso_local i32 @main(){
    %u1 = alloca i32
    %u2 = alloca i32
    %u3 = alloca i32
    %u4 = call i32 @getint()
    store i32  %u4, i32* %u2
    %u5 = mul i32  2,  9
    %u6 = load i32, i32* %u2
    %u7 = add i32  %u6,  %u5
    store i32  %u7, i32* %u3
    %u8 = load i32, i32* %u3
    %u9 = add i32  %u6,  %u8
    store i32  %u9, i32* %u1
    %u10 = alloca i32
    %u11 = alloca i32
    %u12 = alloca i32
    %u13 = alloca i32
    %u14 = alloca i32
    %u15 = alloca i32
    %u16 = alloca i32
    %u17 = alloca i32
    %u18 = alloca i32
    %u19 = alloca i32
    %u20 = alloca i32
    %u21 = alloca i32
    %u22 = alloca i32
    %u23 = alloca i32
    %u24 = alloca i32
    %u25 = alloca i32
    %u26 = alloca i32
    %u27 = alloca i32
    %u28 = alloca i32
    %u29 = alloca i32
    %u30 = alloca i32
    %u31 = alloca i32
    %u32 = alloca i32
    %u33 = alloca i32
    %u34 = alloca i32
    %u35 = alloca i32
    %u36 = alloca i32
    %u37 = alloca i32
    %u38 = alloca i32
    %u39 = alloca i32
    %u40 = alloca i32
    %u41 = alloca i32
    %u42 = alloca i32
    %u43 = alloca i32
    %u44 = alloca i32
    %u45 = alloca i32
    %u46 = call i32 @getint()
    store i32  %u46, i32* %u10
    %u47 = call i32 @getint()
    store i32  %u47, i32* %u11
    %u48 = call i32 @getint()
    store i32  %u48, i32* %u12
    %u49 = call i32 @getint()
    store i32  %u49, i32* %u13
    %u50 = load i32, i32* %u10
    %u51 = add i32  1,  %u50
    %u52 = load i32, i32* @a1
    %u53 = add i32  %u51,  %u52
    store i32  %u53, i32* %u14
    %u54 = load i32, i32* %u11
    %u55 = add i32  2,  %u54
    %u56 = load i32, i32* @a2
    %u57 = add i32  %u55,  %u56
    store i32  %u57, i32* %u15
    %u58 = load i32, i32* %u12
    %u59 = add i32  3,  %u58
    %u60 = load i32, i32* @a3
    %u61 = add i32  %u59,  %u60
    store i32  %u61, i32* %u16
    %u62 = load i32, i32* %u13
    %u63 = add i32  4,  %u62
    %u64 = load i32, i32* @a4
    %u65 = add i32  %u63,  %u64
    store i32  %u65, i32* %u17
    %u66 = load i32, i32* %u14
    %u67 = add i32  1,  %u66
    %u68 = load i32, i32* @a5
    %u69 = add i32  %u67,  %u68
    store i32  %u69, i32* %u18
    %u70 = load i32, i32* %u15
    %u71 = add i32  2,  %u70
    %u72 = load i32, i32* @a6
    %u73 = add i32  %u71,  %u72
    store i32  %u73, i32* %u19
    %u74 = load i32, i32* %u16
    %u75 = add i32  3,  %u74
    %u76 = load i32, i32* @a7
    %u77 = add i32  %u75,  %u76
    store i32  %u77, i32* %u20
    %u78 = load i32, i32* %u17
    %u79 = add i32  4,  %u78
    %u80 = load i32, i32* @a8
    %u81 = add i32  %u79,  %u80
    store i32  %u81, i32* %u21
    %u82 = load i32, i32* %u18
    %u83 = add i32  1,  %u82
    %u84 = load i32, i32* @a9
    %u85 = add i32  %u83,  %u84
    store i32  %u85, i32* %u22
    %u86 = load i32, i32* %u19
    %u87 = add i32  2,  %u86
    %u88 = load i32, i32* @a10
    %u89 = add i32  %u87,  %u88
    store i32  %u89, i32* %u23
    %u90 = load i32, i32* %u20
    %u91 = add i32  3,  %u90
    %u92 = load i32, i32* @a11
    %u93 = add i32  %u91,  %u92
    store i32  %u93, i32* %u24
    %u94 = load i32, i32* %u21
    %u95 = add i32  4,  %u94
    %u96 = load i32, i32* @a12
    %u97 = add i32  %u95,  %u96
    store i32  %u97, i32* %u25
    %u98 = load i32, i32* %u22
    %u99 = add i32  1,  %u98
    %u100 = load i32, i32* @a13
    %u101 = add i32  %u99,  %u100
    store i32  %u101, i32* %u26
    %u102 = load i32, i32* %u23
    %u103 = add i32  2,  %u102
    %u104 = load i32, i32* @a14
    %u105 = add i32  %u103,  %u104
    store i32  %u105, i32* %u27
    %u106 = load i32, i32* %u24
    %u107 = add i32  3,  %u106
    %u108 = load i32, i32* @a15
    %u109 = add i32  %u107,  %u108
    store i32  %u109, i32* %u28
    %u110 = load i32, i32* %u25
    %u111 = add i32  4,  %u110
    %u112 = load i32, i32* @a16
    %u113 = add i32  %u111,  %u112
    store i32  %u113, i32* %u29
    %u114 = load i32, i32* %u26
    %u115 = add i32  1,  %u114
    %u116 = load i32, i32* @a17
    %u117 = add i32  %u115,  %u116
    store i32  %u117, i32* %u30
    %u118 = load i32, i32* %u27
    %u119 = add i32  2,  %u118
    %u120 = load i32, i32* @a18
    %u121 = add i32  %u119,  %u120
    store i32  %u121, i32* %u31
    %u122 = load i32, i32* %u28
    %u123 = add i32  3,  %u122
    %u124 = load i32, i32* @a19
    %u125 = add i32  %u123,  %u124
    store i32  %u125, i32* %u32
    %u126 = load i32, i32* %u29
    %u127 = add i32  4,  %u126
    %u128 = load i32, i32* @a20
    %u129 = add i32  %u127,  %u128
    store i32  %u129, i32* %u33
    %u130 = load i32, i32* %u30
    %u131 = add i32  1,  %u130
    %u132 = load i32, i32* @a21
    %u133 = add i32  %u131,  %u132
    store i32  %u133, i32* %u34
    %u134 = load i32, i32* %u31
    %u135 = add i32  2,  %u134
    %u136 = load i32, i32* @a22
    %u137 = add i32  %u135,  %u136
    store i32  %u137, i32* %u35
    %u138 = load i32, i32* %u32
    %u139 = add i32  3,  %u138
    %u140 = load i32, i32* @a23
    %u141 = add i32  %u139,  %u140
    store i32  %u141, i32* %u36
    %u142 = load i32, i32* %u33
    %u143 = add i32  4,  %u142
    %u144 = load i32, i32* @a24
    %u145 = add i32  %u143,  %u144
    store i32  %u145, i32* %u37
    %u146 = load i32, i32* %u34
    %u147 = add i32  1,  %u146
    %u148 = load i32, i32* @a25
    %u149 = add i32  %u147,  %u148
    store i32  %u149, i32* %u38
    %u150 = load i32, i32* %u35
    %u151 = add i32  2,  %u150
    %u152 = load i32, i32* @a26
    %u153 = add i32  %u151,  %u152
    store i32  %u153, i32* %u39
    %u154 = load i32, i32* %u36
    %u155 = add i32  3,  %u154
    %u156 = load i32, i32* @a27
    %u157 = add i32  %u155,  %u156
    store i32  %u157, i32* %u40
    %u158 = load i32, i32* %u37
    %u159 = add i32  4,  %u158
    %u160 = load i32, i32* @a28
    %u161 = add i32  %u159,  %u160
    store i32  %u161, i32* %u41
    %u162 = load i32, i32* %u38
    %u163 = add i32  1,  %u162
    %u164 = load i32, i32* @a29
    %u165 = add i32  %u163,  %u164
    store i32  %u165, i32* %u42
    %u166 = load i32, i32* %u39
    %u167 = add i32  2,  %u166
    %u168 = load i32, i32* @a30
    %u169 = add i32  %u167,  %u168
    store i32  %u169, i32* %u43
    %u170 = load i32, i32* %u40
    %u171 = add i32  3,  %u170
    %u172 = load i32, i32* @a31
    %u173 = add i32  %u171,  %u172
    store i32  %u173, i32* %u44
    %u174 = load i32, i32* %u41
    %u175 = add i32  4,  %u174
    %u176 = load i32, i32* @a32
    %u177 = add i32  %u175,  %u176
    store i32  %u177, i32* %u45
    %u178 = sub i32  %u6,  %u8
    %u179 = add i32  %u178,  10
    store i32  %u179, i32* %u1
    %u180 = add i32  1,  %u162
    %u181 = add i32  %u180,  %u164
    store i32  %u181, i32* %u42
    %u182 = add i32  2,  %u166
    %u183 = add i32  %u182,  %u168
    store i32  %u183, i32* %u43
    %u184 = add i32  3,  %u170
    %u185 = add i32  %u184,  %u172
    store i32  %u185, i32* %u44
    %u186 = add i32  4,  %u174
    %u187 = add i32  %u186,  %u176
    store i32  %u187, i32* %u45
    %u188 = add i32  1,  %u146
    %u189 = add i32  %u188,  %u148
    store i32  %u189, i32* %u38
    %u190 = load i32, i32* %u38
    %u191 = add i32  2,  %u150
    %u192 = add i32  %u191,  %u152
    store i32  %u192, i32* %u39
    %u193 = load i32, i32* %u39
    %u194 = add i32  3,  %u154
    %u195 = add i32  %u194,  %u156
    store i32  %u195, i32* %u40
    %u196 = load i32, i32* %u40
    %u197 = add i32  4,  %u158
    %u198 = add i32  %u197,  %u160
    store i32  %u198, i32* %u41
    %u199 = load i32, i32* %u41
    %u200 = add i32  1,  %u130
    %u201 = add i32  %u200,  %u132
    store i32  %u201, i32* %u34
    %u202 = load i32, i32* %u34
    %u203 = add i32  2,  %u134
    %u204 = add i32  %u203,  %u136
    store i32  %u204, i32* %u35
    %u205 = load i32, i32* %u35
    %u206 = add i32  3,  %u138
    %u207 = add i32  %u206,  %u140
    store i32  %u207, i32* %u36
    %u208 = load i32, i32* %u36
    %u209 = add i32  4,  %u142
    %u210 = add i32  %u209,  %u144
    store i32  %u210, i32* %u37
    %u211 = load i32, i32* %u37
    %u212 = add i32  1,  %u114
    %u213 = add i32  %u212,  %u116
    store i32  %u213, i32* %u30
    %u214 = load i32, i32* %u30
    %u215 = add i32  2,  %u118
    %u216 = add i32  %u215,  %u120
    store i32  %u216, i32* %u31
    %u217 = load i32, i32* %u31
    %u218 = add i32  3,  %u122
    %u219 = add i32  %u218,  %u124
    store i32  %u219, i32* %u32
    %u220 = load i32, i32* %u32
    %u221 = add i32  4,  %u126
    %u222 = add i32  %u221,  %u128
    store i32  %u222, i32* %u33
    %u223 = load i32, i32* %u33
    %u224 = add i32  1,  %u98
    %u225 = add i32  %u224,  %u100
    store i32  %u225, i32* %u26
    %u226 = load i32, i32* %u26
    %u227 = add i32  2,  %u102
    %u228 = add i32  %u227,  %u104
    store i32  %u228, i32* %u27
    %u229 = load i32, i32* %u27
    %u230 = add i32  3,  %u106
    %u231 = add i32  %u230,  %u108
    store i32  %u231, i32* %u28
    %u232 = load i32, i32* %u28
    %u233 = add i32  4,  %u110
    %u234 = add i32  %u233,  %u112
    store i32  %u234, i32* %u29
    %u235 = load i32, i32* %u29
    %u236 = add i32  1,  %u82
    %u237 = add i32  %u236,  %u84
    store i32  %u237, i32* %u22
    %u238 = load i32, i32* %u22
    %u239 = add i32  2,  %u86
    %u240 = add i32  %u239,  %u88
    store i32  %u240, i32* %u23
    %u241 = load i32, i32* %u23
    %u242 = add i32  3,  %u90
    %u243 = add i32  %u242,  %u92
    store i32  %u243, i32* %u24
    %u244 = load i32, i32* %u24
    %u245 = add i32  4,  %u94
    %u246 = add i32  %u245,  %u96
    store i32  %u246, i32* %u25
    %u247 = load i32, i32* %u25
    %u248 = add i32  1,  %u66
    %u249 = add i32  %u248,  %u68
    store i32  %u249, i32* %u18
    %u250 = load i32, i32* %u18
    %u251 = add i32  2,  %u70
    %u252 = add i32  %u251,  %u72
    store i32  %u252, i32* %u19
    %u253 = load i32, i32* %u19
    %u254 = add i32  3,  %u74
    %u255 = add i32  %u254,  %u76
    store i32  %u255, i32* %u20
    %u256 = load i32, i32* %u20
    %u257 = add i32  4,  %u78
    %u258 = add i32  %u257,  %u80
    store i32  %u258, i32* %u21
    %u259 = load i32, i32* %u21
    %u260 = add i32  1,  %u50
    %u261 = add i32  %u260,  %u52
    store i32  %u261, i32* %u14
    %u262 = load i32, i32* %u14
    %u263 = add i32  2,  %u54
    %u264 = add i32  %u263,  %u56
    store i32  %u264, i32* %u15
    %u265 = load i32, i32* %u15
    %u266 = add i32  3,  %u58
    %u267 = add i32  %u266,  %u60
    store i32  %u267, i32* %u16
    %u268 = load i32, i32* %u16
    %u269 = add i32  4,  %u62
    %u270 = add i32  %u269,  %u64
    store i32  %u270, i32* %u17
    %u271 = load i32, i32* %u17
    %u272 = add i32  1,  %u50
    %u273 = add i32  %u272,  %u52
    store i32  %u273, i32* %u14
    %u274 = load i32, i32* %u14
    %u275 = add i32  2,  %u54
    %u276 = add i32  %u275,  %u56
    store i32  %u276, i32* %u15
    %u277 = load i32, i32* %u15
    %u278 = add i32  3,  %u58
    %u279 = add i32  %u278,  %u60
    store i32  %u279, i32* %u16
    %u280 = load i32, i32* %u16
    %u281 = add i32  4,  %u62
    %u282 = add i32  %u281,  %u64
    store i32  %u282, i32* %u17
    %u283 = load i32, i32* %u17
    %u284 = load i32, i32* %u1
    %u285 = add i32  %u284,  %u50
    %u286 = add i32  %u285,  %u54
    %u287 = add i32  %u286,  %u58
    %u288 = add i32  %u287,  %u62
    %u289 = sub i32  %u288,  %u274
    %u290 = sub i32  %u289,  %u277
    %u291 = sub i32  %u290,  %u280
    %u292 = sub i32  %u291,  %u283
    %u293 = add i32  %u292,  %u250
    %u294 = add i32  %u293,  %u253
    %u295 = add i32  %u294,  %u256
    %u296 = add i32  %u295,  %u259
    %u297 = sub i32  %u296,  %u238
    %u298 = sub i32  %u297,  %u241
    %u299 = sub i32  %u298,  %u244
    %u300 = sub i32  %u299,  %u247
    %u301 = add i32  %u300,  %u226
    %u302 = add i32  %u301,  %u229
    %u303 = add i32  %u302,  %u232
    %u304 = add i32  %u303,  %u235
    %u305 = sub i32  %u304,  %u214
    %u306 = sub i32  %u305,  %u217
    %u307 = sub i32  %u306,  %u220
    %u308 = sub i32  %u307,  %u223
    %u309 = add i32  %u308,  %u202
    %u310 = add i32  %u309,  %u205
    %u311 = add i32  %u310,  %u208
    %u312 = add i32  %u311,  %u211
    %u313 = sub i32  %u312,  %u190
    %u314 = sub i32  %u313,  %u193
    %u315 = sub i32  %u314,  %u196
    %u316 = sub i32  %u315,  %u199
    %u317 = load i32, i32* %u42
    %u318 = add i32  %u316,  %u317
    %u319 = load i32, i32* %u43
    %u320 = add i32  %u318,  %u319
    %u321 = load i32, i32* %u44
    %u322 = add i32  %u320,  %u321
    %u323 = load i32, i32* %u45
    %u324 = add i32  %u322,  %u323
    %u325 = add i32  %u324,  %u52
    %u326 = sub i32  %u325,  %u56
    %u327 = add i32  %u326,  %u60
    %u328 = sub i32  %u327,  %u64
    %u329 = add i32  %u328,  %u68
    %u330 = sub i32  %u329,  %u72
    %u331 = add i32  %u330,  %u76
    %u332 = sub i32  %u331,  %u80
    %u333 = add i32  %u332,  %u84
    %u334 = sub i32  %u333,  %u88
    %u335 = add i32  %u334,  %u92
    %u336 = sub i32  %u335,  %u96
    %u337 = add i32  %u336,  %u100
    %u338 = sub i32  %u337,  %u104
    %u339 = add i32  %u338,  %u108
    %u340 = sub i32  %u339,  %u112
    %u341 = add i32  %u340,  %u116
    %u342 = sub i32  %u341,  %u120
    %u343 = add i32  %u342,  %u124
    %u344 = sub i32  %u343,  %u128
    %u345 = add i32  %u344,  %u132
    %u346 = sub i32  %u345,  %u136
    %u347 = add i32  %u346,  %u140
    %u348 = sub i32  %u347,  %u144
    %u349 = add i32  %u348,  %u148
    %u350 = sub i32  %u349,  %u152
    %u351 = add i32  %u350,  %u156
    %u352 = sub i32  %u351,  %u160
    %u353 = add i32  %u352,  %u164
    %u354 = sub i32  %u353,  %u168
    %u355 = add i32  %u354,  %u172
    %u356 = sub i32  %u355,  %u176
    call void @putint(i32  %u356)
    ret i32  0
}