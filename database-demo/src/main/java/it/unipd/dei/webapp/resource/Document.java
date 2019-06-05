package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * Document of the Ennedue Studio
 */
 
 // TODO: CLASS MUST BE COMPLETED WITH WHAT WE WANT TO SHOW!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
public class Document extends Resource {

	//private final String id;

	private final String name;
	
	//private final byte[] fileBytes;

	//private final String description;

	//private final int level;
	
	// Creates new Document
	public Document(final String name) {//, final String id, final byte[] fileBytes) {//, final String description, final int level){
		//this.id = id;
		this.name = name;
		//this.fileBytes = fileBytes;

		//his.description = description;
		//this.level = level;
	}
	
	/*public final String getID() {
		return id;
	}*/
	
	public final String getName() {
		return name;
	}

	/*public final byte[] getFileBytes() {
		return fileBytes;
	}*/
	/*public final String getDescription() {
		return description;
	}
	
	public final int getLevel() {
		return level;
	}*/
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("document");

		jg.writeStartObject();

		jg.writeStringField("name", name);
		
		//jg.writeStringField("description", description);

		//jg.writeNumberField("level", level);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}
	
	/**
	 * Creates a Document from its JSON representation.
	 */
	 // TODO: Implemetn this method to store the documents inside the database
	public static Document fromJSON(final InputStream in) throws IOException {

		// The fields read from JSON
		String jFromDate = null;
		String jToDate = null;

		final JsonParser jp = JSON_FACTORY.createParser(in);

		// While we are not on the start of an element or the element is not
		// a token element, advance to the next element (if any)
		while (jp.getCurrentToken() != JsonToken.FIELD_NAME || "range".equals(jp.getCurrentName()) == false) {

			// there are no more events
			if (jp.nextToken() == null) {
				throw new IOException("Unable to parse JSON: no range object found.");
			}
		}

		while (jp.nextToken() != JsonToken.END_OBJECT) {

			if (jp.getCurrentToken() == JsonToken.FIELD_NAME) {

				switch (jp.getCurrentName()) {
					case "fromdate":
						jp.nextToken();
						jFromDate = jp.getText();
						break;
					case "todate":
						jp.nextToken();
						jToDate = jp.getText();
						break;
				}
			}
		}

		return new SearchRange(jFromDate, jToDate);
	}

}
