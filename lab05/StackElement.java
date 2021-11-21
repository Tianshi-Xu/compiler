public class StackElement {
    private EleType type;
    private Var var;
    private Num num;
    private String name;

    public StackElement(EleType type, Num num, String name) {
        this.type = type;
        this.num = num;
        this.name=name;
    }

    public StackElement(EleType type, Var var, String name) {
        this.type = type;
        this.var = var;
        this.name=name;
    }

    public EleType getType() {
        return type;
    }

    public void setIsNumber(EleType number) {
        type = number;
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

    public void setType(EleType type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
