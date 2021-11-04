public class StackNumEle {
    private boolean isNumber;
    private Integer number;
    private Var var;

    public StackNumEle(boolean isNumber, Integer number) {
        this.isNumber = isNumber;
        this.number = number;
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

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Var getVar() {
        return var;
    }

    public void setVar(Var var) {
        this.var = var;
    }
}
