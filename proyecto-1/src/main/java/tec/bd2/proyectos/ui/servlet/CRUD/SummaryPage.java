package tec.bd2.proyectos.ui.servlet.CRUD;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tec.bd2.proyectos.db.DatabaseContext;
import tec.bd2.proyectos.db.entities.LogEntity;
import tec.bd2.proyectos.db.entities.MetricEntity;
import tec.bd2.proyectos.logic.SessionManager;

public class SummaryPage extends CRUDPage {

    public SummaryPage(SessionManager sessionManager, DatabaseContext databaseContext) {
        super(sessionManager, databaseContext);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        throw new UnsupportedOperationException("Unimplemented method 'doPost'");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!loggedIn(req)) {
            redirect("/login", resp);
            return;
        }

        try {
            String search = req.getParameter("search");
            List<LogEntity> logs = new ArrayList<>();
            if (search != null && !search.isEmpty()) {
                // determine if search can be converted to a number
                try {
                    int id = Integer.parseInt(search);
                    LogEntity logEntity = this.getDatabaseContext().getLogRepository().findById(id);
                    if (logEntity != null) logs.add(logEntity);
                } catch (NumberFormatException e) {
                }
            } else logs = this.getDatabaseContext().getLogRepository().findAll(); 
            showData("logs", logs, req);
        } catch (SQLException e) {
            showData("logs", new ArrayList<>(), req);
        }

        try {
            String date = req.getParameter("date");
            String search = req.getParameter("searchp");
            List<MetricEntity> metrics = new ArrayList<>();
            if (date != null && !date.isEmpty()) {
                SimpleDateFormat htmlDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    Date readDate = htmlDateFormat.parse(date);
                    Calendar calendar = new GregorianCalendar();
                    calendar.setTime(readDate);
                    if (search != null && !search.isEmpty()) {
                        try {
                            int id = Integer.parseInt(search);
                            metrics.add(new MetricEntity(date, id, this.getDatabaseContext().getMetrics().getAmountOfItemSoldPerMonth(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH), id)));
                        } catch (NumberFormatException e) {
                        }
                    } else {
                        metrics.add(new MetricEntity(date, -1, this.getDatabaseContext().getMetrics().getAmountOfItemsSoldPerMonth(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH))));
                    }
                } catch (ParseException e) {
                }
            }
            showData("metrics", metrics, req);

        } catch (SQLException e) {
            showData("metrics", new ArrayList<>(), req);
        }

        showData("username", this.getSessionManager().getUsername(req.getSession().getId()), req);
        showPage("CRUD/summary.jsp", req, resp);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        if (id != null) {
            try {
                this.getDatabaseContext().getClientRepository().delete(Integer.parseInt(id));
                response.setStatus(HttpServletResponse.SC_OK); 
                return;
            } catch (NumberFormatException | SQLException e) {
            }
        }
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
    }
    
}
