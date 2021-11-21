FROM openjdk:8
WORKDIR /app/
COPY lab05/* ./
RUN javac GrammarAnalyze.java

 

