#!/usr/bin/env bash

function run-j {
  local readonly msg="${1}"
  local readonly cmd="${2}"

  javac Test.java
  printf "%s" "${msg}"
  ${cmd} Test
  printf "\n"
}

function run-py {
  local readonly msg="${1}"
  local readonly cmd="${2}"

  printf "%s" "${msg}"
  ${cmd} test.py
  printf "\n"
}

function run-php {
  local readonly msg="${1}"
  local readonly cmd="${2}"

  printf "%s" "${msg}"
  ${cmd} test.php
  printf "\n"
}

run-j "Java with JIT:" "java"
run-j "Java without JIT:" "java -Xint"
run-py "Python:" "python"
run-py "Pypy:" "pypy"
run-php "PHP 5:" "php"
run-php "PHP 7:" "php7"
#run-py "Jython with JIT:" "jython"
#run-py "Jython without JIT:" "jython -J-Xint"
