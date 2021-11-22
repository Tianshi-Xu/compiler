public class Array {
    private int dimension;
    private int[] shape;

    public Array(int dimension, int[] shape) {
        this.dimension = dimension;
        this.shape = shape;
    }

    public int getDimension() {
        return dimension;
    }

    public void setDimension(int dimension) {
        this.dimension = dimension;
    }

    public int[] getShape() {
        return shape;
    }

    public void setShape(int[] shape) {
        this.shape = shape;
    }
}
