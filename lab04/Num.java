public class Num {
    private String type;
    private Integer number;

    public Num(Integer number, String type){
        this.type=type;
        this.number=number;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }
}
