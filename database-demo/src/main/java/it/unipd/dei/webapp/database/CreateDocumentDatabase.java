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


public final class CreateDocumentDatabase {

	
	private static final String STATEMENT = "INSERT INTO Document (DocumentID, Title, Content, CurTime, TaskID, Producer) VALUES (?, ?, ?, ?, ?, ?)";

	
	private final Connection con;

	
	private final Document document;

	
	public CreateDocumentDatabase(final Connection con, final Document document) {
		this.con = con;
		this.document = document;
	}

	
	public Document createDocument() throws SQLException {

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// the create document
		Document e = null;
		byte[] byteArray = null;
		java.util.Date today = null;
		java.sql.Timestamp timeStamp = null;
		Base64.Decoder decoder = Base64.getDecoder();
		UUID docID = null;

		try {
			pstmt = con.prepareStatement(STATEMENT);
			docID = UUID.randomUUID();
			pstmt.setObject(1, docID);
			pstmt.setString(2, document.getName());
			byteArray = decoder.decode(document.getContent().getBytes());
			pstmt.setBytes(3, byteArray);
			today = new java.util.Date();
			timeStamp = new java.sql.Timestamp(today.getTime());
			pstmt.setTimestamp(4, timeStamp);
			pstmt.setObject(5, document.getTaskID());
			pstmt.setString(6, document.getProducer());

			rs = pstmt.executeQuery();

			if (rs.next()) {
				e = new Document(docID, document.getName(), "OK", document.getTaskID(), document.getProducer());
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