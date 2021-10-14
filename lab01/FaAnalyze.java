
import java.util.ArrayList;
import java.util.TreeMap;

import static java.lang.System.*;

public class FaAnalyze {
    private WordAnalyze wordAnalyze = new WordAnalyze();
    private ArrayList<Tokens> tokens;
    private ArrayList<Integer> numbers;
    private Tokens token;
    private StringBuilder result = new StringBuilder();
    private int idx_t=0;
    private int idx_n=0;
    public void analyze(String path) throws Exception {
        wordAnalyze.readFile(path);
        wordAnalyze.analyze();
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
        out.print(1);
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

        if(token!=Tokens.NUMBER){
            error();
        }
        result.append("i32 ").append(numbers.get(idx_n++));
//        System.out.print("i32 "+numbers.get(idx_n++));
        getSym();
        if(token!=Tokens.Semicolon){
            error();
        }
        getSym();
    }
    public void error(){
        exit(1);
    }
    public void getSym(){
        token = tokens.get(idx_t++);

    }
    public static void main(String[] args) throws Exception {
        FaAnalyze faAnalyze = new FaAnalyze();
        faAnalyze.analyze(args[0]);
    }
}
