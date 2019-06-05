package it.unipd.dei.webapp.resource;

import com.fasterxml.jackson.core.*;

import java.io.*;

/**
 * Document of the Ennedue Studio
 */
 
 // TODO: CLASS MUST BE COMPLETED WITH WHAT WE WANT TO SHOW!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
public class Document extends Resource {

	private final UUID id;

	private final String name;
	
	private final byte[] fileBytes;

	//private final String description;

	//private final int level;
	
	// Creates new Document
	public Document(final UUID id, final String name, final byte[] fileBytes) {//, final String description, final int level){
		this.id = id;
		this.name = name;
		this.fileBytes = fileBytes;
		//his.description = description;
		//this.level = level;
	}
	
	public final UUID getID() {
		return id;
	}
	
	public final String getName() {
		return name;
	}

	public final byte[] getFileBytes() {
		return fileBytes;
	}
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

}
