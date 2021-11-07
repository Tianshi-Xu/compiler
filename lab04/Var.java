import java.util.Arrays;

public class Var {
    //被分配空间寄存器
    private int true_register;
    //值被加载出去的寄存器
    private int[] load_register;

    private String type;
    public Var(String type){
        this.type= type;
        load_register=new int[10000];
        Arrays.fill(load_register, -1);
        true_register=-1;
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
}
