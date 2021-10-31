public class Var {
    //被分配空间寄存器
    private int true_register;
    //值被加载出去的寄存器
    private int load_register;

    private String type;

    public Var(){
        type="i32";
        load_register=-1;
        true_register=-1;
    }

    public int getTrue_register() {
        return true_register;
    }

    public void setTrue_register(int true_register) {
        this.true_register = true_register;
    }

    public int getLoad_register() {
        return load_register;
    }

    public void setLoad_register(int load_register) {
        this.load_register = load_register;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
