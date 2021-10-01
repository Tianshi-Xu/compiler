import java.io.File;
import java.io.FileReader;

/**
 * 此程序是通过将文件的字符读取到字符数组中去，然后遍历数组，将读取的字符进行
 * 分类并输出
 * @author
 *
 */
public class WordAnalyze {
    private String keyWord[] = {"break","return","continue","if","else","while"};
    private char ch;
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
    //词法分析
    void analyze(char[] chars)
    {
        for(int i = 0;i< chars.length;i++) {
            StringBuilder arr = new StringBuilder();
            ch = chars[i];
            if(ch == ' '||ch == '\t'||ch == '\n'||ch == '\r'){
            }
            else if(isLetter(ch)||ch=='_'){
                while(isLetter(ch)||isDigit(ch)||ch=='_'){
                    arr.append(ch);
                    ch = chars[++i];
                }
                //回退一个字符
                i--;
                int flag=1;
                for (String s : keyWord) {
                    if (s.equals(arr.toString())){
                        //关键字
                        System.out.println(Character.toUpperCase(s.charAt(0))+s.substring(1));
                        flag=0;
                        break;
                    }

                }
                if(flag==1){
                    //标识符
                    System.out.println("Ident("+arr+")");
                }
            }
            else if(isDigit(ch))
            {
                while(isDigit(ch))
                {
                    arr.append(ch);
                    ch = chars[++i];
                }
                i--;
                //属于无符号常数
                System.out.println("Number("+arr+")");
            }
            else switch(ch){
                    //运算符
                    case '+':System.out.println("Plus");break;
                    case '*':System.out.println("Mult");break;
                    case '/':System.out.println("Div");break;
                    //分界符
                    case '(':System.out.println("LPar");break;
                    case ')':System.out.println("RPar");break;
                    case ';':System.out.println("Semicolon");break;
                    case '{':System.out.println("LBrace");break;
                    case '}':System.out.println("RBrace");break;
                    //运算符
                    case '=':{
                        ch = chars[++i];
                        if(ch == '=')System.out.println("Eq");
                        else {
                            System.out.println("Assign");
                            i--;
                        }
                        break;
                    }
                    case '>':System.out.println("Gt");break;
                    case '<':System.out.println("Lt");break;
                    //无识别
                    default: {
                        System.out.println("Err");
                        return;
                    }
                }
        }
    }
    public static void main(String[] args) throws Exception {
        File file = new File(args[0]);//定义一个file对象，用来初始化FileReader
        FileReader reader = new FileReader(file);//定义一个fileReader对象，用来初始化BufferedReader
        int length = (int) file.length();
        //这里定义字符数组的时候需要多定义一个,因为词法分析器会遇到超前读取一个字符的时候，如果是最后一个
        //字符被读取，如果在读取下一个字符就会出现越界的异常
        char buf[] = new char[length];
        reader.read(buf);
        reader.close();
        new WordAnalyze().analyze(buf);
    }
}