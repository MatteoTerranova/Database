package it.unipd.dei.webapp.database;

import it.unipd.dei.webapp.resource.Document;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Base64.Encoder;

/**
 * Reads an employee from the database.
 * 
 * @author Nicola Ferro (ferro@dei.unipd.it)
 * @version 1.00
 * @since 1.00
 */
public final class ReadDocumentDatabase {

	/**
	 * The SQL statement to be executed
	 */
	private static final String STATEMENT = "SELECT DocumentID, Title, Content, TaskID, Producer FROM Document WHERE DocumentID = ?";

	/**
	 * The connection to the database
	 */
	private final Connection con;

	/**
	 * The badge of the employee
	 */
	private final String id;

	/**
	 * Creates a new object for reading an employee.
	 * 
	 * @param con
	 *            the connection to the database.
	 * @param badge
	 *            the badge of the employee.
	 */
	public ReadEmployeeDatabase(final Connection con, final int badge) {
		this.con = con;
		this.id = id;
	}

	/**
	 * Reads an employee from the database.
	 * 
	 * @return the {@code Employee} object matching the badge.
	 * 
	 * @throws SQLException
	 *             if any error occurs while reading the employee.
	 */
	public Document readEmployee() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// the read employee
		Document e = null;

		try {
			pstmt = con.prepareStatement(STATEMENT);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				e = new Document(((UUID)rs.getObject(1)).toString(), rs
						.getString(2), Base64.encodeToString(rs.getBytes(3)),
						((UUID)rs.getObject(4)).toString(), rs.getString(5));
			}
		} finally {
			if (rs != null) {
				rs.close();
			}

			if (pstmt != null) {
				pstmt.close();
			}

			con.close();
		}

		return e;
	}
}