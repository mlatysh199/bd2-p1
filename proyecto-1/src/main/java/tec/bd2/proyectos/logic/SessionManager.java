package tec.bd2.proyectos.logic;

import java.util.HashMap;
import java.util.Map;

public class SessionManager {
    private final Map<String, String> sessions;
    private final PasswordController passwordController;

    public SessionManager(PasswordController passwordController) {
        this.passwordController = passwordController;
        this.sessions = new HashMap<>();
    }

    public boolean attemptAddSession(String session, String username, String password) {
        // TODO: implement this method
        try {
            if (this.sessions.containsKey(session) || !this.passwordController.verifyPassword(username, password)) {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }

        addSession(session, username);
        return true;
    }

    private void addSession(String session, String username) {
        this.sessions.put(session, username);
    }

    public boolean isValidSession(String session) {
        return this.sessions.containsKey(session);
    }

    public void removeSession(String session) {
        this.sessions.remove(session);
    }

    public Map<String, String> getSessions() {
        return this.sessions;
    }

    public String getUsername(String session) {
        return this.sessions.get(session);
    }
}
