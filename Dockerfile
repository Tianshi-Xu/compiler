FROM openjdk:8
WORKDIR /app/
COPY lab06/* ./
RUN javac GrammarAnalyze.java

 

