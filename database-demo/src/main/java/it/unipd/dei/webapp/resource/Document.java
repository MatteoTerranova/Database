package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;
import java.util.UUID;

/**
 * Document of the Ennedue Studio
 */
 
 // TODO: CLASS MUST BE COMPLETED WITH WHAT WE WANT TO SHOW!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
public class Document extends Resource {

	private final UUID id;

	private final String name;
	
	private final String content;

	private final UUID taskID;

	private final String producer;

	// Creates new Document
	public Document(final UUID id, final String name, final String content, final UUID taskID, final String producer) {
		this.id = id;
		this.name = name;
		this.content = content;
		this.taskID = taskID;
		this.producer = producer;
		
	}
	
	public final UUID getID() {
		return id;
	}
	
	public final String getName() {
		return name;
	}

	public final String getContent() {
		return content;
	}

	public final UUID getTaskID() {
		return taskID;
	}

	public final String getProducer() {
		return producer;
	}
	
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("document");

		jg.writeStartObject();

		jg.writeStringField("id", id.toString());

		jg.writeStringField("name", name);
		
		jg.writeStringField("content", content);

		jg.writeStringField("taskid", taskID.toString());

		jg.writeStringField("producer", producer);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}
	

	/**
	 * Creates a Document from its JSON representation.
	 */

	public static Document fromJSON(final InputStream in) throws IOException {

		// The fields read from JSON
		UUID jUuid = null;
		String jName = null;
		String jContent = null;
		UUID jTaskID = null;
		String jProducer = null;

		final JsonParser jp = JSON_FACTORY.createParser(in);

		// While we are not on the start of an element or the element is not
		// a token element, advance to the next element (if any)
		while (jp.getCurrentToken() != JsonToken.FIELD_NAME || "document".equals(jp.getCurrentName()) == false) {

			// there are no more events
			if (jp.nextToken() == null) {
				throw new IOException("Unable to parse JSON: no range object found.");
			}
		}

		while (jp.nextToken() != JsonToken.END_OBJECT) {

			if (jp.getCurrentToken() == JsonToken.FIELD_NAME) {

				switch (jp.getCurrentName()) {
					case "uuid":
						jp.nextToken();
						jUuid = UUID.randomUUID();
						break;
					case "name":
						jp.nextToken();
						jName = jp.getText();
						break;
					case "content":
						jp.nextToken();
						jContent = jp.getText();
						break;
					case "taskuuid":
						jp.nextToken();
						jTaskID = UUID.fromString(jp.getText());
						break;
					case "producer":
						jp.nextToken();
						jProducer = jp.getText();
						break;
				}
			}
		}


		return new Document(jUuid, jName, jContent, jTaskID, jProducer);

	}

}
