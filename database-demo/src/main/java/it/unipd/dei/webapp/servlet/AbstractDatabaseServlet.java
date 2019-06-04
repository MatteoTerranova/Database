package it.unipd.dei.webapp.servlet;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.sql.DataSource;


public abstract class AbstractDatabaseServlet extends HttpServlet {

	/**
	 * The connection pool to the database.
	 */
	private DataSource ds;

	/**
     * Gets the dataSource for managing the connection pool to the database
	 */
    public void init(ServletConfig config) throws ServletException {

        // the JNDI lookup context
        InitialContext cxt;

        try {
            cxt = new InitialContext();
            ds = (DataSource) cxt.lookup("java:/comp/env/jdbc/ennedue");
        } catch (NamingException e) {
            ds = null;

            throw new ServletException(
                    String.format("Impossible to access the connection pool to the database: %s",
                                  e.getMessage()));
        }
    }

    /**
     * Releases the data source for managing the connection pool to the database.
     */
    public void destroy() {
        ds = null;
    }

    /**
     * Returns the data source for managing the connection pool to the database.
     */
    protected final DataSource getDataSource() {
        return ds;
    }

}
