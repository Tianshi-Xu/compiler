import java.util.ArrayList;
import java.util.Arrays;

public class MyArray{
    private int dimension;
    private ArrayList<Integer> shape;
    private boolean isGlobal;
    private String name;
    protected int true_register;
    private boolean isFuncParam=false;


    public MyArray(int dimension, ArrayList<Integer> shape,boolean isGlobal) {
        this.dimension = dimension;
        this.shape = shape;
        this.isGlobal = isGlobal;
        true_register=-1;
    }

    public int getDimension() {
        return dimension;
    }

    public void setDimension(int dimension) {
        this.dimension = dimension;
    }

    public ArrayList<Integer> getShape() {
        return shape;
    }

    public void setShape(ArrayList<Integer> shape) {
        this.shape = shape;
    }

    public boolean isGlobal() {
        return isGlobal;
    }

    public void setGlobal(boolean global) {
        isGlobal = global;
    }
    public int getTrue_register() {
        return true_register;
    }

    public void setTrue_register(int true_register) {
        this.true_register = true_register;
    }

    public boolean isFuncParam() {
        return isFuncParam;
    }

    public void setFuncParam(boolean funcParam) {
        isFuncParam = funcParam;
    }
}
