package it.unipd.dei.webapp.database;

import it.unipd.dei.webapp.resource.Document;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Base64;
import java.util.UUID;

/**
 * Lists all the employees in the database.
 */
public final class ListDocumentDatabase {

	/**
	 * The SQL statement to be executed
	 */
	private static final String STATEMENT = "SELECT DocumentID, Title, Content, TaskID, Producer FROM Document";

	/**
	 * The connection to the database
	 */
	private final Connection con;

	/**
	 * Creates a new object for listing all the employees.
	 */
	public ListDocumentDatabase(final Connection con) {
		this.con = con;
	}

	/**
	 * Lists all the employees in the database.
	 */
	public List<Document> listDocument() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// The results of the search
		final List<Document> documents = new ArrayList<>();

		Base64.Encoder encoder = Base64.getEncoder(); 

		try {
			pstmt = con.prepareStatement(STATEMENT);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				documents.add(new Document((UUID)rs.getObject(1), rs
						.getString(2), encoder.encodeToString(rs.getBytes(3)),
						(UUID)rs.getObject(4), rs.getString(5)));
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

		return documents;
	}
}