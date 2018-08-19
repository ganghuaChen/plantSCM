package org.npc.plantSCM.exception;

public class NullListException extends RuntimeException {

	public NullListException() {
		super();
	}

	public NullListException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public NullListException(String message, Throwable cause) {
		super(message, cause);
	}

	public NullListException(String message) {
		super(message);
	}

	public NullListException(Throwable cause) {
		super(cause);
	}

}
