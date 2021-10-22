FROM openjdk:8
WORKDIR /app/
COPY lab02/* ./
RUN javac GrammarAnalyze.java Tokens.java WordAnalyze.java

