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
	
	

}
