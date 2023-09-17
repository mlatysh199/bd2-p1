package tec.bd2.proyectos.logic;

public class PasswordController {

    private long base1 = 127;
    private long base2 = 131;

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
    
}
