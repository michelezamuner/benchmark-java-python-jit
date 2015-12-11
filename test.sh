#!/usr/bin/env bash
javac Test.java

printf "%s\n" "Java with JIT:"
java Test

printf "%s\n" "Java without JIT:"
java -Xint Test

printf "%s\n" "Python:"
python test.py

printf "%s\n" "Jython with JIT:"
jython test.py

printf "%s\n" "Jython without JIT:"
jython -J-Xint test.py
