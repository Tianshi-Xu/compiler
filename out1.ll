declare i32 @getint()
declare void @putint(i32)
declare i32 @getch()
declare void @putch(i32)
declare void @memset(i32*, i32, i32)
@TAPE_LEN = dso_local constant i32 65536
@BUFFER_LEN = dso_local constant i32 32768
@tape = dso_local global [65536 x i32] zeroinitializer
@program = dso_local global [32768 x i32] zeroinitializer
@ptr = dso_local global i32 0
define dso_local i32 @main(){
    %u1 = alloca i32    
    %u2 = alloca i32    //i
    store i32  0, i32* %u2  //i
    %u3 = alloca i32
    %u4 = alloca i32   //len
    %u5 = call i32 @getint()   //len
    store i32  %u5, i32* %u4   //len
    br label %x1

x1:
    %u6 = load i32, i32* %u2   //i
    %u7 = load i32, i32* %u4   //len
    %u8 = icmp slt  i32  %u6, %u7   //i<len?x2:x3
    br i1 %u8, label %x2, label %x3

x2:
    %u9 = load i32, i32* %u2       //i
    %u10 = getelementptr [32768 x i32],[32768 x i32]*  @program, i32 0, i32  %u9   //&program[i]
    %u11 = load i32, i32* %u10   //program[i]
    %u12 = call i32 @getch()
    store i32  %u12, i32* %u10  // program[i] = getch();
    %u13 = add i32  %u9,  1   //i+1
    store i32  %u13, i32* %u2   //i=i+1
    %u14 = load i32, i32* %u2
    br label %x1

x3:  
    %u15 = load i32, i32* %u2    //i
    %u16 = getelementptr [32768 x i32],[32768 x i32]*  @program, i32 0, i32  %u15   //&program[i]
    %u17 = load i32, i32* %u16   //program[i]
    store i32  0, i32* %u16   //program[i]=0
    %u18 = alloca i32     // cur_char 
    %u19 = alloca i32   //loop
    store i32  0, i32* %u2   //i=0
    %u20 = load i32, i32* %u2
    br label %x4

x4:
    %u21 = load i32, i32* %u2   //i
    %u22 = getelementptr [32768 x i32],[32768 x i32]*  @program, i32 0, i32  %u21    //&program[i]
    %u23 = load i32, i32* %u22   //program[i]
    %u91 = icmp ne i32  %u23, 0  //program[i]!=0?x5:x34
    br i1 %u91, label %x5, label %x34

x5:
    %u24 = load i32, i32* %u2   //i
    %u25 = getelementptr [32768 x i32],[32768 x i32]*  @program, i32 0, i32  %u24   //&program[i]
    %u26 = load i32, i32* %u25   //program[i]
    store i32  %u26, i32* %u18   //cur_char = program[i];
    %u27 = load i32, i32* %u18  //cur_char 
    %u28 = icmp eq i32  %u27,62  //cur_char==62?x6:x7
    br i1 %u28,label %x6, label %x7  

x6:
    %u29 = load i32, i32* @ptr  //ptr
    %u30 = add i32  %u29,  1   //ptr+1
    store i32  %u30, i32* @ptr   //ptr=ptr+1
    %u31 = load i32, i32* @ptr  
    br label %x33

x7:
    %u32 = load i32, i32* %u18  //cur_char
    %u33 = icmp eq i32  %u32,60   //cur_char==60?x8:x9
    br i1 %u33,label %x8, label %x9

x8:
    %u34 = load i32, i32* @ptr  //ptr
    %u35 = sub i32  %u34,  1  //ptr-1
    store i32  %u35, i32* @ptr //ptr=ptr-1
    %u36 = load i32, i32* @ptr 
    br label %x32

x9:
    %u37 = load i32, i32* %u18   //cur_char
    %u38 = icmp eq i32  %u37,43   //cur_char==43?x10:x11
    br i1 %u38,label %x10, label %x11

x10:
    %u39 = load i32, i32* @ptr  //ptr
    %u40 = getelementptr [65536 x i32],[65536 x i32]*  @tape, i32 0, i32  %u39  //&tape[ptr]
    %u41 = load i32, i32* %u40  //tape[ptr]
    %u42 = getelementptr [65536 x i32],[65536 x i32]*  @tape, i32 0, i32  %u39 //&tape[ptr]
    %u43 = load i32, i32* %u42   //tape[ptr]
    %u44 = add i32  %u43,  1  //tape[ptr]+1
    store i32  %u44, i32* %u40  // tape[ptr] = tape[ptr] + 1;
    br label %x31

x11:
    %u45 = load i32, i32* %u18   //cur_char
    %u46 = icmp eq i32  %u45,45    //cur_char==45?x12:x13
    br i1 %u46,label %x12, label %x13

x12:
    %u47 = load i32, i32* @ptr   //ptr
    %u48 = getelementptr [65536 x i32],[65536 x i32]*  @tape, i32 0, i32  %u47 //&tape[ptr]
    %u49 = load i32, i32* %u48  //tape[ptr]
    %u50 = getelementptr [65536 x i32],[65536 x i32]*  @tape, i32 0, i32  %u47  //&tape[ptr]
    %u51 = load i32, i32* %u50    //tape[ptr]
    %u52 = sub i32  %u51,  1    //tape[ptr]-1
    store i32  %u52, i32* %u48  //tape[ptr] = tape[ptr] - 1;
    br label %x30

x13:
    %u53 = load i32, i32* %u18  //cur_char
    %u54 = icmp eq i32  %u53,46  //cur_char==46?x14:x15
    br i1 %u54,label %x14, label %x15

x14:
    %u55 = load i32, i32* @ptr     //ptr
    %u56 = getelementptr [65536 x i32],[65536 x i32]*  @tape, i32 0, i32  %u55 //&tape[ptr]
    %u57 = load i32, i32* %u56  //tape[ptr]
    call void @putch(i32  %u57)   //putch(tape[ptr]);
    br label %x29

x15:  
    %u58 = load i32, i32* %u18   //cur_char
    %u59 = icmp eq i32  %u58,44  //cur_char==44?x16:x17
    br i1 %u59,label %x16, label %x17

x16:
    %u60 = load i32, i32* @ptr  //ptr
    %u61 = getelementptr [65536 x i32],[65536 x i32]*  @tape, i32 0, i32  %u60  //&tape[ptr]
    %u62 = load i32, i32* %u61  //tape[ptr]
    %u63 = call i32 @getch()  //getch()
    store i32  %u63, i32* %u61  //tape[ptr] = getch();
    br label %x28

x17:
    %u64 = load i32, i32* %u18   //cur_char
    %u65 = icmp eq i32  %u64,93  //%u65=cur_char==93?
    %u66 = load i32, i32* @ptr  //ptr
    %u67 = getelementptr [65536 x i32],[65536 x i32]*  @tape, i32 0, i32  %u66  //&tape[ptr]
    %u68 = load i32, i32* %u67  //tape[ptr]
    %u69 = trunc i32  %u68 to i1
    %u70 = and i1  %u65, %u69
    br i1 %u70,label %x18, label %x27

x18:
    store i32  1, i32* %u19
    br label %x19

x19:
    %u71 = load i32, i32* %u19
    %u72 = icmp sgt  i32  %u71,0
    br i1 %u72, label %x20, label %x26

x20:
    %u73 = load i32, i32* %u2
    %u74 = sub i32  %u73,  1
    store i32  %u74, i32* %u2
    %u75 = load i32, i32* %u2
    %u76 = getelementptr [32768 x i32],[32768 x i32]*  @program, i32 0, i32  %u75
    %u77 = load i32, i32* %u76
    store i32  %u77, i32* %u18
    %u78 = load i32, i32* %u18
    %u79 = icmp eq i32  %u78,91
    br i1 %u79,label %x21, label %x22

x21:
    %u80 = load i32, i32* %u19
    %u81 = sub i32  %u80,  1
    store i32  %u81, i32* %u19
    %u82 = load i32, i32* %u19
    br label %x25

x22:
    %u83 = load i32, i32* %u18
    %u84 = icmp eq i32  %u83,93
    br i1 %u84,label %x23, label %x24

x23:
    %u85 = load i32, i32* %u19
    %u86 = add i32  %u85,  1
    store i32  %u86, i32* %u19
    %u87 = load i32, i32* %u19
    br label %x24

x24:
    br label %x25

x25:
    br label %x19

x26:
    br label %x27

x27:
    br label %x28

x28:
    br label %x29

x29:
    br label %x30

x30:
    br label %x31

x31:
    br label %x32

x32:
    br label %x33

x33:
    %u88 = load i32, i32* %u2   //i
    %u89 = add i32  %u88,  1   //i+1
    store i32  %u89, i32* %u2   //i=i+1
    %u90 = load i32, i32* %u2   //i
    br label %x4

x34:
    ret i32  0
}