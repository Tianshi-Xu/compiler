import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * 此程序是通过将文件的字符读取到字符数组中去，然后遍历数组，将读取的字符进行
 * 分类并输出
 * @author
 *
 */
public class WordAnalyze {
    private Tokens tokens ;
    private Integer numbers ;
    private String keyWord[] = {"int","return","main"};
    private HashMap<Integer, Tokens> keyWordMap = new HashMap<>();
    private int i=0;
    private char ch;
    private char[] chars;
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
        File file = new File(path);//定义一个file对象，用来初始化FileReader
        FileReader reader = null;//定义一个fileReader对象，用来初始化BufferedReader
        reader = new FileReader(file);
        int length = (int) file.length();
        chars = new char[length];
        reader.read(chars);
        reader.close();
    }
    //词法分析
    int analyze ()
    {
        if(i>=chars.length){
            return -1;
        }
        StringBuilder arr = new StringBuilder();
        ch = chars[i];
        while (ch == ' '||ch == '\t'||ch == '\n'||ch == '\r'){
            System.out.print(ch);
            ch = chars[++i];
        }
        if(ch=='/'){
            if(chars[i+1]=='/'){
                i++;
                while (chars[++i] != '\n');
            }
            else if(chars[i+1]=='*'){
                i+=2;
                while (i<chars.length&&chars[i]!='*'){
                    i++;
                }
                i++;
                if(i>= chars.length||chars[i]!='/'){
                    return 1;
                }
                i++;
            }
            else {
                return 1;
            }
        }
        ch=chars[i];
        while (ch == ' '||ch == '\t'||ch == '\n'||ch == '\r'){
            System.out.print(ch);
            ch = chars[++i];
        }
        if(isLetter(ch)){
            while(isLetter(ch)){
                arr.append(ch);
                ch = chars[++i];
            }
            //回退一个字符
            i--;
            int flag=1;
            for (int j=0;j<keyWord.length;j++) {
                if (keyWord[j].equals(arr.toString())){
                    //关键字
                    tokens=keyWordMap.get(j);
                    flag=0;
                    break;
                }
            }
            if(flag==1){
                //标识符
                return 1;
            }
        }
        else if(isDigit(ch))
        {
            if(ch == '0'){
                if(i+1<chars.length){
                    if(chars[i+1]=='x'||chars[i+1]=='X'){
                        i+=2;
                        ch = chars[i];
                        while(isDigit16(ch))
                        {
                            arr.append(ch);
                            ch = chars[++i];
                        }
                        tokens=Tokens.NUMBER;
                        numbers=Integer.parseInt(String.valueOf(arr), 16);
                        i--;
                    }
                    else {
                        arr.append(ch);
                        i++;
                        ch = chars[i];
                        while(isDigit8(ch))
                        {
                            arr.append(ch);
                            ch = chars[++i];
                        }
                        tokens=Tokens.NUMBER;
                        numbers=Integer.parseInt(String.valueOf(arr), 8);
                        i--;
                    }
                }
                else {
                    tokens=Tokens.NUMBER;
                    numbers=0;
                }
            }
            else {
                while(isDigit(ch))
                {
                    arr.append(ch);
                    ch = chars[++i];
                }
                tokens=Tokens.NUMBER;
                numbers=Integer.parseInt(String.valueOf(arr), 10);
                i--;
            }
            //属于无符号常数
        }
        else switch(ch){
                //运算符
                case '(':tokens=Tokens.LPar;break;
                case ')':tokens=Tokens.RPar;break;
                case ';':tokens=Tokens.Semicolon;break;
                case '{':tokens=Tokens.LBrace;break;
                case '}':tokens=Tokens.RBrace;break;
                default: {
                    return 1;
                }
            }
        i++;
        return 0;
    }
    public Tokens getTokens() {
        return tokens;
    }

    public Integer getNumbers() {
        return numbers;
    }

    public char[] getChars() {
        return chars;
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