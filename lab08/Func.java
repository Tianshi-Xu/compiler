import java.util.ArrayList;

public class Func {
    private String name;
    private ArrayList<StackElement> params;
    private boolean has_return;

    public Func(String name, ArrayList<StackElement> params, boolean has_return) {
        this.name = name;
        this.params = params;
        this.has_return = has_return;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public ArrayList<StackElement> getParams() {
        return params;
    }

    public void setParams(ArrayList<StackElement> params) {
        this.params = params;
    }

    public boolean isHas_return() {
        return has_return;
    }

    public void setHas_return(boolean has_return) {
        this.has_return = has_return;
    }
}
