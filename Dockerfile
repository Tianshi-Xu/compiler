FROM openjdk:8
WORKDIR /app/
COPY llab10/* ./
RUN javac GrammarAnalyze.java

 

