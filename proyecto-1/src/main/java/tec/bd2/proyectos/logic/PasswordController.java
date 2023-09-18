package tec.bd2.proyectos.logic;

public class PasswordController {

    private long base1 = 7919;
    private long base2 = 5003;

    public static long getRollingHash(String password, long base) {
        long hash = 0;
        long mod = 1000000007;
        long power = 1;
        for (int i = 0; i < password.length(); i++) {
            hash = (hash + password.charAt(i)*power)%mod;
            power = (power * base)%mod;
        }
        return hash;
    }

    public long getHash1(String password) {
        return getRollingHash(password, base1);
    }

    public long getHash2(String password) {
        return getRollingHash(password, base2);
    }
    
}
