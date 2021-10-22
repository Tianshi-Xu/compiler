
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Stack;

import static java.lang.System.*;

public class GrammarAnalyze {
    private WordAnalyze wordAnalyze = new WordAnalyze();
    private ArrayList<Tokens> tokens;
    private ArrayList<Integer> numbers;
    private final Stack<Integer> stackNum;
    private final Stack<Tokens> stackOp;
    private final short[][] priority;
    private Tokens token;
    private StringBuilder result = new StringBuilder();
    private int idx_t=0;
    private int idx_n=0;
    public GrammarAnalyze(){
        stackNum = new Stack<>();
        stackOp = new Stack<>();
        //0是小于，1是大于，-1是相等，-2是错误
        priority = new short[][]{
                {1,1,0,0,0,0,0,0,1,0},{1,1,0,0,0,0,0,0,1,0},
                {1,1,0,0,1,1,1,0,1,0},{1,1,0,0,1,1,1,0,1,0},
                {1,1,0,0,1,1,1,0,1,0},{1,1,0,0,1,1,1,0,1,0},
                {1,1,0,0,1,1,1,0,1,0},{0,0,0,0,0,0,0,0,-1,0},
                {1,1,-2,-2,1,1,1,-2,1,-2},{1,1,-2,-2,1,1,1,-2,1,-2},
        };
    }
    public void analyze(String path) throws Exception {
        wordAnalyze.readFile(path);
        wordAnalyze.analyze();
//        out.print("OK1");
        tokens = wordAnalyze.getTokens();
        numbers = wordAnalyze.getNumbers();

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
        Ident();
        if(token!=Tokens.LPar){
            error();
        }
        result.append('(');
//        System.out.print("(");
        getSym();
        if(token!=Tokens.RPar){
            error();
        }
        result.append(") ");
//        System.out.print(") ");
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
//        System.out.print("define dso_local i32 ");
        getSym();
    }
    public void Ident(){
        if(token!=Tokens.MAIN){
            error();
        }
        result.append("@main");
//        System.out.print("@main");
        getSym();
    }
    public void Block(){
        if(token!=Tokens.LBrace){
            error();
        }
        result.append("{ ");
//        System.out.print("{ ");
        getSym();

        Stmt();
        if(token!=Tokens.RBrace){
            error();
        }
        result.append(" }");
//        System.out.print(" }");
    }
    public void Stmt(){
        if(token!=Tokens.RETURN){
            error();
        }
        result.append("ret ");
//        System.out.print("ret ");
        getSym();
        calculation();
//        System.out.print("i32 "+numbers.get(idx_n++));
    }
    public void calculation(){
//        out.println(token);
        if(token==Tokens.NUMBER){
            stackNum.push(numbers.get(idx_n++));
        }
        else if(token.ordinal()>9){
            error();
        }
        else {
            stackOp.push(token);
        }
        getSym();
        while (idx_t< tokens.size()&&token!=Tokens.Semicolon){
//            out.println(token);
            if(token.ordinal()>9){
                error();
            }
            else if(token==Tokens.NUMBER){
                stackNum.push(numbers.get(idx_n++));
                getSym();
            }
            else if(stackOp.empty()) {
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
                    guiYue();
//                    out.println("---");
//                    out.println(stackNum.peek());
//                    out.println(stackNum.size());
//                    out.println(stackOp.peek());
//                    out.println("---");
                }
                else {
                    error();
                }
            }
        }

        if (token!=Tokens.Semicolon){
            error();
        }
        else {
            while (!stackOp.empty()){
                guiYue();
            }
            if (stackNum.size()!=1){
                error();
            }
            else {
                result.append("i32 ").append(stackNum.pop());
            }
        }
        getSym();
    }

    private void guiYue() {
        switch (stackOp.pop()){
            case BinAdd:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    int tmp = stackNum.pop();
                    tmp += stackNum.pop();
                    stackNum.push(tmp);
                }
                break;
            }
            case BinDec:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    int tmp = stackNum.pop();
                    tmp = stackNum.pop()-tmp;
                    stackNum.push(tmp);
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
                    int tmp = stackNum.pop();
                    tmp = -tmp;
                    stackNum.push(tmp);
                }
                break;
            }
            case Mul:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    int tmp = stackNum.pop();
                    tmp *= stackNum.pop();
                    stackNum.push(tmp);
                }
                break;
            }
            case Div:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    int tmp = stackNum.pop();
                    if (tmp==0){
                        error();
                    }
                    tmp = stackNum.pop()/tmp;
                    stackNum.push(tmp);
                }
                break;
            }
            case Mod:{
                if (stackNum.size()<2){
                    error();
                }
                else {
                    int tmp = stackNum.pop();
                    if (tmp==0){
                        error();
                    }
                    tmp = stackNum.pop()%tmp;
                    stackNum.push(tmp);
                }
                break;
            }
        }
    }

    public void error(){
        exit(1);
    }
    public void getSym(){
        if(idx_t==tokens.size()){
            error();
        }
        token = tokens.get(idx_t++);
    }
    public static void main(String[] args) throws Exception {
        GrammarAnalyze grammarAnalyze = new GrammarAnalyze();
        grammarAnalyze.analyze(args[0]);
        BufferedWriter out = new BufferedWriter(new FileWriter(args[1]));
        out.write(String.valueOf(grammarAnalyze.result));
        out.close();
    }
}
