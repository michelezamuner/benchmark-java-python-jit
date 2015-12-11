public class Test
{
  public static void main(String[] args)
  {
    final long MOD = 1000000;
    final long TOT = MOD * 10;
    final long START = System.currentTimeMillis();
    double current = 0;

    for (long i = 0; i < TOT; i++)
    {
      if (i % MOD == 0) {
        double newcurrent = (System.currentTimeMillis() - (double)START) / 1000;
        System.out.println(newcurrent - current);
        current = newcurrent;
      }
    }
    System.out.println();
    final long END = System.currentTimeMillis();

    System.out.println("Elapsed: " + (END - START));
  }
}
