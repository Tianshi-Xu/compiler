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
    private ArrayList<Tokens> tokens = new ArrayList<>();
    private ArrayList<Integer> numbers = new ArrayList<>();
    private String keyWord[] = {"int","return","main"};
    private HashMap<Integer, Tokens> keyWordMap = new HashMap<>();
    private char ch;
    private StringBuilder chars = new StringBuilder();
    public WordAnalyze(){
        keyWordMap.put(0,Tokens.INT);
        keyWordMap.put(1,Tokens.RETURN);
        keyWordMap.put(2,Tokens.MAIN);
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
                        error();
                    }
                }
                else if(isLetter(ch)){
                    while(isLetter(ch)){
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
                            tokens.add(keyWordMap.get(j));
                            flag=0;
                            break;
                        }
                    }
                    if(flag==1){
                        //标识符
                        error();
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
                                tokens.add(Tokens.NUMBER);
                                numbers.add(Integer.parseInt(String.valueOf(arr), 16));
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
                                tokens.add(Tokens.NUMBER);
                                numbers.add(Integer.parseInt(String.valueOf(arr), 8));
                            }
                            i--;
                        }
                        else {
                            tokens.add(Tokens.NUMBER);
                            numbers.add(0);
                        }
                    }
                    else {
                        while(isDigit(ch))
                        {
                            arr.append(ch);
                            ch = chars.charAt(++i);
                        }
                        tokens.add(Tokens.NUMBER);
                        numbers.add(Integer.parseInt(String.valueOf(arr), 10));
                        i--;
                    }
                    //属于无符号常数
                }
                else switch(ch){
                        //运算符
                        case '(':tokens.add(Tokens.LPar);break;
                        case ')':tokens.add(Tokens.RPar);break;
                        case ';':tokens.add(Tokens.Semicolon);break;
                        case '{':tokens.add(Tokens.LBrace);break;
                        case '}':tokens.add(Tokens.RBrace);break;
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

    public ArrayList<Tokens> getTokens() {
        return tokens;
    }

    public ArrayList<Integer> getNumbers() {
        return numbers;
    }

    public String[] getKeyWord() {
        return keyWord;
    }

    public HashMap<Integer, Tokens> getKeyWordMap() {
        return keyWordMap;
    }

    public char getCh() {
        return ch;
    }
}