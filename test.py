import sys, time

def currentTimeMillis():
  return int(round(time.time() * 1000))

def lprintln(msg = ''):
  sys.stdout.write(str(msg) + '\n')
  sys.stdout.flush()

MOD = 1000000
TOT = MOD * 10
START = currentTimeMillis()

current = 0

for i in range(0, TOT):
  if i % MOD == 0:
    newcurrent = (currentTimeMillis() - START) / 1000.0
    lprintln(newcurrent - current)
    current = newcurrent

lprintln()

END = currentTimeMillis()

lprintln("Elapsed: " + str(END - START))
