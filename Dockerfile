FROM openjdk:8
WORKDIR /app/
COPY lab04/* ./
RUN javac GrammarAnalyze.java Tokens.java WordAnalyze.java StackNumEle.java TokenTrap.java Var.java

 

