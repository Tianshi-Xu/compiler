FROM openjdk:8
WORKDIR /app/
COPY lab07/* ./
RUN javac GrammarAnalyze.java

 

