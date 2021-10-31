
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Stack;

import static java.lang.System.*;

public class GrammarAnalyze {
    private WordAnalyze wordAnalyze = new WordAnalyze();
    private ArrayList<TokenTrap> tokens;
    private final Stack<StackNumEle> stackNum;
    private final Stack<Tokens> stackOp;
    private final short[][] priority;
    private final HashMap<String, Var> vars;  //保存当前已经出现过的变量，对应有寄存器的值
    private final HashMap<String,Integer> consts;
    private TokenTrap tokenTrap;
    private Tokens token;
    private StringBuilder result = new StringBuilder();
    private int idx_t=0;
    private int numExp=10;
    private int register=1;
    public GrammarAnalyze(){
        stackNum = new Stack<>();
        stackOp = new Stack<>();
        vars = new HashMap<>();
        consts = new HashMap<>();
        //0是小于，1是大于，-1是相等，-2是错误
        priority = new short[][]{
                {1,1,0,0,0,0,0,0,1,0,0},{1,1,0,0,0,0,0,0,1,0,0},
                {1,1,0,0,1,1,1,0,1,0,0},{1,1,0,0,1,1,1,0,1,0,0},
                {1,1,0,0,1,1,1,0,1,0,0},{1,1,0,0,1,1,1,0,1,0,0},
                {1,1,0,0,1,1,1,0,1,0,0},{0,0,0,0,0,0,0,0,-1,0,0},
                {1,1,-2,-2,1,1,1,-2,1,-2,-2},{1,1,-2,-2,1,1,1,-2,1,-2,-2},
                {1,1,-2,-2,1,1,1,-2,1,-2,-2},
        };
    }
    public void analyze(String path) throws Exception {
        wordAnalyze.readFile(path);
        wordAnalyze.analyze();
        tokens = wordAnalyze.getTokens();
        result.append("declare i32 @getint()\n" +"declare void @putint(i32)\n"+"declare i32 @getch()\n" +"declare void @putch(i32)\n");
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
        result.append('(');
//////        System.out.print("(");
        getSym();
        if(token!=Tokens.RPar){
            error();
        }
        result.append(") ");
//////        System.out.print(") ");
        getSym();
        Block();
        if(idx_t!=tokens.size()){
            error();
        }
    }
    public void FuncType(){
        if(token!=Tokens.INT){
            error();
        }
        result.append("define dso_local i32 ");
        getSym();
    }
    public void IdentMain(){
        if(token!=Tokens.MAIN){
            error();
        }
        result.append("@main");
        getSym();
    }
    public void Block(){
        if(token!=Tokens.LBrace){
            error();
        }
        result.append("{ \n");
        getSym();

        BlockItem();

        while (token!=Tokens.RBrace){
            BlockItem();
        }
////        out.println("OK2");
        result.append("\n}");
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
    public void Stmt(){
        if(token==Tokens.RETURN){
            getSym();
            if(isExp()){
                StackNumEle tmp = Exp(0);
                if(token!=Tokens.Semicolon){
                    error();
                }
                String x = getNumString(tmp);
                result.append("ret ").append("i32 ").append(x);
                getSym();
            }
            else {
                error();
            }
        }
        else if(token==Tokens.Ident){
            if(tokens.get(idx_t).getToken()==Tokens.Equal){
                TokenTrap tmp1 = LVal();
                Var var = vars.get(tmp1.getIdentName());
                if(var == null){
                    error();
                }
                getSym();
                StackNumEle tmp2 = Exp(0);
                storeRegister(var,tmp2);
                if (var.getLoad_register()!=-1){
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
        else if(token!=Tokens.Equal){
            error();
        }

        getSym();
        StackNumEle tmp2 = ConstInitVal();
        consts.put(tmp1.getIdentName(), tmp2.getNumber());
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
        result.append("%").append(register).append(" = alloca i32").append("\n");
        Var tmp_var = new Var();
        tmp_var.setTrue_register(register);
        vars.put(tmp1.getIdentName(),tmp_var);
        register++;
        if(token==Tokens.Equal){
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
        return token == Tokens.LPar || token == Tokens.UnaryOpAdd || token == Tokens.UnaryOpDec || token == Tokens.NUMBER || token == Tokens.Ident||isFunc();
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
                result.append("%").append(register).append(" = call i32 @getint(").append(param).append(")").append("\n");
                Var tmp_var = new Var();
                tmp_var.setLoad_register(register);
                stackNum.push(new StackNumEle(false,tmp_var));
                register++;
                return 0;
            }
            case Getch:{
                result.append("%").append(register).append(" = call i32 @getch(").append(param).append(")").append("\n");
                Var tmp_var = new Var();
                tmp_var.setLoad_register(register);
                stackNum.push(new StackNumEle(false,tmp_var));
                register++;
                return 0;
            }
            case Putint:{
                result.append("call void @putint(").append(param).append(")").append("\n");
                return 1;
            }
            case Putch:{
                result.append("call void @putch(").append(param).append(")").append("\n");
                return 1;
            }
            default:error();return -1;
        }
    }
    public StackNumEle Exp(int type){
        int count=1;
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
            stackNum.push(new StackNumEle(true,tokenTrap.getNumber()));
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
        getSym();
        while (idx_t< tokens.size()&&token!=Tokens.Semicolon&&token!=Tokens.Comma){
//            out.println(token);
            if(type==1){
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
            if(token==Tokens.NUMBER){
                stackNum.push(new StackNumEle(true,tokenTrap.getNumber()));
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
            stackNum.push(new StackNumEle(true,tokenTrap.getNumber()));
        }
        else if(token== Tokens.Ident){
            Integer tmp = consts.get(tokenTrap.getIdentName());
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
                stackNum.push(new StackNumEle(true,tokenTrap.getNumber()));
                getSym();
            }
            else if(token== Tokens.Ident){
                Integer tmp = consts.get(tokenTrap.getIdentName());
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
                        tmp1.setNumber(-tmp1.getNumber());
                        stackNum.push(tmp1);
                    }
                    else{
                        x1 = getNumString(tmp1);
                        result.append("%").append(register).append(" = ").append("sub").append("i32 0, ").append(x1);
                        Var tmp_var = new Var();
                        tmp_var.setLoad_register(register);
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
                    tmp1.setNumber(tmp2.getNumber()+tmp1.getNumber());
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
                    tmp1.setNumber(tmp2.getNumber()-tmp1.getNumber());
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
                    tmp1.setNumber(tmp2.getNumber()*tmp1.getNumber());
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
                    tmp1.setNumber(tmp2.getNumber()/tmp1.getNumber());
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
                    tmp1.setNumber(tmp2.getNumber()%tmp1.getNumber());
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
                    tmp1.setNumber(-tmp1.getNumber());
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
        Integer tmp = consts.get(tokenTrap.getIdentName());
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
    private String getNumString(StackNumEle tmp1) {
        String x1;
        Var var1;
        if(tmp1.isNumber()){
            x1 = ""+tmp1.getNumber();
        }
        else {
            var1 = tmp1.getVar();
            if (var1.getLoad_register()==-1){
                loadRegister(var1);
            }
            x1 = " %"+var1.getLoad_register();
        }
        return x1;
    }
    //规约中的一步操作，根据运算符而略微不同
    private void calBinOp(String op){
        StackNumEle tmp1;
        StackNumEle tmp2;
        String x1,x2;
//        out.println(token);
        if (stackNum.size()<2){
            error();
        }
        else {
            tmp1 = stackNum.pop();
            tmp2 = stackNum.pop();
            x1 = getNumString(tmp1);
            x2 = getNumString(tmp2);
            result.append("%").append(register).append(" = ").append(op).append(" ").
                    append("i32 ").append(x2).append(", ").append(x1).append("\n");

            Var tmp_var = new Var();
            tmp_var.setLoad_register(register);
            stackNum.push(new StackNumEle(false,tmp_var));
            register++;
        }
    }

    //中间代码生成系列：为变量load一个新的寄存器
    private void loadRegister(Var var){
        var.setLoad_register(register);
        result.append("%").append(register).append(" = load ").
                append(var.getType()).append(", ").append(var.getType()).
                append("* %").append(var.getTrue_register()).append("\n");
        register++;
    }
    //中间代码生成系列：为寄存器store一个新的值
    private void storeRegister(Var var,StackNumEle tmp2){
        result.append("store i32").append(" ");
        String x = getNumString(tmp2);
        result.append(x);
        result.append(", ").append(var.getType()).append("* %").append(var.getTrue_register()).append("\n");
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
        out.write(String.valueOf(grammarAnalyze.result));
        out.close();
    }
}
