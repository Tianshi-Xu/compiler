FROM openjdk:8
WORKDIR /app/
COPY ./01_wordAnalysis/* ./
RUN javac WordAnalyze.java
