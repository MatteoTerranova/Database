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


public final class ReadDocumentDatabase {

	
	private static final String STATEMENT = "SELECT DocumentID, Title, Content, TaskID, Producer FROM Document WHERE TaskID = ?";


	private final Connection con;

	
	private final UUID id;

	public ReadDocumentDatabase(final Connection con, final String id) {
		this.con = con;
		this.id = UUID.fromString(id);
	}

	
	public List<Document> readDocument() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		

		Base64.Encoder encoder = Base64.getEncoder(); 
		final List<Document> documents = new ArrayList<>();

		try {
			pstmt = con.prepareStatement(STATEMENT);
			pstmt.setObject(1, id);

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