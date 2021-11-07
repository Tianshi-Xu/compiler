import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Stack;

import static java.lang.System.*;

public class GrammarAnalyze {
    private final WordAnalyze wordAnalyze = new WordAnalyze();
    private ArrayList<TokenTrap> tokens;
    private final Stack<StackNumEle> stackNum;
    private final Stack<Tokens> stackOp;
    private final short[][] priority;
    private final HashMap<String, Var> vars;  //保存当前已经出现过的变量，对应有寄存器的值
    private final HashMap<String, Num> consts; //保存当前已经出现过的常量，及对应的值
    private TokenTrap tokenTrap;
    private Tokens token;
    private final ArrayList<CodeBlock> codeBlocks = new ArrayList<>();
    private int block_idx=0;
    private int idx_t=0;
    private final int numExp=11;
    private int register=1;
    private int par_flag_l=0;
    private int par_flag_r=0;
    public GrammarAnalyze(){
        stackNum = new Stack<>();
        stackOp = new Stack<>();
        vars = new HashMap<>();
        consts = new HashMap<>();
        //0是小于，1是大于，-1是相等，-2是错误
        priority = new short[][]{
                {1,1,0,0,0,0,0,0,0,1,0,0},{1,1,0,0,0,0,0,0,0,1,0,0},
                {1,1,0,0,0,1,1,1,0,1,0,0},{1,1,0,0,0,1,1,1,0,1,0,0},
                {1,1,0,0,0,1,1,1,0,1,0,0},
                {1,1,0,0,0,1,1,1,0,1,0,0},{1,1,0,0,0,1,1,1,0,1,0,0},
                {1,1,0,0,0,1,1,1,0,1,0,0},{0,0,0,0,0,0,0,0,0,-1,0,0},
                {1,1,-2,-2,1,1,1,-2,1,-2,-2},{1,1,-2,-2,1,1,1,-2,1,-2,-2},
                {1,1,-2,-2,1,1,1,-2,1,-2,-2},
        };
    }
    public void analyze(String path) throws Exception {
        wordAnalyze.readFile(path);
        wordAnalyze.analyze();
        tokens = wordAnalyze.getTokens();
        tokens.add(new TokenTrap(Tokens.END,""));
        codeBlocks.add(new CodeBlock("x0",new StringBuffer()));
        codeBlocks.get(0).getResult().append("declare i32 @getint()\n" +"declare void @putint(i32)\n"+"declare i32 @getch()\n" +"declare void @putch(i32)\n");
        try {
            FuncDef();
        }
        catch (Exception e){
            error();
        }
    }
    public void FuncDef(){
        getSym();
        FuncType();
        IdentMain();
        if(token!=Tokens.LPar){
            error();
        }
        codeBlocks.get(block_idx).getResult().append('(');
//////        System.out.print("(");
        getSym();
        if(token!=Tokens.RPar){
            error();
        }
        codeBlocks.get(block_idx).getResult().append(")");
//////        System.out.print(") ");
        getSym();
        Block();
        if(token!=Tokens.END){
            error();
        }
    }
    public void FuncType(){
        if(token!=Tokens.INT){
            error();
        }
        codeBlocks.get(block_idx).getResult().append("define dso_local i32 ");
        getSym();
    }
    public void IdentMain(){
        if(token!=Tokens.MAIN){
            error();
        }
        codeBlocks.get(block_idx).getResult().append("@main");
        getSym();
    }
    public void Block(){
        if(token!=Tokens.LBrace){
            error();
        }
        if(par_flag_l==0){
            codeBlocks.get(block_idx).getResult().append("{\n");
            par_flag_l=1;
        }

        getSym();

        BlockItem();

        while (token!=Tokens.RBrace){
            BlockItem();
        }
////        out.println("OK2");
//        if(par_flag_r==0) {
//            codeBlocks.get(block_idx).getResult().append(Util.TAB).append("}");
//            par_flag_r=1;
//        }
        getSym();
    }
    public TokenTrap Ident(){
        TokenTrap tmp = new TokenTrap(tokenTrap);
        if(token!=Tokens.Ident){
            error();
        }
        getSym();
        return tmp;
    }
    public TokenTrap LVal(){
        return Ident();
    }
    public void BType(){
        if(token!=Tokens.INT){
            error();
        }
        getSym();
    }
    public StackNumEle Cond(){
        return LOrExp();
    }
    public StackNumEle LOrExp(){
        StackNumEle tmp1 = LAndExp();
        while (token==Tokens.OR){
            getSym();
//            out.println(token);
            StackNumEle tmp2 = LAndExp();
//            out.println("OK");
            String x1 = getNumString(tmp1);
            String x2 = getNumString(tmp2);
            codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = or i1 ").append(x1).append(",").append(x2).append("\n");
            Var tmp_var = new Var("i1");
            tmp_var.setLoad_register(register,block_idx);
            tmp1 = new StackNumEle(false,tmp_var);
            register++;
        }
        return tmp1;
    }
    public StackNumEle LAndExp(){
        StackNumEle tmp1 = EqExp();
        while (token==Tokens.AND){
            getSym();
            StackNumEle tmp2 = EqExp();
            String x1 = getNumString(tmp1);
            String x2 = getNumString(tmp2);
            codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = and i1 ").append(x1).append(",").append(x2).append("\n");
            Var tmp_var = new Var("i1");
            tmp_var.setLoad_register(register,block_idx);
            tmp1 = new StackNumEle(false,tmp_var);
            register++;
        }
        return tmp1;
    }
    public StackNumEle EqExp(){
        if(!isExp()){
            error();
        }
        StackNumEle tmp1 = RelExp();
        if(token==Tokens.Eq||token==Tokens.NEq){
            Tokens tmp_token = token;
            getSym();
            if(!isExp()){
                error();
            }
            StackNumEle tmp2 = Exp(1);
            String op;
            if(tmp_token==Tokens.Eq){
                op = "eq";
            }
            else {
                op = "ne";
            }
            //判断保证两端为int 32
            tmp1 = getCmpResult(tmp1, tmp2, op);
        }
        return tmp1;
    }

    private StackNumEle getCmpResult(StackNumEle tmp1, StackNumEle tmp2, String op) {
        String x1 = getNumString32(tmp1);
        String x2 = getNumString32(tmp2);
        codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = ").append("icmp ").append(op)
                .append(" i32 ").append(x1).append(",").append(x2).append("\n");
        Var tmp_var = new Var("i1");
        tmp_var.setLoad_register(register,block_idx);
        tmp1 = new StackNumEle(false,tmp_var);
        register++;
        return tmp1;
    }

    public StackNumEle RelExp(){
        if(!isExp()){
            error();
        }
        StackNumEle tmp1 = Exp(1);
        if(isCompare()){
            Tokens tmp_token = token;
            getSym();
            if(!isExp()){
                error();
            }
            StackNumEle tmp2 = Exp(1);
            String op;
            switch (tmp_token){
                case GT:{
                    op="sgt ";
                    break;
                }
                case LT:{
                    op="slt ";
                    break;
                }
                case Ge:{
                    op="sge ";
                    break;
                }
                case Le:{
                    op="sle ";
                    break;
                }
                default:{
                    op="???";
                }
            }
            //判断保证两端为int 32
            tmp1 = getCmpResult(tmp1, tmp2, op);
        }
        return tmp1;
    }
    public void Stmt(){
        if(token==Tokens.RETURN){
            getSym();
            if(isExp()){
                StackNumEle tmp = Exp(0);
                if(token!=Tokens.Semicolon){
                    error();
                }
                String x = getNumString(tmp);
                codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("ret ").append("i32 ").append(x);
                getSym();
            }
            else {
                error();
            }
        }
        else if(token==Tokens.Ident){
            if(tokens.get(idx_t).getToken()==Tokens.Assign){
                TokenTrap tmp1 = LVal();
                Var var = vars.get(tmp1.getIdentName());
                if(var == null){
                    error();
                }
                getSym();
                StackNumEle tmp2 = Exp(0);
                storeRegister(var,tmp2);
                if (var.getLoad_register(block_idx)!=-1){
                    loadRegister(var);
                }
            }
            else{
                Exp(0);
            }
            if(token!=Tokens.Semicolon){
                error();
            }
            getSym();
        }
        //注意EXP可有可无
        else if(isExp()){
            Exp(0);
            if(token!=Tokens.Semicolon){
                error();
            }
            getSym();
        }
        else if(token==Tokens.LBrace){
            Block();
        }
        else if(token==Tokens.IF){
            getSym();
            if(token!=Tokens.LPar){
                error();
            }
            getSym();
            StackNumEle cond = Cond();
            if(token!=Tokens.RPar){
                error();
            }
            getSym();
            int l1,l2,r1=-1,r2=-1;
            block_idx++;
            l1 = block_idx;
            codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
            Stmt();
            l2 = block_idx;
            if (token==Tokens.ELSE){
                getSym();
                block_idx++;
                r1=block_idx;
                codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
                Stmt();
                r2 = block_idx;
            }
            block_idx++;
            codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
            if(r1==-1){
                r1 = block_idx;
            }
            if(cond.isNumber()){
                if (cond.getNum().getType().equals("i32")){
                    codeBlocks.get(l1-1).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = trunc i32 ").append(cond.getNum().getNumber()).
                            append(" to i1").append("\n");
                    codeBlocks.get(l1 - 1).getResult().append(CompileUtil.TAB).append("br i1 %u").append(register).
                            append(",label %x").append(l1).append(", label %x").append(r1).append("\n");
                    register++;
                }
                else {
                    codeBlocks.get(l1 - 1).getResult().append(CompileUtil.TAB).append("br i1 ").append(cond.getNum().getNumber()).
                            append(",label %x").append(l1).append(", label %x").append(r1).append("\n");
                }
            }
            else {
                int tmp_idx = block_idx;
                block_idx=l1-1;
                String x1 = getNumString(cond);
                block_idx=tmp_idx;
                if(cond.getVar().getType().equals("i32")){
                    codeBlocks.get(l1-1).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = trunc i32 ").append(x1).
                            append(" to i1").append("\n");
                    codeBlocks.get(l1 - 1).getResult().append(CompileUtil.TAB).append("br i1 %u").append(register).
                            append(",label %x").append(l1).append(", label %x").append(r1).append("\n");
                    register++;
                }
                else {
                    codeBlocks.get(l1 - 1).getResult().append(CompileUtil.TAB).append("br i1").append(x1).
                            append(",label %x").append(l1).append(", label %x").append(r1).append("\n");
                }
            }
            codeBlocks.get(l2).getResult().append(CompileUtil.TAB).append("br label %x").append(block_idx).append("\n");
            if(r2!=-1){
                codeBlocks.get(r2).getResult().append(CompileUtil.TAB).append("br label %x").append(block_idx).append("\n");
            }
        }
        else {
            error();
        }
    }
    public StackNumEle ConstInitVal(){
        return ConstExp();
    }
    public void ConstDef(){
        TokenTrap tmp1 = Ident();
        if(consts.get(tmp1.getIdentName())!=null||vars.get(tmp1.getIdentName())!=null){
            error();
        }
        else if(token!=Tokens.Assign){
            error();
        }

        getSym();
        StackNumEle tmp2 = ConstInitVal();
        consts.put(tmp1.getIdentName(), tmp2.getNum());
    }
    public void ConstDecl(){
        getSym();
        BType();
        ConstDef();
        //0或多次
        while (token==Tokens.Comma){
            getSym();
            ConstDef();
        }
        if(token!=Tokens.Semicolon){
            error();
        }
        getSym();
    }
    public StackNumEle InitVal(){
        return Exp(0);
    }
    public void VarDef(){
        TokenTrap tmp1 = Ident();
        if(consts.get(tmp1.getIdentName())!=null||vars.get(tmp1.getIdentName())!=null){
            error();
        }
        //先声明变量
        codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = alloca i32").append("\n");
        Var tmp_var = new Var("i32");
        tmp_var.setTrue_register(register);
        vars.put(tmp1.getIdentName(),tmp_var);
        register++;
        if(token==Tokens.Assign){
            getSym();
            StackNumEle tmp2 = InitVal();
////            out.println("OK4");
            //给变量赋值
            storeRegister(tmp_var,tmp2);
        }
    }
    public void VarDecl(){
        BType();
////        out.println("---");
        VarDef();
        //0次或多次

        while (token==Tokens.Comma){

            getSym();
            VarDef();
        }
        if(token!=Tokens.Semicolon){
            error();
        }
        getSym();
    }
    public void BlockItem(){

        if(token==Tokens.CONST){
//////            out.println("OK0");
            ConstDecl();
        }
        else if(token==Tokens.INT){
//////            out.println("OK2");
            VarDecl();
////            out.println("OK3");
        }
        else {
            Stmt();
        }

    }
    public boolean isExp(){
        return token == Tokens.LPar || token == Tokens.UnaryOpAdd || token == Tokens.UnaryOpDec || token == Tokens.NUMBER || token == Tokens.Ident||token==Tokens.NOT||isFunc();
    }
    public boolean isFunc(){
        return token==Tokens.Getch||token==Tokens.Getint||token==Tokens.Putch||token==Tokens.Putint;
    }
    public int handleFunc(){
        Tokens tmp_token = token;
        StringBuilder param = new StringBuilder();
        getSym();
        if(token!=Tokens.LPar){
            error();
        }
        getSym();
        if(tmp_token==Tokens.Getch||tmp_token==Tokens.Getint){
            if(token!=Tokens.RPar){
                error();
            }
        }
        else if(tmp_token==Tokens.Putch||tmp_token==Tokens.Putint){
            if(token==Tokens.RPar){
                error();
            }
            else {
                StackNumEle par = Exp(1);
                param.append("i32 ").append(getNumString(par));
            }
        }
        while (token!=Tokens.RPar){
            error();
            if(token!=Tokens.Semicolon){
                error();
            }
            else {
                StackNumEle par = Exp(1);
                param.append(", i32 ").append(getNumString(par));
            }
        }
        switch (tmp_token){
            case Getint:{
                codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = call i32 @getint(").append(param).append(")").append("\n");
                Var tmp_var = new Var("i32");
                tmp_var.setLoad_register(register,block_idx);
                stackNum.push(new StackNumEle(false,tmp_var));
                register++;
                return 0;
            }
            case Getch:{
                codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = call i32 @getch(").append(param).append(")").append("\n");
                Var tmp_var = new Var("i32");
                tmp_var.setLoad_register(register,block_idx);
                stackNum.push(new StackNumEle(false,tmp_var));
                register++;
                return 0;
            }
            case Putint:{
                codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("call void @putint(").append(param).append(")").append("\n");
                return 1;
            }
            case Putch:{
                codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("call void @putch(").append(param).append(")").append("\n");
                return 1;
            }
            default:error();return -1;
        }
    }
    public boolean ExpOver(){
        return token==Tokens.Semicolon||token==Tokens.Comma||token==Tokens.Ge||token==Tokens.GT||token==Tokens.Le
                ||token==Tokens.LT||token==Tokens.Eq||token==Tokens.NEq||token==Tokens.AND||token==Tokens.OR;
    }
    public StackNumEle Exp(int type){
        int count=1;
        Tokens last_token;
//        out.println("EXP-----------");
//        out.println(token);
        if(type==1){
            if(token==Tokens.LPar){
                count=count+1;
            }
            else if(token==Tokens.RPar){
                return stackNum.pop();
            }
        }
        if(token==Tokens.NUMBER){
            stackNum.push(new StackNumEle(true,new Num(tokenTrap.getNumber(),"i32")));
        }
        else if(token== Tokens.Ident){
            pushIdent();
        }
        else if(isFunc()){
            int x = handleFunc();
            if(x==1){
                getSym();
                return null;
            }
        }
        else if(token.ordinal()>numExp){
            error();
        }
        else {
            stackOp.push(token);
        }
        last_token=token;
        getSym();
        while (idx_t< tokens.size()&&!ExpOver()){
            if(type==1&&last_token!=token){
                if(token==Tokens.LPar){
                    count=count+1;
                }
                else if(token==Tokens.RPar){
                    count=count-1;
                    if(count==0){
                        break;
                    }
                }
            }
            last_token=token;
            if(token==Tokens.NUMBER){
                stackNum.push(new StackNumEle(true,new Num(tokenTrap.getNumber(),"i32")));
                getSym();
            }
            else if(token== Tokens.Ident){
                pushIdent();
                getSym();
//                out.println("OK2");
            }
            else if(isFunc()){
                handleFunc();
            }
            else if(token.ordinal()>numExp){
                error();
            }
            else {
                if(stackOp.empty()) {
                    stackOp.push(token);
                    getSym();
                }
                else {
                    int x =priority[stackOp.peek().ordinal()][token.ordinal()];
                    //0是小于，1是大于，-1是相等，-2是错误
                    if(x==0){
                        stackOp.push(token);
                        getSym();
                    }
                    else if(x==-1){
                        if(stackNum.empty()){
                            error();
                        }
                        else {
                            stackOp.pop();
                        }
                        getSym();
                    }
                    else if(x==1){
                        guiYue();
                    }
                    else {
                        error();
                    }
                }
            }

        }
        while (!stackOp.empty()){
            guiYue();
        }
        if (stackNum.size()!=1){
            error();
        }
        return stackNum.pop();
    }
    public StackNumEle ConstExp(){

        if(token==Tokens.NUMBER){
            stackNum.push(new StackNumEle(true,new Num(tokenTrap.getNumber(),"i32")));
        }
        else if(token== Tokens.Ident){
            Num tmp = consts.get(tokenTrap.getIdentName());
            if(tmp == null){
                error();
            }
//            out.println(tmp);
            stackNum.push(new StackNumEle(true,tmp));
        }
//        else if(isFunc()){
//            handleFunc();
//        }
        else if(token.ordinal()>numExp){
            error();
        }
        else {
            stackOp.push(token);
        }
        getSym();
        while (idx_t< tokens.size()&&token!=Tokens.Semicolon&&token!=Tokens.Comma){
//////            out.println(token);
            if(token==Tokens.NUMBER){
                stackNum.push(new StackNumEle(true,new Num(tokenTrap.getNumber(),"i32")));
                getSym();
            }
            else if(token== Tokens.Ident){
                Num tmp = consts.get(tokenTrap.getIdentName());
                if(tmp == null){
                    error();
                }
                stackNum.push(new StackNumEle(true,tmp));
            }
//            else if(isFunc()){
//                handleFunc();
//            }
            else if(token.ordinal()>numExp){
                error();
            }
            else {
                if(stackOp.empty()) {
                    stackOp.push(token);
                    getSym();
                }
                else {
                    int x =priority[stackOp.peek().ordinal()][token.ordinal()];
                    if(x==0){
                        stackOp.push(token);
                        getSym();
                    }
                    else if(x==-1){
                        if(stackNum.empty()){
                            error();
                        }
                        else {
                            stackOp.pop();
                        }
                        getSym();
                    }
                    else if(x==1){
                        constGuiYue();
                    }
                    else {
                        error();
                    }
                }
            }
        }
        while (!stackOp.empty()){
            constGuiYue();
        }
        if (stackNum.size()!=1){
            error();
        }
        return stackNum.pop();
    }
    private void guiYue() {
        StackNumEle tmp1;
        String x1,x2;
        switch (stackOp.pop()){
            case BinAdd:{
                calBinOp("add");
                break;
            }
            case BinDec:{
                calBinOp("sub");
                break;
            }
            case Mul:{
                calBinOp("mul");
                break;
            }
            case Div:{
                calBinOp("sdiv");
                break;
            }
            case Mod:{
                calBinOp("srem");
                break;
            }
            case UnaryOpAdd:{
                if (stackNum.size()<1){
                    error();
                }
                break;
            }
            case UnaryOpDec:{
                if (stackNum.size()<1){
                    error();
                }
                else {
                    tmp1 = stackNum.pop();
                    if(tmp1.isNumber()){
                        Num num = tmp1.getNum();
                        num.setNumber(-num.getNumber());
                        stackNum.push(tmp1);
                    }
                    else{
                        x1 = getNumString(tmp1);
                        Var tmp_var = tmp1.getVar();
                        if(tmp_var.getType().equals("i1")){
                            codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = zext i1 ").append(x1).append(" to i32").append("\n");
                            x1 = "%u"+register;
                            register++;
                        }
                        codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = ").append("sub ").append("i32 0, ").append(x1).append("\n");
                        tmp_var = new Var("i32");
                        tmp_var.setLoad_register(register,block_idx);
                        stackNum.push(new StackNumEle(false,tmp_var));
                        register++;
                    }
                }
                break;
            }
            case NOT:{
                if (stackNum.size()<1){
                    error();
                }
                else {
                    tmp1 = stackNum.pop();
                    if(tmp1.isNumber()){
                        Num num = new Num(tmp1.getNum().getNumber()==0?1:0,"i1");
                        stackNum.push(new StackNumEle(true,num));
                    }
                    else {
                        x1 = getNumString(tmp1);
                        codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = ").append("icmp eq ")
                                .append(tmp1.getVar().getType()).append(" ").append(x1).append(", 0").append("\n");
                        Var tmp_var = new Var("i1");
                        tmp_var.setLoad_register(register,block_idx);
                        stackNum.push(new StackNumEle(false,tmp_var));
                        register++;
                    }
                }
                break;
            }
            default:
                error();
        }
    }
    private void constGuiYue() {
        StackNumEle tmp1;
        StackNumEle tmp2;
        switch (stackOp.pop()){
            case BinAdd:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    tmp1 = stackNum.pop();
                    tmp2 = stackNum.pop();
                    tmp1.getNum().setNumber(tmp2.getNum().getNumber()+tmp1.getNum().getNumber());
                    stackNum.push(tmp1);
                }
                break;
            }
            case BinDec:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    tmp1 = stackNum.pop();
                    tmp2 = stackNum.pop();
                    tmp1.getNum().setNumber(tmp2.getNum().getNumber()-tmp1.getNum().getNumber());
                    stackNum.push(tmp1);
                }
                break;
            }
            case Mul:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    tmp1 = stackNum.pop();
                    tmp2 = stackNum.pop();
                    tmp1.getNum().setNumber(tmp2.getNum().getNumber()*tmp1.getNum().getNumber());
                    stackNum.push(tmp1);
                }
                break;
            }
            case Div:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    tmp1 = stackNum.pop();
                    tmp2 = stackNum.pop();
                    tmp1.getNum().setNumber(tmp2.getNum().getNumber()/tmp1.getNum().getNumber());
                    stackNum.push(tmp1);
                }
                break;
            }
            case Mod:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    tmp1 = stackNum.pop();
                    tmp2 = stackNum.pop();
                    tmp1.getNum().setNumber(tmp2.getNum().getNumber()%tmp1.getNum().getNumber());
                    stackNum.push(tmp1);
                }
                break;
            }
            case UnaryOpAdd:{
                if (stackNum.size()<1){
                    error();
                }
                break;
            }
            case UnaryOpDec:{
                if (stackNum.size()<1){
                    error();
                }
                else {
                    tmp1 = stackNum.pop();
                    tmp1.getNum().setNumber(-tmp1.getNum().getNumber());
                    stackNum.push(tmp1);
                }
                break;
            }
            default:
                error();
        }
    }
    private void pushIdent() {
        StackNumEle stackNumEle;
        Num tmp = consts.get(tokenTrap.getIdentName());
        if(tmp == null){
            Var var = vars.get(tokenTrap.getIdentName());
            if(var==null){
                error();
            }
            stackNumEle = new StackNumEle(false,var);
        }
        else {
            stackNumEle = new StackNumEle(true,tmp);
        }
        stackNum.push(stackNumEle);
    }
    //从StackNumEle中提取出变量值或寄存器值
    private String getNumString32(StackNumEle tmp1){
        String x1;
        if (tmp1.isNumber()){
            x1 = ""+tmp1.getNum().getNumber();
        }
        else {
            Var var = tmp1.getVar();
            x1 = getNumString(tmp1);
            if(var.getType().equals("i1")){
                codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = zext i1 ").append(x1).append(" to i32").append("\n");
                x1 = " %u"+register;
                register++;
            }
            else {
                x1 = " %u"+var.getLoad_register(block_idx);
            }
        }
        return x1;
    }
    private String getNumString(StackNumEle tmp1) {
        String x1;
        Var var1;
        if(tmp1.isNumber()){
            x1 = " "+tmp1.getNum().getNumber();
        }
        else {
            var1 = tmp1.getVar();
            if (var1.getLoad_register(block_idx)==-1){
                loadRegister(var1);
            }
            x1 = " %u"+var1.getLoad_register(block_idx);
        }
        return x1;
    }
    //规约中的一步操作，根据运算符而略微不同
    private void calBinOp(String op){
        StackNumEle tmp1;
        StackNumEle tmp2;
        String x1,x2;
        if (stackNum.size()<2){
            error();
        }
        else {
            tmp1 = stackNum.pop();
            tmp2 = stackNum.pop();
            x1 = getNumString(tmp1);
            x2 = getNumString(tmp2);
            codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = ").append(op).append(" ").
                    append("i32 ").append(x2).append(", ").append(x1).append("\n");
            Var tmp_var = new Var("i32");
            tmp_var.setLoad_register(register,block_idx);
            stackNum.push(new StackNumEle(false,tmp_var));
            register++;
        }
    }

    //中间代码生成系列：为变量load一个新的寄存器
    private void loadRegister(Var var){
        var.setLoad_register(register,block_idx);
        codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = load ").
                append(var.getType()).append(", ").append(var.getType()).
                append("* %u").append(var.getTrue_register()).append("\n");
        register++;
    }
    //中间代码生成系列：为寄存器store一个新的值
    private void storeRegister(Var var,StackNumEle tmp2){

        String x = getNumString(tmp2);
        codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("store i32 ").append(x).append(", ").append(var.getType()).append("* %u").append(var.getTrue_register()).append("\n");
    }
    public boolean isCompare(){
        return token==Tokens.GT ||token==Tokens.Ge||token==Tokens.LT ||token==Tokens.Le;
    }

    public void error(){
        exit(1);
    }
    public void getSym(){
        if(idx_t==tokens.size()){
            error();
        }
        tokenTrap = tokens.get(idx_t++);
        token = tokenTrap.getToken();
    }
    public static void main(String[] args) throws Exception {
        GrammarAnalyze grammarAnalyze = new GrammarAnalyze();
        grammarAnalyze.analyze(args[0]);
        BufferedWriter out = new BufferedWriter(new FileWriter(args[1]));
////        System.out.println(String.valueOf(grammarAnalyze.result));
        ArrayList<CodeBlock> codes = grammarAnalyze.codeBlocks;
        out.write(String.valueOf(codes.get(0).getResult()));
        for(int i=1;i<codes.size();i++){
            CodeBlock codeBlock = codes.get(i);
            out.write("\n"+codeBlock.getRegister()+":\n");
            out.write(String.valueOf(codeBlock.getResult()));
        }
        out.write("\n}");

        out.close();
    }
}
