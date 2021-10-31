import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;

import static java.lang.System.err;
import static java.lang.System.exit;

/**
 * 此程序是通过将文件的字符读取到字符数组中去，然后遍历数组，将读取的字符进行
 * 分类并输出
 * @author
 *
 */
public class WordAnalyze {
    private final ArrayList<TokenTrap> tokens = new ArrayList<>();
    private final String[] keyWord = {"int","return","main","const"};
    private final ArrayList<Tokens> keyWordList = new ArrayList<>();
    private char ch;
    private final StringBuilder chars = new StringBuilder();
    public WordAnalyze(){
        keyWordList.add(Tokens.INT);
        keyWordList.add(Tokens.RETURN);
        keyWordList.add(Tokens.MAIN);
        keyWordList.add(Tokens.CONST);
    }
    //判断是否是字母
    boolean isLetter(char letter)
    {
        return (letter >= 'a' && letter <= 'z') || (letter >= 'A' && letter <= 'Z');
    }
    //判断是否是数字
    boolean isDigit(char digit)
    {
        return digit >= '0' && digit <= '9';
    }
    boolean isDigit8(char digit)
    {
        return digit >= '0' && digit <= '7';
    }
    boolean isDigit16(char digit){
        return (digit >= '0' && digit <= '9')||(digit >= 'A' && digit <= 'F')||(digit >= 'a' && digit <= 'f');
    }
    public void readFile(String path) throws Exception
    {
        File file = new File(path);
        Reader reader = new InputStreamReader(new FileInputStream(file));
        int tempchar;
        while ((tempchar = reader.read()) != -1) {
            // 对于windows下，\r\n这两个字符在一起时，表示一个换行。
            // 但如果这两个字符分开显示时，会换两次行。
            // 因此，屏蔽掉\r，或者屏蔽\n。否则，将会多出很多空行。
            if (((char) tempchar) != '\r') {
                chars.append((char)tempchar);
            }
        }
        System.out.println(chars);
        reader.close();
    }
    //词法分析
    void analyze() {
        try {
            for (int i = 0; i < chars.length(); i++) {
                StringBuilder arr = new StringBuilder();
                ch = chars.charAt(i);
                if (ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r') {
                }
                else if(ch=='/'){
                    i++;
                    if(chars.charAt(i)=='/'){
                        i++;
                        while (i<chars.length()&&chars.charAt(i) != '\n'){
                            i++;
                        };
                    }
                    else if(chars.charAt(i)=='*'){
                        i++;
                        while (true){
                            while (i<chars.length()&&chars.charAt(i)!='*'){
                                i++;
                            }
                            i++;
                            if(i>= chars.length()){
                                error();
                            }
                            else if(chars.charAt(i)=='/'){
                                break;
                            }
                        }
                    }
                    else {
                        tokens.add(new TokenTrap(Tokens.Div));
                    }
                }
                else if(isLetter(ch)||ch=='_'){
                    while(isLetter(ch)||isDigit(ch)||ch=='_'){
                        arr.append(ch);
                        i++;
                        ch = chars.charAt(i);
                    }
                    //回退一个字符
                    i--;
                    int flag=1;
                    for (int j=0;j<keyWord.length;j++) {
                        if (keyWord[j].equals(arr.toString())){
                            //关键字
                            tokens.add(new TokenTrap(keyWordList.get(j)));
                            flag=0;
                            break;
                        }
                    }
                    if(flag==1){
                        //标识符
                        tokens.add(new TokenTrap(Tokens.Ident,String.valueOf(arr)));
                    }
                }
                else if(isDigit(ch))
                {
                    if(ch == '0'){
                        i++;
                        if(i<chars.length()){
                            if(chars.charAt(i)=='x'||chars.charAt(i)=='X'){
                                i++;
                                ch = chars.charAt(i);
                                while(isDigit16(ch))
                                {
                                    arr.append(ch);
                                    ch = chars.charAt(++i);
                                }
                                tokens.add(new TokenTrap(Tokens.NUMBER,Integer.valueOf(String.valueOf(arr), 16)));
                            }
                            else {
                                arr.append(chars.charAt(i));
                                i++;
                                ch = chars.charAt(i);
                                while(isDigit8(ch))
                                {
                                    arr.append(ch);
                                    ch = chars.charAt(++i);
                                }
                                tokens.add(new TokenTrap(Tokens.NUMBER,Integer.valueOf(String.valueOf(arr), 8)));
                            }
                            i--;
                        }
                        else {
                            tokens.add(new TokenTrap(Tokens.NUMBER,0));
                        }
                    }
                    else {
                        while(isDigit(ch))
                        {
                            arr.append(ch);
                            ch = chars.charAt(++i);
                        }
                        tokens.add(new TokenTrap(Tokens.NUMBER,Integer.parseInt(String.valueOf(arr), 10)));
                        i--;
                    }
                    //属于无符号常数
                }
                else switch(ch){
                        //运算符
                        case '(':tokens.add(new TokenTrap(Tokens.LPar));break;
                        case ')':tokens.add(new TokenTrap(Tokens.RPar));break;
                        case ';':tokens.add(new TokenTrap(Tokens.Semicolon));break;
                        case '{':tokens.add(new TokenTrap(Tokens.LBrace));break;
                        case '}':tokens.add(new TokenTrap(Tokens.RBrace));break;
                        case '+':{
                            if (tokens.isEmpty()){
                                error();
                            }
                            else if (tokens.get(tokens.size()-1).getToken()==Tokens.NUMBER||tokens.get(tokens.size()-1).getToken()==Tokens.RPar||tokens.get(tokens.size()-1).getToken()==Tokens.Ident){
                                tokens.add(new TokenTrap(Tokens.BinAdd));
                            }
                            else {
                                tokens.add(new TokenTrap(Tokens.UnaryOpAdd));
                            }
                            break;
                        }
                        case '-':{
                            if (tokens.isEmpty()){
                                error();
                            }
                            else if (tokens.get(tokens.size()-1).getToken()==Tokens.NUMBER||tokens.get(tokens.size()-1).getToken()==Tokens.RPar||tokens.get(tokens.size()-1).getToken()==Tokens.Ident){
                                tokens.add(new TokenTrap(Tokens.BinDec));
                            }
                            else {
                                tokens.add(new TokenTrap(Tokens.UnaryOpDec));
                            }
                            break;
                        }
                        case '*':tokens.add(new TokenTrap(Tokens.Mul));break;
                        case '%':tokens.add(new TokenTrap(Tokens.Mod));break;
                        case '=':tokens.add(new TokenTrap(Tokens.Equal));break;
                        case ',':tokens.add(new TokenTrap(Tokens.Comma));break;
                        default: {
                            error();
                        }
                    }
            }
        }
        catch (Exception e){
            error();
        }
    }
    public void error() {
        exit(1);
    }

    public ArrayList<TokenTrap> getTokens() {
        return tokens;
    }


    public String[] getKeyWord() {
        return keyWord;
    }


    public char getCh() {
        return ch;
    }
}