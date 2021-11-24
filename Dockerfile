FROM openjdk:8
WORKDIR /app/
COPY lab08/* ./
RUN javac GrammarAnalyze.java

 

