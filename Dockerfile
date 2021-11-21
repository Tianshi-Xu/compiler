FROM openjdk:8
WORKDIR /app/
COPY lab04/* ./
RUN javac GrammarAnalyze.java

 

