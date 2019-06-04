package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * Document of the Ennedue Studio
 */
 
 // TODO: CLASS MUST BE COMPLETED WITH WHAT WE WANT TO SHOW!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
public class Document extends Resource {

	private final String name;
	
	private final String description;

	private final int level;
	
	// Creates new Document
	public Document(final String name, final String description, final int level){
		this.name = name;
		this.description = description;
		this.level = level;
	}
	
	public final String getName() {
		return name;
	}
	
	public final String getDescription() {
		return description;
	}
	
	public final int getLevel() {
		return level;
	}
	
	@Override
	public final void toJSON(final OutputStream out) throws IOException {

		final JsonGenerator jg = JSON_FACTORY.createGenerator(out);

		jg.writeStartObject();

		jg.writeFieldName("task");

		jg.writeStartObject();

		jg.writeStringField("name", name);
		
		jg.writeStringField("description", description);

		jg.writeNumberField("level", level);

		jg.writeEndObject();

		jg.writeEndObject();

		jg.flush();
	}

}
