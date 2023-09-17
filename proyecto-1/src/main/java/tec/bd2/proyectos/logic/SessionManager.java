package tec.bd2.proyectos.logic;

import java.util.HashMap;
import java.util.Map;

public class SessionManager {
    private final Map<String, String> sessions;

    public SessionManager() {
        this.sessions = new HashMap<>();
    }

    public boolean attemptAddSession(String session, String username, String password) {
        // TODO: implement this method
        if (this.sessions.containsKey(session)) {
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
}
