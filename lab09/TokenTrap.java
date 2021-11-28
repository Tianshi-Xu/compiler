public class TokenTrap {
    private Tokens token;
    private Integer number;
    private String identName;

    public TokenTrap(Tokens token, Integer number) {
        this.token = token;
        this.number = number;
    }

    public TokenTrap(Tokens token, String identName) {
        this.token = token;
        this.identName = identName;
    }
    @Override
    public String toString(){
        return "token:" +token+"\nnumber:"+number+"\nidentName:"+identName;
    }

    public TokenTrap(Tokens token) {
        this.token = token;
    }
    public TokenTrap(TokenTrap trap){
        this.token=trap.getToken();
        this.number=trap.getNumber();
        this.identName=trap.getIdentName();
    }

    public Tokens getToken() {
        return token;
    }

    public void setToken(Tokens token) {
        this.token = token;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public String getIdentName() {
        return identName;
    }

    public void setIdentName(String identName) {
        this.identName = identName;
    }
}
