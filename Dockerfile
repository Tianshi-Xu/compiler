FROM openjdk:8
WORKDIR /app/
COPY llab09/* ./
RUN javac GrammarAnalyze.java

 

