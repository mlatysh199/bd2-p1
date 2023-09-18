package tec.bd2.proyectos.db;

import java.sql.SQLException;


import tec.bd2.proyectos.db.repository.ClientRepository;
import tec.bd2.proyectos.db.repository.LogRepository;
import tec.bd2.proyectos.db.repository.ProductBuyRepository;
import tec.bd2.proyectos.db.repository.ProductRepository;
import tec.bd2.proyectos.db.repository.ProviderRepository;
import tec.bd2.proyectos.db.repository.ReceiptRepository;
import tec.bd2.proyectos.db.service.Metrics;
import tec.bd2.proyectos.db.service.UserFinder;

public class DatabaseContext {
    private final JDBCController jdbcController;
    private final ClientRepository clientRepository;
    private final LogRepository logRepository;
    private final ProductBuyRepository productBuyRepository;
    private final ProductRepository productRepository;
    private final ProviderRepository providerRepository;
    private final ReceiptRepository receiptRepository;

    private final UserFinder userFinder;
    private final Metrics metrics;

    public DatabaseContext(String jdbcURL, String username, String password, String walletLocation) throws ClassNotFoundException, SQLException {
        this.jdbcController = new JDBCController(jdbcURL, username, password, walletLocation);

        this.clientRepository = new ClientRepository(this.jdbcController.getConnection());
        this.logRepository = new LogRepository(this.jdbcController.getConnection());
        this.productBuyRepository = new ProductBuyRepository(this.jdbcController.getConnection());
        this.productRepository = new ProductRepository(this.jdbcController.getConnection());
        this.providerRepository = new ProviderRepository(this.jdbcController.getConnection());
        this.receiptRepository = new ReceiptRepository(this.jdbcController.getConnection());

        this.userFinder = new UserFinder(this.jdbcController.getConnection());
        this.metrics = new Metrics(this.jdbcController.getConnection());
    }

    public JDBCController getJdbcController() {
        return this.jdbcController;
    }

    public ClientRepository getClientRepository() {
        return this.clientRepository;
    }

    public LogRepository getLogRepository() {
        return this.logRepository;
    }

    public ProductBuyRepository getProductBuyRepository() {
        return this.productBuyRepository;
    }

    public ProductRepository getProductRepository() {
        return this.productRepository;
    }

    public ProviderRepository getProviderRepository() {
        return this.providerRepository;
    }

    public ReceiptRepository getReceiptRepository() {
        return this.receiptRepository;
    }

    public UserFinder getUserFinder() {
        return this.userFinder;
    }

    public Metrics getMetrics() {
        return this.metrics;
    }
}
