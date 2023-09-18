package tec.bd2.proyectos.logic;

import java.sql.SQLException;

import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.db.entities.UserEntity;

public class PasswordController {

    private long base1 = 7919;
    private long base2 = 5003;

    private static final long mod = 1000000007;

    private final DatabaseContext databaseContext;

    public PasswordController(DatabaseContext databaseContext) {
        this.databaseContext = databaseContext;
    }

    public static long getRollingHash(String password, long base) {
        long hash = 0;
        long power = 1;
        for (int i = 0; i < password.length(); i++) {
            hash = (hash + password.charAt(i)*power)%mod;
            power = (power * base)%mod;
        }
        return hash;
    }

    private long getHash1(String password) {
        return getRollingHash(password, base1);
    }

    private long getHash2(String password) {
        return getRollingHash(password, base2);
    }
    
    public boolean verifyPassword(String username, String password) throws SQLException {
        UserEntity user = this.databaseContext.getUserFinder().find(username);
        if (user == null) {
            return false;
        }

        long hash1 = getHash1(password);
        long hash2 = getHash2(password);

        return hash1 == user.getPasshash1() && hash2 == user.getPasshash2();
    }
}
