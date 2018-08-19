package org.npc.plantSCM.exception;

public class MaterialInventoryException extends RuntimeException{

	public MaterialInventoryException() {
		super();
	}

	public MaterialInventoryException(String message) {
		super(message);
	}

	public MaterialInventoryException(Throwable cause) {
		super(cause);
	}

}
