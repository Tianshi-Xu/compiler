FROM openjdk:8
WORKDIR /app/
COPY ./lab01/* ./
RUN javac FaAnalyze.java Tokens.java WordAnalyze.java 

