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
	
	//private final String content;

	//private final String taskID;

	//private final String producer;

	// Creates new Document
	public Document(final String name) {//, final String id, final String content, final String taskID, final String producer) {
		//this.id = id;
		this.name = name;
		//this.content = content;
		//this.taskID = taskID;
		//this.producer = producer;
		
	}
	
	/*public final String getID() {
		return id;
	}*/
	
	public final String getName() {
		return name;
	}

	/*public final String getContent() {
		return content;
	}*/

	/*public final String getTaskID() {
		return taskID;
	}*/

	/*public final String getProducert() {
		return producer;
	}*/
	
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("document");

		jg.writeStartObject();

		//jg.writeStringField("id", id);

		jg.writeStringField("name", name);
		
		//jg.writeStringField("content", content);

		//jg.writeStringField("taskid", taskID);

		//jg.writeStringField("producer", producer);

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

		return new Document(jFromDate);
	}

}
