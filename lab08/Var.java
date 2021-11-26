import java.util.Arrays;

public class Var {
    //被分配空间寄存器
    protected int true_register;
    //值被加载出去的寄存器
    protected int[] load_register;

    protected int func_register;

    protected boolean isFuncParam=false;

    protected final boolean isGlobal;

    protected String name;

    protected String type;
    public Var(String type, boolean isGlobal){
        this.type= type;
        load_register=new int[10000];
        Arrays.fill(load_register, -1);
        true_register=-1;
        this.isGlobal=isGlobal;
    }

    public boolean isGlobal() {
        return isGlobal;
    }

    public int getTrue_register() {
        return true_register;
    }

    public void setTrue_register(int true_register) {
        this.true_register = true_register;
    }

    public int getLoad_register(int i) {
        return load_register[i];
    }

    public void setLoad_register(int register,int i) {
        this.load_register[i] = register;
    }


    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public boolean isFuncParam() {
        return isFuncParam;
    }

    public void setFuncParam(boolean funcParam) {
        isFuncParam = funcParam;
    }

    public int getFunc_register() {
        return func_register;
    }

    public void setFunc_register(int func_register) {
        this.func_register = func_register;
    }
}
