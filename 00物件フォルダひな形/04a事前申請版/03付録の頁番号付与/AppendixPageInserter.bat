chcp 65001
java -jar AppendixPageInserter-jar-with-dependencies.jar
del preprocess1.pdf
del preprocess2.pdf
move *_numbered.pdf ../
pause