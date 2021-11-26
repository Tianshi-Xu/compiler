import java.util.ArrayList;

public class CodeBlock {
    private String register;
    private StringBuffer result;

    public CodeBlock(String register, StringBuffer result) {
        this.register = register;
        this.result = result;
    }

    public String getRegister() {
        return register;
    }

    public void setRegister(String register) {
        this.register = register;
    }

    public StringBuffer getResult() {
        return result;
    }

    public void setResult(StringBuffer result) {
        this.result = result;
    }

    public void setResult(String s) {
    }
}
