import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Stack;

import static java.lang.System.*;

public class GrammarAnalyze {
    private final WordAnalyze wordAnalyze = new WordAnalyze();
    private ArrayList<TokenTrap> tokens;
    private final short[][] priority;
    private TokenTrap tokenTrap;
    private Tokens token;
    private final ArrayList<CodeBlock> codeBlocks = new ArrayList<>();
    private final Stack<Integer> top_index = new Stack<>();
    private final StackElement[] symbolStack = new StackElement[100000]; //符号栈,用列表模拟
    private int top_now=-1;
    private int block_idx=0;
    private int idx_t=0;
    private final int numExp=11;
    private int register=1;
    public GrammarAnalyze(){
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
        codeBlocks.get(0).getResult().append("declare i32 @getint()\n" +"declare void @putint(i32)\n"
                +"declare i32 @getch()\n" +"declare void @putch(i32)\n"+"declare void @memset(i32*, i32, i32)\n"
                +"declare i32 @getarray(i32*)\n" + "declare void @putarray(i32, i32*)\n");
        try {
            CompUnit();
        }
        catch (Exception e){
            error();
        }
    }
    public void CompUnit(){
        getSym();
        top_index.push(top_now+1);
        while (token==Tokens.CONST||token==Tokens.INT||token==Tokens.Void){
            if(token==Tokens.CONST){
                ConstDecl(true);
            }
            else if(token==Tokens.INT){
                if(tokens.get(idx_t+1).getToken()==Tokens.LPar){
                    FuncDef();
                }
                else {
                    VarDecl(true);
                }
            }
            else{
                FuncDef();
            }
        }
        if(token!=Tokens.END){
            error();
        }
    }
    public void FuncDef(){
        boolean has_return = FuncType();
////        out.println(token);
        if(token==Tokens.MAIN){
            getSym();
            getBlock().append("define dso_local i32 @main() {\n");
            if(token!=Tokens.LPar){
                error();
            }
            getSym();
            if(token!=Tokens.RPar){
                error();
            }
            getSym();
            top_index.push(top_now+1);
////            out.println(token);
            Block(has_return);
            getBlock().append("}\n");
        }
        else if(token==Tokens.Ident){
            Func func = new Func(tokenTrap.getIdentName(),null,has_return);
            getSym();
            if(token!=Tokens.LPar){
                error();
            }
            getSym();
            StringBuilder paramString = new StringBuilder();
            ArrayList<String> varNames = new ArrayList<>();
            ArrayList<String> TVarNames = new ArrayList<>();
            if(token!=Tokens.RPar){
////                out.println("OK1");
                ArrayList<StackElement> params = FuncFParams();
//                out.println("OK2");
                if(token!=Tokens.RPar){
                    error();
                }
                getSym();
                func.setParams(params);
                symbolStack[++top_now] = new StackElement(EleType.Fun,func,func.getName());
                top_index.push(top_now+1);

                for(int j=0;j<params.size();j++){
                    StackElement i=params.get(j);
                    if(i.getType()==EleType.Var){
                        paramString.append("i32 %u").append(register);
                        TVarNames.add("%u"+register);
                        register++;
                        varNames.add(i.getName());
                    }
                    else if(i.getType()==EleType.Array){
                        paramString.append("i32* %u").append(register);
                        i.getArray().setTrue_register(register);
                        i.getArray().setFuncParam(true);
                        symbolStack[++top_now] = i;
                        register++;
                    }
                    else{
                        error();
                    }
                    if(j!=params.size()-1){
                        paramString.append(", ");
                    }
                }
            }
            else {
                ArrayList<StackElement> params = new ArrayList<>();
                func.setParams(params);
                symbolStack[++top_now] = new StackElement(EleType.Fun,func,func.getName());
                top_index.push(top_now+1);
                getSym();
            }
            getBlock().append("define dso_local ").append(has_return ? "i32" : "void").append(" @").append(func.getName()).append("(").append(paramString).append(") {\n");
//            out.println("OK1");
            for(int i=0;i<varNames.size();i++){
                String s=varNames.get(i);
                String t = TVarNames.get(i);
                defineVar(s);
                getBlock().append(CompileUtil.TAB).append("store i32 ").append(t).
                        append(", i32").append("* %u").append(register-1).append("\n");
            }
//            out.println("OK1");
            Block(has_return);
//            out.println("OK2");
            if(!has_return){
                getBlock().append(CompileUtil.TAB).append("ret void\n");
            }
            getBlock().append("}\n");
        }
        else {
            error();
        }
    }
    public ArrayList<StackElement> FuncFParams(){
        ArrayList<StackElement> elements = new ArrayList<>();
        elements.add(FuncFParam());
        while (token==Tokens.Comma){
            getSym();
            elements.add(FuncFParam());
        }
        return elements;
    }
    public StackElement FuncFParam(){
        BType();
        StackElement element;
        if(token!=Tokens.Ident){
            error();
        }
        String name = tokenTrap.getIdentName();
        getSym();
//        out.println(token);
        if(token==Tokens.LBracket){
            getSym();
            if(token!=Tokens.RBracket){
                error();
            }
            getSym();
            MyArray myArray;
            ArrayList<Integer> shape = new ArrayList<>();
            shape.add(-1);
            int i;
            for(i=1;token==Tokens.LBracket;i++){
                getSym();
                StackElement tmpp = ConstExp(new Stack<>(), new Stack<>());
                shape.add(tmpp.getNum().getNumber());
                if(token!=Tokens.RBracket){
                    error();
                }
                getSym();
            }

            myArray = new MyArray(i,shape,false);
            element = new StackElement(EleType.Array, myArray,name);
        }
        else{
            element = new StackElement(EleType.Var, (Var) null,name);
        }
        return element;
    }
    public boolean FuncType(){
        Boolean has_return = null;
        if(token==Tokens.INT){
            has_return=true;
        }
        else if(token==Tokens.Void){
            has_return=false;
        }
        else {
            error();
        }
        getSym();
        return Boolean.TRUE.equals(has_return);
    }
    public int Block(boolean has_return){
////        out.println(token);
        if(token!=Tokens.LBrace){
            error();
        }
        getSym();
        int i;
        i=BlockItem(has_return);
        while (token!=Tokens.RBrace){
//            out.println(token);
            i=BlockItem(has_return);
        }
        top_now = top_index.pop()-1;
//////////        out.println("OK2");
//        if(par_flag_r==0) {
//            getBlock().append(Util.TAB).append("}");
//            par_flag_r=1;
//        }
        getSym();
        return i;
    }
    public int BlockItem(boolean has_return){
//        out.println(token);
        if(token==Tokens.CONST){
////////            out.println("OK0");
            ConstDecl(false);
        }
        else if(token==Tokens.INT){
////////            out.println("OK2");
            VarDecl(false);
        }
        else {
            return Stmt(has_return);
        }
        return 0;
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
    public StackElement Cond(){
        return LOrExp();
    }
    public StackElement LOrExp(){
        int tmp_l=block_idx;
//        out.println(tmp_l);
        StackElement tmp1 = LAndExp();
        StackElement tmp2=tmp1;
        int tmp_r=block_idx;
//        out.println(tmp_r);
        while (token==Tokens.OR){
            getSym();
            String x1 = getNumString1(tmp2,block_idx);
            //#表示if为true语句的位置
            getBlock().append(CompileUtil.TAB).append("br i1 ").append(x1).
                    append(", label %x#").append(", label %x").append(block_idx+1).append("\n");
            block_idx++;
            codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
////////            out.println(token);
            tmp_l = block_idx;
            tmp2 = LAndExp();
            tmp_r = block_idx;
            for(int k=tmp_l;k<=tmp_r;k++){
                String tmps = codeBlocks.get(k).getResult().toString();
                tmps = tmps.replace("`",""+(block_idx+1));
                codeBlocks.get(k).setResult(new StringBuffer(tmps));
            }
////////            out.println("OK");
            String x2 = getNumString1(tmp2,block_idx);
            Var tmp_var = new Var("i1",false);
            tmp_var.setLoad_register(register-1,block_idx);
            tmp1 = new StackElement(EleType.Var,tmp_var,""+(register-1));
        }
        return tmp1;
    }
    public StackElement LAndExp(){
        StackElement tmp1 = EqExp();
        StackElement tmp2 = tmp1;
        //br i1 %res_b label block_c, label %block_out
        while (token==Tokens.AND){
            getSym();
            String x1 = getNumString1(tmp2,block_idx);
            //`表示else后语句位置
            getBlock().append(CompileUtil.TAB).append("br i1 ").append(x1).
                    append(", label %x").append(block_idx+1).append(", label %x`").append("\n");
            block_idx++;
            codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
            tmp2 = EqExp();
            String x2 = getNumString1(tmp2,block_idx);
            Var tmp_var = new Var("i1",false);
            tmp_var.setLoad_register(register-1,block_idx);
            tmp1 = new StackElement(EleType.Var,tmp_var,""+(register-1));
        }
        return tmp1;
    }
    public StackElement EqExp(){
        if(!isExp()){
            error();
        }
        StackElement tmp1 = RelExp();
        if(token==Tokens.Eq||token==Tokens.NEq){
            Tokens tmp_token = token;
            getSym();
            if(!isExp()){
                error();
            }
            StackElement tmp2 = Exp(1, new Stack<>(), new Stack<>());
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

    private StackElement getCmpResult(StackElement tmp1, StackElement tmp2, String op) {
        String x1 = getNumString32(tmp1);
        String x2 = getNumString32(tmp2);
        getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = ").append("icmp ").append(op)
                .append(" i32 ").append(x1).append(",").append(x2).append("\n");
        Var tmp_var = new Var("i1",false);
        tmp_var.setLoad_register(register,block_idx);
        tmp1 = new StackElement(EleType.Var,tmp_var,""+register);
        register++;
        return tmp1;
    }

    public StackElement RelExp(){
        if(!isExp()){
            error();
        }
        StackElement tmp1 = Exp(1, new Stack<>(), new Stack<>());
        if(isCompare()){
            Tokens tmp_token = token;
            getSym();
            if(!isExp()){
                error();
            }
            StackElement tmp2 = Exp(1, new Stack<>(), new Stack<>());
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
    public int Stmt(boolean has_return){
        if(token==Tokens.RETURN){
            getSym();
            if(has_return){
                if(isExp()){
                    StackElement tmp = Exp(0, new Stack<>(), new Stack<>());
                    if(token!=Tokens.Semicolon){
                        error();
                    }
                    String x = getNumString(tmp);
                    getBlock().append(CompileUtil.TAB).append("ret ").append("i32 ").append(x).append("\n");
                    getSym();
                }
                else {
                    error();
                }
            }
            else{
                if(token!=Tokens.Semicolon){
                    error();
                }
                getSym();
                getBlock().append(CompileUtil.TAB).append("ret void\n");
            }
            return 1;
        }
        else if(token==Tokens.Ident){
            StackElement tmp=null;
            if(tokens.get(idx_t).getToken()==Tokens.LBracket){
////                out.println("begin----");
                for(int i=top_now;i>=0;i--){
                    if(symbolStack[i].getType()==EleType.Array&&symbolStack[i].getName().equals(tokenTrap.getIdentName())){
                        tmp = symbolStack[i];
                        break;
                    }
                }
                tmp = getArrayElement2(tmp);
            }
            if(tokens.get(idx_t).getToken()==Tokens.Assign){
                if(tmp==null){
                    TokenTrap tmp1 = LVal();
                    StackElement stackElement = null;
                    int j;
                    for (j=top_now;j>=0;j--){
                        StackElement tmp_ele = symbolStack[j];
                        if(tmp_ele.getName().equals(tmp1.getIdentName())){
                            if(tmp_ele.getType()!=EleType.Var){
                                error();
                            }
                            stackElement = tmp_ele;
                            break;
                        }
                    }
                    if(stackElement==null){
                        error();
                    }
                    getSym();
                    StackElement tmp2 = Exp(0, new Stack<>(), new Stack<>());
                    assert stackElement != null;
                    storeRegister(stackElement.getVar(),tmp2);
                    if (stackElement.getVar().getLoad_register(block_idx)!=-1){
                        loadRegister(stackElement.getVar());
                    }
                }
                else {
                    getSym();
                    getSym();
                    StackElement tmp2 = Exp(0, new Stack<>(), new Stack<>());
                    storeRegister(tmp.getVar(), tmp2);
                }
            }
            else{
                if(tmp==null){
                    Exp(0, new Stack<>(), new Stack<>());
                }
            }
            if(token!=Tokens.Semicolon){
                error();
            }
            getSym();
        }
        //注意EXP可有可无
        else if(isExp()){
            Exp(0, new Stack<>(), new Stack<>());
            if(token!=Tokens.Semicolon){
                error();
            }
            getSym();
        }
        else if(token==Tokens.Semicolon){
            getSym();
        }
        else if(token==Tokens.LBrace){
            top_index.push(top_now+1);
            return Block(has_return);
        }
        else if(token==Tokens.IF){
            getSym();
            if(token!=Tokens.LPar){
                error();
            }
            getSym();
            int tmp_l = block_idx;
            StackElement cond = Cond();
            if(token!=Tokens.RPar){
                error();
            }
            getSym();
            int tmp_r = block_idx;
            for(int k=tmp_l;k<=tmp_r;k++){
                String tmps = codeBlocks.get(k).getResult().toString();
                tmps = tmps.replace("#",""+(block_idx+1));
                codeBlocks.get(k).setResult(new StringBuffer(tmps));
            }
            int l1,l2,r1=-1,r2=-1,i1=0,i2=0;
            block_idx++;
            l1 = block_idx;
            codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
            i1=Stmt(has_return);
//            out.println(i1);
            l2 = block_idx;
            if (token==Tokens.ELSE){
                getSym();
                block_idx++;
                r1=block_idx;
                codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
                i2=Stmt(has_return);
                r2 = block_idx;
            }
//            if(token!=Tokens.RBrace){
//            }
            if(i1!=1||i2!=1) {
                block_idx++;
                codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
            }
            if(r1==-1){
                r1 = block_idx;
            }
            for(int k=tmp_l;k<=tmp_r;k++){
                String tmps = codeBlocks.get(k).getResult().toString();
                tmps = tmps.replace("`",""+r1);
                codeBlocks.get(k).setResult(new StringBuffer(tmps));
            }
            if(cond.getType()==EleType.ConstVar){
                if (cond.getNum().getType().equals("i32")){
                    //icmp eq i32 %13, 10
                    codeBlocks.get(l1-1).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = icmp ne i32 ").append(cond.getNum().getNumber()).
                            append(", 0").append("\n");
                    codeBlocks.get(l1 - 1).getResult().append(CompileUtil.TAB).append("br i1 %u").append(register).
                            append(", label %x").append(l1).append(", label %x").append(r1).append("\n");
                    register++;
                }
                else {
                    codeBlocks.get(l1 - 1).getResult().append(CompileUtil.TAB).append("br i1 ").append(cond.getNum().getNumber()).
                            append(", label %x").append(l1).append(", label %x").append(r1).append("\n");
                }
            }
            else {
                int tmp_idx = block_idx;
                block_idx=l1-1;
                String x1 = getNumString(cond);
                block_idx=tmp_idx;
                if(cond.getVar().getType().equals("i32")){
                    codeBlocks.get(l1-1).getResult().append(CompileUtil.TAB).append("%u").append(register).
                            append(" = icmp ne i32 ").append(x1).append(", 0").append("\n");
                    codeBlocks.get(l1 - 1).getResult().append(CompileUtil.TAB).append("br i1 %u").append(register).
                            append(", label %x").append(l1).append(", label %x").append(r1).append("\n");
                    register++;
                }
                else {
                    codeBlocks.get(l1 - 1).getResult().append(CompileUtil.TAB).append("br i1").append(x1).
                            append(", label %x").append(l1).append(", label %x").append(r1).append("\n");
                }
            }
            if(i1!=1) {
                codeBlocks.get(l2).getResult().append(CompileUtil.TAB).append("br label %x").append(block_idx).append("\n");

            }
            if(i2!=1&&r2!=-1){
                codeBlocks.get(r2).getResult().append(CompileUtil.TAB).append("br label %x").append(block_idx).append("\n");
            }
        }
        else if(token==Tokens.WHILE){
            int cond_idx,while_in,while_out;
            getSym();
            if(token!=Tokens.LPar){
                error();
            }
            getSym();
            getBlock().append(CompileUtil.TAB).append("br label %x").append(block_idx+1).append("\n");
            block_idx++;
            cond_idx = block_idx;
            codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
            StackElement cond = Cond();
            String x1 = getNumString(cond);
            //while里面
            block_idx++;
            while_in = block_idx;
            codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
            if(token!=Tokens.RPar){
                error();
            }
            getSym();
            Stmt(has_return);
            getBlock().append(CompileUtil.TAB).append("br label %x").append(cond_idx).append("\n");
            for(int j=cond_idx;j<=block_idx;j++){
                String tmps = codeBlocks.get(j).getResult().toString();
                tmps = tmps.replace("$",""+(block_idx+1));
                tmps = tmps.replace("~",""+cond_idx);
                codeBlocks.get(j).setResult(new StringBuffer(tmps));
            }
            //while外面
            block_idx++;
            while_out = block_idx;
            codeBlocks.add(new CodeBlock("x"+block_idx,new StringBuffer()));
            //回填
            if(cond.getType()==EleType.ConstVar){
                if (cond.getNum().getType().equals("i32")){
                    codeBlocks.get(cond_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).
                            append(" = icmp ne i32 ").append(cond.getNum().getNumber()).append(", 0").append("\n");
                    codeBlocks.get(cond_idx).getResult().append(CompileUtil.TAB).append("br i1 %u").append(register).
                            append(", label %x").append(while_in).append(", label %x").append(while_out).append("\n");
                    register++;
                }
                else {
                    codeBlocks.get(cond_idx).getResult().append(CompileUtil.TAB).append("br i1 ").append(cond.getNum().getNumber()).
                            append(", label %x").append(while_in).append(", label %x").append(while_out).append("\n");
                }
            }
            else{
                if(cond.getVar().getType().equals("i32")){
                    codeBlocks.get(cond_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).
                            append(" = icmp ne i32 ").append(x1).append(", 0").append("\n");
                    codeBlocks.get(cond_idx).getResult().append(CompileUtil.TAB).append("br i1 %u").append(register).
                            append(", label %x").append(while_in).append(", label %x").append(while_out).append("\n");
                    register++;
                }
                else {
                    codeBlocks.get(cond_idx).getResult().append(CompileUtil.TAB).append("br i1").append(x1).
                            append(", label %x").append(while_in).append(", label %x").append(while_out).append("\n");
                }
            }

        }
        else if(token==Tokens.Break){
            getSym();
            if(token!=Tokens.Semicolon){
                error();
            }
            getSym();
            getBlock().append(CompileUtil.TAB).append("br label %x$").append("\n");
        }
        else if(token==Tokens.Continue){
            getSym();
            if(token!=Tokens.Semicolon){
                error();
            }
            getSym();
            getBlock().append(CompileUtil.TAB).append("br label %x~").append("\n");
        }
        else {
            error();
        }
        return 0;
    }

    private StackElement getArrayElement2(StackElement tmp) {
        if(tmp == null){
            error();
        }
        assert tmp != null;

        if(tmp.getType()==EleType.ConstArray||tmp.getType()==EleType.Array){
            getSym();
            MyArray tmpArray= tmp.getArray();
            int dimen = tmpArray.getDimension(),i;
            ArrayList<Integer> shape = tmpArray.getShape();
            String[] location = new String[dimen];
            for(i=0;token==Tokens.LBracket;i++){
                getSym();
                StackElement tmpp;
                if(tmp.getType()==EleType.ConstArray){
                    tmpp = ConstExp(new Stack<>(), new Stack<>());
                }
                else {
                    tmpp = Exp(0, new Stack<>(), new Stack<>());
                }
                location[i] = getNumString32(tmpp);
                if(token!=Tokens.RBracket){
                    error();
                }
                getSym();
            }
            tmp = getArrayElement(tmp, dimen, i, shape, location);
        }
        return tmp;
    }

    public StackElement ConstInitVal(int i, int index, MyArray myArray, StackElement ret_ele){
        //判断是不是数组
        if(myArray ==null){
            return ConstExp(new Stack<>(), new Stack<>());
        }
        if(ret_ele==null){
            int total=1;
            for(Integer si : myArray.getShape()){
                total*=si;
            }
            ret_ele = new StackElement(EleType.ConstArray,new String[total],"");
            Arrays.fill(ret_ele.getArrayInits(),null);
        }
        String[] arrayInits = ret_ele.getArrayInits();
        if(token==Tokens.LBrace){
            if(i== myArray.getDimension()){
                error();
            }
            getSym();
            if(token!=Tokens.RBrace){
                ConstInitVal(i+1,index,myArray,ret_ele);
////                out.println(token);
                ArrayList<Integer> tmp_shape = myArray.getShape();
                int kk=1;
                for(int ii=i+1;ii<tmp_shape.size();ii++){
                    kk*=tmp_shape.get(ii);
                }
                while (token==Tokens.Comma){
                    getSym();
                    index+=kk;
                    ConstInitVal(i+1,index,myArray,ret_ele);
                }
                if(token!=Tokens.RBrace){
                    error();
                }
                getSym();
                return ret_ele;
            }
            else {
                getSym();
                return null;
            }
        }
        else {
            if(i!= myArray.getDimension()){
                error();
            }
////            out.println("NOO");
            StackElement tmp = ConstExp(new Stack<>(), new Stack<>());
////            out.println("NOO");
            arrayInits[index] = getNumString32(tmp);
            return ret_ele;
        }
    }
    public StackElement InitVal(int i, int index, MyArray myArray, StackElement ret_ele){
        if(myArray ==null){
            return Exp(0, new Stack<>(), new Stack<>());
        }
        //能到这说明肯定是数组
        if(ret_ele==null){
            int total=1;
            for(Integer si : myArray.getShape()){
                total*=si;
            }
            ret_ele = new StackElement(EleType.Array,new String[total],"");
            Arrays.fill(ret_ele.getArrayInits(),null);
        }
        String[] arrayInits = ret_ele.getArrayInits();
//////        out.println(token);
        if(token==Tokens.LBrace){
            if(i== myArray.getDimension()){
                error();
            }
            getSym();
            if(token!=Tokens.RBrace){
                InitVal(i+1,index,myArray,ret_ele);
                ArrayList<Integer> tmp_shape = myArray.getShape();
                int kk=1;
                for(int ii=i+1;ii<tmp_shape.size();ii++){
                    kk*=tmp_shape.get(ii);
                }
                while (token==Tokens.Comma){
                    getSym();
                    index+=kk;
                    InitVal(i+1,index,myArray,ret_ele);
                }
                if(token!=Tokens.RBrace){
                    error();
                }
                getSym();
                return ret_ele;
            }
            else {
                getSym();
                return null;
            }
        }
        else {
            if(i!= myArray.getDimension()){
                error();
            }
            StackElement tmp = Exp(0, new Stack<>(), new Stack<>());
            String x = getNumString32(tmp);
            arrayInits[index] = x;
            return ret_ele;
        }
    }
    public void ConstDef(){
        TokenTrap tmp1 = Ident();
        int l,r,total=1;
        l=top_index.peek();
        r=top_now;
        for(int i=l;i<=r;i++){
            StackElement stackElement = symbolStack[i];
            if(stackElement.getName().equals(tmp1.getIdentName())){
                error();
            }
        }
        StackElement tmp_final=null;
        MyArray myArray = null;
        //判断是不是数组
        ArrayList<Integer> shape = new ArrayList<>();
        if(token==Tokens.LBracket){
            total=getShapeAndTotal(shape);
            myArray = new MyArray(shape.size(),shape,false);
            tmp_final = new StackElement(EleType.ConstArray, myArray,tmp1.getIdentName());
        }
        if(token!=Tokens.Assign){
            error();
        }
        getSym();
        //赋值部分，不是数组则直接赋值，是则循环赋值。
        if(myArray==null){
            tmp_final = ConstInitVal(0,0,null,null);
        }
        else {
            StackElement ret_ele = ConstInitVal(0,0, tmp_final.getArray(), null);
            getBlock().append(CompileUtil.TAB).append("%u").append(register).
                    append(" = alloca [").append(total).append(" x i32]").append("\n");
            myArray.setTrue_register(register);
            register++;
            //%23 = getelementptr [2 x i32],[2 x i32]* %22, i32 0, i32 0
            // call void @memset(i32*  %23,i32 0,i32 16)
            memset(total, myArray);
            updateArrayEle(total, myArray, ret_ele);
        }
        tmp_final.setName(tmp1.getIdentName());
        symbolStack[++top_now] = tmp_final;
    }
    public void ConstDecl(boolean isGlo){
        getSym();
        BType();
        if(isGlo){
            ConstDefGlo();
        }
        else {
            ConstDef();
        }
        //0或多次
        while (token==Tokens.Comma){
            getSym();
            if(isGlo){
                ConstDefGlo();
            }
            else {
                ConstDef();
            }
        }
        if(token!=Tokens.Semicolon){
            error();
        }
        getSym();
    }
    public void ConstDefGlo(){
        TokenTrap tmp1 = Ident();
        int l,r,total=1;
        l=top_index.peek();
        r=top_now;
        for(int i=l;i<=r;i++){
            StackElement stackElement = symbolStack[i];
            if(stackElement.getName().equals(tmp1.getIdentName())){
                error();
            }
        }
        StackElement tmp_final=null;
        MyArray myArray = null;
        //判断是不是数组
        ArrayList<Integer> shape = new ArrayList<>();
        if(token==Tokens.LBracket){
            total=getShapeAndTotal(shape);
            myArray = new MyArray(shape.size(),shape,true);
            tmp_final = new StackElement(EleType.ConstArray, myArray,tmp1.getIdentName());
        }
        if(token!=Tokens.Assign){
            error();
        }
        getSym();
        //不是数组则正常赋值，是则特殊处理。
        if(tmp_final==null){
            tmp_final = ConstInitVal(0,0,null,null);
            getBlock().append("@").append(tmp1.getIdentName()).append(" = dso_local constant i32 ")
                        .append(tmp_final.getNum().getNumber()).append("\n");
        }
        else {
            StackElement ret_ele = ConstInitVal(0,0, tmp_final.getArray(), null);
            if(ret_ele==null){
                //@d = dso_local global [5 x i32] zeroinitializer
                getBlock().append("@").append(tmp1.getIdentName()).append(" = dso_local constant [").
                            append(total).append(" x i32] zeroinitializer").append("\n");
            }
            else {
                String[] arrayInits = ret_ele.getArrayInits();
                StringBuilder initCode = new StringBuilder();
                initCode.append("[");
                if(arrayInits[0]==null){
                    initCode.append("i32 0");
                }
                else {
                    initCode.append("i32 ").append(arrayInits[0]);
                }
                for(int i=1;i<arrayInits.length;i++){
                    if(arrayInits[i]==null){
                        initCode.append(", i32 0");
                    }
                    else {
                        initCode.append(", i32 ").append(arrayInits[i]);
                    }
                }
                initCode.append("]");
                //@a = dso_local constant [3 x i32] [i32 1, i32 2, i32 0]
                getBlock().append("@").append(tmp1.getIdentName()).append(" = dso_local constant [").
                        append(total).append(" x i32] ").append(initCode).append("\n");
////                out.println(token);
            }
        }
        tmp_final.setName(tmp1.getIdentName());
        symbolStack[++top_now] = tmp_final;
    }

    public void VarDef(){
        TokenTrap tmp1 = Ident();
//        out.println(tmp1.getIdentName());
        int l,r,total=1;
        l=top_index.peek();
        r=top_now;
        for(int i=l;i<=r;i++){
            StackElement stackElement = symbolStack[i];
            if(stackElement.getName().equals(tmp1.getIdentName())){
                error();
            }
        }
        StackElement tmp_final=null;
        MyArray myArray = null;
        //判断是不是数组
        if(token==Tokens.LBracket){
            ArrayList<Integer> shape = new ArrayList<>();
            int i;
            for(i=0;token==Tokens.LBracket;i++){
                getSym();
                StackElement tmpp = ConstExp(new Stack<>(), new Stack<>());
                total*=tmpp.getNum().getNumber();
                shape.add(tmpp.getNum().getNumber());
                if(token!=Tokens.RBracket){
                    error();
                }
                getSym();
            }
            myArray = new MyArray(i,shape,false);
            tmp_final = new StackElement(EleType.Array, myArray,tmp1.getIdentName());
        }
        //定义变量
        if(myArray==null){
            getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = alloca i32").append("\n");
            Var tmp_var = new Var("i32",false);
            tmp_var.setTrue_register(register);
            tmp_final = new StackElement(EleType.Var,tmp_var,tmp1.getIdentName());
            register++;
        }
        else {
            //%1 = alloca [2 x i32]
            getBlock().append(CompileUtil.TAB).append("%u").append(register).
                    append(" = alloca [").append(total).append(" x i32]").append("\n");
            myArray.setTrue_register(register);
            register++;
            memset(total, myArray);
        }

        //赋值变量,可选
        if(token==Tokens.Assign){
            getSym();
            //非数组
            if (myArray==null){
                Var tmp_var = defineVar(tmp1.getIdentName());
                StackElement tmp2 = InitVal(0,0,null,null);
                //给变量赋值
                storeRegister(tmp_var,tmp2);
                tmp_final=new StackElement(EleType.Var,tmp_var,tmp1.getIdentName());
            }
            else {
//////                out.println("OK1");
                StackElement ret_ele = InitVal(0,0, tmp_final.getArray(), null);
                updateArrayEle(total, myArray, ret_ele);
            }
        }
        symbolStack[++top_now] = tmp_final;
    }

    private void memset(int total, MyArray myArray) {
        getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = getelementptr [").append(total).
                append(" x i32],[").append(total).append(" x i32]* %u").
                append(myArray.getTrue_register()).append(", i32 0, i32 0").append("\n");
        getBlock().append(CompileUtil.TAB).append("call void @memset(i32* %u").append(register).append(" ,i32 0,i32 ").
                append(4 * total).append(")").append("\n");
        register++;
    }

    private void updateArrayEle(int total, MyArray myArray, StackElement ret_ele) {
        if(ret_ele!=null) {
            String[] arrayInits = ret_ele.getArrayInits();
            for (int i = 0; i < arrayInits.length; i++) {
                if (arrayInits[i] != null) {
                    //先get到再store
                    getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = getelementptr [").append(total).
                            append(" x i32],[").append(total).append(" x i32]* %u").
                            append(myArray.getTrue_register()).append(", i32 0, i32 ").append(i).append("\n");

                    getBlock().append(CompileUtil.TAB).append("store i32 ").append(arrayInits[i]).append(", i32* %u").
                            append(register).append("\n");
                    register++;
                }
            }
        }
    }

    public void VarDefGlo(){
        TokenTrap tmp1 = Ident();
        int l,r,total=1;
        l=top_index.peek();
        r=top_now;
        for(int i=l;i<=r;i++){
            StackElement stackElement = symbolStack[i];
            if(stackElement.getName().equals(tmp1.getIdentName())){
                error();
            }
        }
        StackElement tmp_final=null;
        MyArray myArray = null;
        //判断是不是数组
        ArrayList<Integer> shape = new ArrayList<>();
        if(token==Tokens.LBracket){
            total=getShapeAndTotal(shape);
            myArray = new MyArray(shape.size(),shape,true);
            tmp_final = new StackElement(EleType.Array, myArray,tmp1.getIdentName());
        }
        //赋值变量，可选操作

        if(token==Tokens.Assign){
            getSym();
            //非数组
            if (myArray==null){
                StackElement tmp2 = InitVal(0,0,null,null);
                //@a = dso_local global i32 5
                getBlock().append("@").append(tmp1.getIdentName())
                        .append(" = dso_local global i32 ").append(tmp2.getNum().getNumber()).append("\n");
                Var tmp_var = new Var("i32",true);
                tmp_var.setName(tmp1.getIdentName());
                tmp_final=new StackElement(EleType.Var,tmp_var,tmp1.getIdentName());
            }
            else {
                StackElement ret_ele;
                ret_ele = ConstInitVal(0,0, tmp_final.getArray(), null);
                if(ret_ele==null){
                    //@d = dso_local global [5 x i32] zeroinitializer
                    getBlock().append("@").append(tmp1.getIdentName()).append(" = dso_local global [").
                            append(total).append(" x i32] zeroinitializer").append("\n");
                }
                else {
                    String[] arrayInits = ret_ele.getArrayInits();
                    StringBuilder initCode = new StringBuilder();
                    initCode.append("[");
//                    for(String j:arrayInits){
////                        out.println(j);
//                    }
                    if(arrayInits[0]==null){
                        initCode.append("i32 0");
                    }
                    else {
                        initCode.append("i32 ").append(arrayInits[0]);
                    }
                    for(int i=1;i<arrayInits.length;i++){
                        if(arrayInits[i]==null){
                            initCode.append(", i32 0");
                        }
                        else {
                            initCode.append(", i32 ").append(arrayInits[i]);
                        }
                    }
                    initCode.append("]");
                    //@a = dso_local constant [3 x i32] [i32 1, i32 2, i32 0]
                    getBlock().append("@").append(tmp1.getIdentName()).append(" = dso_local global [").
                            append(total).append(" x i32] ").append(initCode).append("\n");
                }
            }
        }
        else {
            if(myArray!=null){
                getBlock().append("@").append(tmp1.getIdentName()).append(" = dso_local global [").
                        append(total).append(" x i32] zeroinitializer").append("\n");
            }
            else {
                getBlock().append("@").append(tmp1.getIdentName()).append(" = dso_local global i32 0").append("\n");
                Var tmp_var = new Var("i32",true);
                tmp_var.setName(tmp1.getIdentName());
                tmp_final = new StackElement(EleType.Var,tmp_var,tmp1.getIdentName());
            }
        }
        symbolStack[++top_now] = tmp_final;
    }
    public void VarDecl(boolean isGlo){
        BType();
//////////        out.println("---");
        if(isGlo){
            VarDefGlo();
        }
        else {
            VarDef();
        }
        //0次或多次
        while (token==Tokens.Comma){
            getSym();
            if(isGlo){
                VarDefGlo();
            }
            else {
                VarDef();
            }
        }
        if(token!=Tokens.Semicolon){
            error();
        }
        getSym();
    }

    private Var defineVar(String name) {
        getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = alloca i32").append("\n");
        Var tmp_var = new Var("i32",false);
        tmp_var.setTrue_register(register);
        symbolStack[++top_now]=new StackElement(EleType.Var,tmp_var,name);
        register++;
        return tmp_var;
    }

    public boolean isExp(){
        return token == Tokens.LPar || token == Tokens.UnaryOpAdd || token == Tokens.UnaryOpDec || token == Tokens.NUMBER || token == Tokens.Ident||token==Tokens.NOT||isFunc();
    }
    public boolean isFunc(){
        return token==Tokens.Getch||token==Tokens.Getint||token==Tokens.Putch||token==Tokens.Putint||
                token==Tokens.Putarray||token==Tokens.Getarray;
    }
    public boolean handleFunc(Stack<StackElement> stackNum,Stack<Tokens> stackOp){
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
            String fun_name = tmp_token==Tokens.Getint?"getint":"getch";
            getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = call i32 @").append(fun_name).
                    append("(").append(param).append(")").append("\n");
            Var tmp_var = new Var("i32",false);
            tmp_var.setLoad_register(register,block_idx);
            stackNum.push(new StackElement(EleType.Var,tmp_var,""+register));
            register++;
            return true;
        }
        else if(tmp_token==Tokens.Putch||tmp_token==Tokens.Putint){
            if(token==Tokens.RPar){
                error();
            }
            else {
                String fun_name = tmp_token==Tokens.Putint?"putint":"putch";
                StackElement par = Exp(1, new Stack<>(), new Stack<>());
                param.append("i32 ").append(getNumString(par));
                getBlock().append(CompileUtil.TAB).append("call void @").append(fun_name).
                        append("(").append(param).append(")").append("\n");
                if(token!=Tokens.RPar){
                    error();
                }
            }
            return false;
        }
        else if(tmp_token==Tokens.Getarray){
            if(token==Tokens.RPar){
                error();
            }
            else {
                StackElement par = Exp(1, new Stack<>(), new Stack<>());
                if(par.getType()!=EleType.Array){
                    error();
                }
                MyArray array = par.getArray();
                if(array.getDimension()!=1){
                    error();
                }
                param.append("i32* ").append(getNumString(par));
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = call i32 @getarray").
                        append("(").append(param).append(")").append("\n");
                Var tmp_var = new Var("i32",false);
                tmp_var.setLoad_register(register,block_idx);
                stackNum.push(new StackElement(EleType.Var,tmp_var,""+register));
                register++;
                if(token!=Tokens.RPar){
                    error();
                }
//                return 1;
            }
            return true;
        }
        else if(tmp_token==Tokens.Putarray){
            if(token==Tokens.RPar){
                error();
            }
            else {
                StackElement par1 = Exp(0, new Stack<>(), new Stack<>());
                if(token!=Tokens.Comma){
                    error();
                }
                else if(par1.getType()==EleType.Array||par1.getType()==EleType.ConstArray){
                    error();
                }
                getSym();
                StackElement par2 = Exp(1, new Stack<>(), new Stack<>());
                if(par2.getType()!=EleType.Array){
                    error();
                }
                MyArray array = par2.getArray();
                if(array.getDimension()!=1){
                    error();
                }
                //call void @putarray(i32 %29, i32* %33)
                param.append("i32 ").append(getNumString(par1)).append(", i32* ").append(getNumString(par2));
                getBlock().append(CompileUtil.TAB).append("call void @putarray").
                        append("(").append(param).append(")").append("\n");
                if(token!=Tokens.RPar){
                    error();
                }

            }
            return false;
        }
        else {
            error();
            return false;
        }
    }
    public StackElement handleIdentFunc(Stack<StackElement> stackNum,Stack<Tokens> stackOp,Func func){
        boolean has_return = func.isHas_return();
        if(token!=Tokens.LPar){
            error();
        }
        getSym();
        ArrayList<StackElement> params;
        StringBuilder paramString = new StringBuilder();
//        out.println(func.getName());
        if(token!=Tokens.RPar){
            params = FuncRParams();
            if(params.size()!=func.getParams().size()){
                error();
            }
            else if(token!=Tokens.RPar){
                error();
            }
            for(int j=0;j<params.size();j++){
                StackElement RElement=params.get(j);
                if(RElement.getType()==EleType.Var){
                    String x = getNumString(RElement);
                    paramString.append("i32 ").append(x);
                }
                else if(RElement.getType()==EleType.ConstVar){
                    paramString.append("i32 ").append(RElement.getNum().getNumber());
                }
                else if(RElement.getType()==EleType.Array){
                    MyArray RArray = RElement.getArray();
                    ArrayList<Integer> RShape = RArray.getShape();
                    ArrayList<Integer> XShape = func.getParams().get(j).getArray().getShape();
                    if(RArray.getDimension()!= XShape.size()){
                        error();
                    }
                    for(int k=1;k<RShape.size();k++){
                        if(!RShape.get(k).equals(XShape.get(k))){
                            error();
                        }
                    }

                    paramString.append("i32* ").append(getNumString(RElement));
                }
                else{
                    error();
                }
                if(j!=params.size()-1){
                    paramString.append(", ");
                }
            }
        }
        if(has_return){
            //%2 = call i32 @func1()
            getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = ").append("call i32 @").
                    append(func.getName()).append("(").append(paramString).append(")").append("\n");
            Var var = new Var("i32",false);
            var.setLoad_register(register,block_idx);
            StackElement ret = new StackElement(EleType.Var,var,""+register);
            register++;
            return ret;
        }
        else{
            getBlock().append(CompileUtil.TAB).append("call void @").append(func.getName()).
                    append("(").append(paramString).append(")").append("\n");
            return null;
        }
    }
    public ArrayList<StackElement> FuncRParams(){
        ArrayList<StackElement> elements = new ArrayList<>();
        elements.add(Exp(1,new Stack<>(),new Stack<>()));
        while (token==Tokens.Comma){
            getSym();
            elements.add(Exp(1,new Stack<>(),new Stack<>()));
        }
        return elements;
    }
    public boolean ExpOver(){
        return token==Tokens.Semicolon||token==Tokens.Comma||token==Tokens.Ge||token==Tokens.GT||token==Tokens.Le
                ||token==Tokens.LT||token==Tokens.Eq||token==Tokens.NEq||token==Tokens.AND||token==Tokens.OR||token==Tokens.RBracket||token==Tokens.RBrace;
    }
    public StackElement Exp(int type,Stack<StackElement> stackNum,Stack<Tokens> stackOp){
        int count=1,flag;
        boolean isRead=true;
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
            stackNum.push(new StackElement(EleType.ConstVar,new Num(tokenTrap.getNumber(),"i32"),""));
        }
        else if(token== Tokens.Ident){
            if(tokens.get(idx_t).getToken()==Tokens.LPar){
                boolean has_ret = pushFuncIdent(stackNum,stackOp);
                if(!has_ret){
                    getSym();
                    return null;
                }
            }
            else{
                pushIdent(stackNum,stackOp);
            }
        }
        else if(isFunc()){
            boolean has_ret = handleFunc(stackNum,stackOp);
            if(!has_ret){
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
//        out.println(token);
        while (idx_t< tokens.size()&&!ExpOver()){
//////            out.println("!!!!!!");
////            out.println(token);
            flag=0;
            if(type==1&&isRead){
                if(token==Tokens.LPar){
                    count=count+1;
                }
                else if(token==Tokens.RPar){
                    count=count-1;
                    if(count==0){
////                        out.println("ohhh");
                        break;
                    }
                }
            }
            if(token==Tokens.NUMBER){
                stackNum.push(new StackElement(EleType.ConstVar,new Num(tokenTrap.getNumber(),"i32"),""));
                getSym();
            }
            else if(token== Tokens.Ident){
                if(tokens.get(idx_t).getToken()==Tokens.LPar){
                    pushFuncIdent(stackNum,stackOp);
                }
                else{
                    pushIdent(stackNum,stackOp);
                }
                getSym();
            }
            else if(isFunc()){
                handleFunc(stackNum,stackOp);
                getSym();
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
                        guiYue(stackNum,stackOp);
                        flag=1;
                    }
                    else {
                        error();
                    }
                }
            }
            isRead= flag != 1;
        }
////        out.println(stackOp.size());
        while (!stackOp.empty()){
            guiYue(stackNum,stackOp);
        }
//        out.println(stackNum.size());
        if (stackNum.size()!=1){
            error();
        }

        return stackNum.pop();
    }
    public StackElement ConstExp(Stack<StackElement> stackNum,Stack<Tokens> stackOp){
        if(token==Tokens.NUMBER){
            stackNum.push(new StackElement(EleType.ConstVar,new Num(tokenTrap.getNumber(),"i32"),""));
        }
        else if(token== Tokens.Ident){
            pushConstIdent(stackNum,stackOp);
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
        while (idx_t< tokens.size()&&token!=Tokens.Semicolon&&token!=Tokens.Comma&&token!=Tokens.RBracket&&token!=Tokens.RBrace){
//////            out.println(token);
            if(token==Tokens.NUMBER){
                stackNum.push(new StackElement(EleType.ConstVar,new Num(tokenTrap.getNumber(),"i32"),""));
                getSym();
            }
            else if(token== Tokens.Ident){
                pushConstIdent(stackNum,stackOp);
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
                        constGuiYue(stackNum,stackOp);
                    }
                    else {
                        error();
                    }
                }
            }
        }
        while (!stackOp.empty()){
            constGuiYue(stackNum,stackOp);
        }
        if (stackNum.size()!=1){
            error();
        }
        return stackNum.pop();
    }
    private void guiYue(Stack<StackElement> stackNum,Stack<Tokens> stackOp) {
        StackElement tmp1;
        String x1;
        switch (stackOp.pop()){
            case BinAdd:{
                calBinOp("add",stackNum,stackOp);
                break;
            }
            case BinDec:{
                calBinOp("sub",stackNum,stackOp);
                break;
            }
            case Mul:{
                calBinOp("mul",stackNum,stackOp);
                break;
            }
            case Div:{
                calBinOp("sdiv",stackNum,stackOp);
                break;
            }
            case Mod:{
                calBinOp("srem",stackNum,stackOp);
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
                    if(tmp1.getType()==EleType.Array){
                        error();
                    }
                    else if(tmp1.getType()==EleType.ConstVar){
                        Num num = tmp1.getNum();
                        num.setNumber(-num.getNumber());
                        stackNum.push(tmp1);
                    }
                    else{
                        x1 = getNumString(tmp1);
                        Var tmp_var = tmp1.getVar();
                        if(tmp_var.getType().equals("i1")){
                            getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = zext i1 ").append(x1).append(" to i32").append("\n");
                            x1 = "%u"+register;
                            register++;
                        }
                        getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = ").append("sub ").append("i32 0, ").append(x1).append("\n");
                        tmp_var = new Var("i32",false);
                        tmp_var.setLoad_register(register,block_idx);
                        stackNum.push(new StackElement(EleType.Var,tmp_var,""+register));
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
                    if(tmp1.getType()==EleType.Array){
                        error();
                    }
                    else if(tmp1.getType()==EleType.ConstVar){
                        Num num = new Num(tmp1.getNum().getNumber()==0?1:0,"i1");
                        stackNum.push(new StackElement(EleType.ConstVar,num,""));
                    }
                    else {
                        x1 = getNumString(tmp1);
                        getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = ").append("icmp eq ")
                                .append(tmp1.getVar().getType()).append(" ").append(x1).append(", 0").append("\n");
                        Var tmp_var = new Var("i1",false);
                        tmp_var.setLoad_register(register,block_idx);
                        stackNum.push(new StackElement(EleType.Var,tmp_var,""+register));
                        register++;
                    }
                }
                break;
            }
            default:
                error();
        }
    }
    private void constGuiYue(Stack<StackElement> stackNum,Stack<Tokens> stackOp) {
        StackElement tmp1;
        StackElement tmp2;
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
    private void pushIdent(Stack<StackElement> stackNum,Stack<Tokens> stackOp) {
        StackElement tmp=null;
        for(int i=top_now;i>=0;i--){
            if(symbolStack[i].getName().equals(tokenTrap.getIdentName())){
                tmp = symbolStack[i];
                break;
            }
        }
        tmp = getArrayElement2(tmp);
////////            out.println(tmp);
        stackNum.push(tmp);
    }
    private boolean pushFuncIdent(Stack<StackElement> stackNum,Stack<Tokens> stackOp) {
        StackElement tmp=null;
        for(int i=top_now;i>=0;i--){
            if(symbolStack[i].getName().equals(tokenTrap.getIdentName())&&symbolStack[i].getType()==EleType.Fun){
                tmp = symbolStack[i];
                break;
            }
        }
        if(tmp==null){
            error();
        }
        getSym();
        assert tmp != null;
        Func func = tmp.getFunc();
        StackElement ret_ele = handleIdentFunc(stackNum,stackOp,func);
        if(func.isHas_return()){
            stackNum.push(ret_ele);
        }
        return func.isHas_return();
    }
    private StackElement getArrayElement(StackElement tmp, int dimen, int i, ArrayList<Integer> shape, String[] location) {
        if(i!=dimen){
            String x1,x2;
            ArrayList<Integer> myShape = new ArrayList<>();
            x1 = "0";
            for(int j=0;j<i;j++){
                Integer mul=1;
                for(int k=j+1;k<dimen;k++){
                    mul*=shape.get(k);
                }
                x2 = location[j];
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = mul i32 ").
                        append(x2).append(", ").append(mul).append("\n");
                register++;
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = add i32 ").
                        append(x1).append(", %u").append(register-1).append("\n");
                x1 = "%u"+register;
                register++;
            }
            for(int j=i;j<dimen;j++){
                myShape.add(shape.get(j));
            }
            Integer mul=1;
            for(int k=0;k<dimen;k++){
                mul*=shape.get(k);
            }
            // %13 = getelementptr i32,i32* %11, i32 %12
            //    %14 = load i32, i32* %13
            String array_address = getNumString(tmp);
            if(tmp.getArray().isFuncParam()){
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = getelementptr i32, i32* ").
                        append(array_address).append(", i32 ").append(x1).append("\n");
            }
            else{
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = getelementptr [").append(mul).
                        append(" x i32],[").append(mul).append(" x i32]* ").
                        append(array_address).append(", i32 0, i32 ").append(x1).append("\n");
            }
            register++;
            MyArray myArray = new MyArray(dimen-i,myShape,false);
            myArray.setTrue_register(register-1);
            StackElement element = new StackElement(EleType.Array,myArray,tmp.getName());
            idx_t--;
            return element;
        }
        else {
            String x1,x2;
            Integer mul=1;
            x1 = location[dimen-1];
            for(int j=dimen-2;j>=0;j--){
                mul*=shape.get(j+1);
                x2 = location[j];
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = mul i32 ").
                        append(x2).append(", ").append(mul).append("\n");
                register++;
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = add i32 ").
                        append(x1).append(", %u").append(register-1).append("\n");
                x1 = "%u"+register;
                register++;
            }
            mul*=shape.get(0);
            // %13 = getelementptr i32,i32* %11, i32 %12
            //    %14 = load i32, i32* %13
            String array_address = getNumString(tmp);
            if(tmp.getArray().isFuncParam()){
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = getelementptr i32, i32* ").
                        append(array_address).append(", i32 ").append(x1).append("\n");
            }
            else{
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = getelementptr [").append(mul).
                        append(" x i32],[").append(mul).append(" x i32]* ").
                        append(array_address).append(", i32 0, i32 ").append(x1).append("\n");
            }
            register++;
            getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = load i32, i32* %u").append(register - 1).append("\n");
            register++;
            Var varr = new Var("i32",false);
            varr.setLoad_register(register-1,block_idx);
            varr.setTrue_register(register-2);
            tmp = new StackElement(EleType.Var,varr,""+(register-1));
            idx_t--;
            return tmp;
        }
    }

    private void pushConstIdent(Stack<StackElement> stackNum,Stack<Tokens> stackOp){
        StackElement tmp=null;
        for(int i=top_now;i>=0;i--){
            if((symbolStack[i].getType()==EleType.ConstVar||symbolStack[i].getType()==EleType.ConstArray) && symbolStack[i].getName().equals(tokenTrap.getIdentName())){
                tmp = symbolStack[i];
                break;
            }
        }
        if(tmp == null){
            error();
        }
        assert tmp != null;
        if(tmp.getType()==EleType.ConstArray){
            getSym();
            MyArray tmpArray= tmp.getArray();
            int dimen = tmpArray.getDimension(),i;
            ArrayList<Integer> shape = tmpArray.getShape();
            String[] location = new String[dimen];
            for(i=0;token==Tokens.LBracket;i++){
                getSym();
                StackElement tmpp = ConstExp(new Stack<>(), new Stack<>());
                location[i] = getNumString32(tmpp);
                if(token!=Tokens.RBracket){
                    error();
                }
                getSym();
            }
            tmp = getArrayElement(tmp, dimen, i, shape, location);
        }
////////            out.println(tmp);
        stackNum.push(tmp);
    }
    //从StackNumEle中提取出变量值或寄存器值
    private String getNumString32(StackElement tmp1){
        String x1;
        if (tmp1.getType()==EleType.ConstVar){
            x1 = ""+tmp1.getNum().getNumber();
        }
        else if(tmp1.getType()==EleType.Array||tmp1.getType()==EleType.ConstArray){
            MyArray array = tmp1.getArray();
            if(array.isGlobal()){
                return " @"+tmp1.getName();
            }
            else {
                return " %u"+array.getTrue_register();
            }
        }
        else {
            Var var = tmp1.getVar();
            x1 = getNumString(tmp1);
            if(var.getType().equals("i1")){
                getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = zext i1 ").append(x1).append(" to i32").append("\n");
                x1 = " %u"+register;
                register++;
            }
//            else {
//                    x1 = " %u"+var.getLoad_register(block_idx);
//            }
        }
        return x1;
    }
    private String getNumString(StackElement tmp1) {
        String x1="";
        Var var1;
        if(tmp1.getType()==EleType.ConstVar){
            x1 = " "+tmp1.getNum().getNumber();
        }
        else if(tmp1.getType()==EleType.Array||tmp1.getType()==EleType.ConstArray){
            MyArray array = tmp1.getArray();
            if(array.isGlobal()){
                return " @"+tmp1.getName();
            }
            else {
                return " %u"+array.getTrue_register();
            }
        }
        else {
            var1 = tmp1.getVar();
            if (var1.getLoad_register(block_idx)==-1||var1.isGlobal()){
                loadRegister(var1);
                x1 = " %u"+var1.getLoad_register(block_idx);
            }
            else {
                x1 = " %u"+var1.getLoad_register(block_idx);
            }
        }
        return x1;
    }
    private String getNumString1(StackElement cond,int block_idx){
        String x1;
        if(cond.getType()==EleType.ConstVar){
            if (cond.getNum().getType().equals("i32")){
                //icmp eq i32 %13, 10
                codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).append(" = icmp ne i32 ").append(cond.getNum().getNumber()).
                        append(", 0").append("\n");
                x1=" %u"+register;
                register++;
            }
            else {
                x1 = " "+cond.getNum().getNumber();
            }
        }
        else {
            String x = getNumString(cond);
            if(cond.getVar().getType().equals("i32")){
                codeBlocks.get(block_idx).getResult().append(CompileUtil.TAB).append("%u").append(register).
                        append(" = icmp ne i32 ").append(x).append(", 0").append("\n");
                x1=" %u"+register;
                register++;
            }
            else {
                x1 = x;
            }
        }
        return x1;
    }
    //规约中的一步操作，根据运算符而略微不同
    private void calBinOp(String op,Stack<StackElement> stackNum,Stack<Tokens> stackOp){
        StackElement tmp1;
        StackElement tmp2;
        String x1,x2;
        if (stackNum.size()<2){
            error();
        }
        else {
            tmp1 = stackNum.pop();
            tmp2 = stackNum.pop();
            if(tmp1.getType()==EleType.Array||tmp2.getType()==EleType.Array){
                error();
            }
////            out.println("OK:"+tmp1.getVar().getLoad_register(block_idx));
            x1 = getNumString(tmp1);
            x2 = getNumString(tmp2);
            getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = ").append(op).append(" ").
                    append("i32 ").append(x2).append(", ").append(x1).append("\n");
            Var tmp_var = new Var("i32",false);
            tmp_var.setLoad_register(register,block_idx);
            stackNum.push(new StackElement(EleType.Var,tmp_var,""+register));
            register++;
        }
    }

    //中间代码生成系列：为变量load一个新的寄存器
    private void loadRegister(Var var){
        var.setLoad_register(register,block_idx);
        if(var.isGlobal()){
            getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = load ").
                    append(var.getType()).append(", ").append(var.getType()).
                    append("* @").append(var.getName()).append("\n");
        }
        else {
            getBlock().append(CompileUtil.TAB).append("%u").append(register).append(" = load ").
                    append(var.getType()).append(", ").append(var.getType()).
                    append("* %u").append(var.getTrue_register()).append("\n");
        }
        register++;
    }
    //中间代码生成系列：为寄存器store一个新的值
    private void storeRegister(Var var, StackElement tmp2){
        String x = getNumString(tmp2);
        if(var.isGlobal()){
            getBlock().append(CompileUtil.TAB).append("store i32 ").append(x).
                    append(", ").append(var.getType()).append("* @").append(var.getName()).append("\n");
        }
        else{
            getBlock().append(CompileUtil.TAB).append("store i32 ").append(x).
                    append(", ").append(var.getType()).append("* %u").append(var.getTrue_register()).append("\n");
        }
    }
    public boolean isCompare(){
        return token==Tokens.GT ||token==Tokens.Ge||token==Tokens.LT ||token==Tokens.Le;
    }
    public int getShapeAndTotal(ArrayList<Integer> shape){
        int i,total=1;
        for(i=0;token==Tokens.LBracket;i++){
            getSym();
            StackElement tmpp = ConstExp(new Stack<>(), new Stack<>());
            total*=tmpp.getNum().getNumber();
            shape.add(tmpp.getNum().getNumber());
            if(token!=Tokens.RBracket){
                error();
            }
            getSym();
        }
        return total;
    }
    public StringBuffer getBlock(){
        return codeBlocks.get(block_idx).getResult();
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
//////        System.out.println(String.valueOf(grammarAnalyze.result));
        ArrayList<CodeBlock> codes = grammarAnalyze.codeBlocks;
        out.write(String.valueOf(codes.get(0).getResult()));
        for(int i=1;i<codes.size();i++){
            CodeBlock codeBlock = codes.get(i);
            out.write("\n"+codeBlock.getRegister()+":\n");
            out.write(String.valueOf(codeBlock.getResult()));
        }

        out.close();
    }
}
