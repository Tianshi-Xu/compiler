FROM openjdk:8
WORKDIR /app/
COPY lab03/* ./
RUN javac GrammarAnalyze.java Tokens.java WordAnalyze.java StackNumEle.java TokenTrap.java Var.java

 

