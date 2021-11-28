public class StackNumEle {
    private boolean isNumber;
    private Var var;
    private Num num;

    public StackNumEle(boolean isNumber, Num num) {
        this.isNumber = isNumber;
        this.num = num;
    }

    public StackNumEle(boolean isNumber, Var var) {
        this.isNumber = isNumber;
        this.var = var;
    }

    public boolean isNumber() {
        return isNumber;
    }

    public void setIsNumber(boolean number) {
        isNumber = number;
    }

    public Var getVar() {
        return var;
    }

    public void setVar(Var var) {
        this.var = var;
    }

    public Num getNum() {
        return num;
    }

    public void setNum(Num num) {
        this.num = num;
    }
}
