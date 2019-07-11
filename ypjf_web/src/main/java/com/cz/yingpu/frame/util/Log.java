package com.cz.yingpu.frame.util;

import com.google.gson.Gson;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Log {

	private String filePath;

	private String fileName;

	private FileWriter fileWriter;

	private boolean isFileClose;

	private Gson gson;

	private static SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");

	public Log(String filePath, String fileName) {
		this.fileName = fileName;
		this.filePath = filePath;
		gson = new Gson();
		openLogFile();
	}

	private void openLogFile() {
		File logsDir = new File(filePath);
		if (!logsDir.isDirectory()) {
			logsDir.mkdirs();
		}

		try {
			fileWriter = new FileWriter(new File(logsDir, fileName), true);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			if (!isFileClose) {
				fileWriter.flush();
				fileWriter.close();
			}
			isFileClose = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	public void writeLog(String logs) {
		try {
			fileWriter.append(simpleDateFormat.format(new Date()))
			  .append(logs)
			  .append("\r\n");
			fileWriter.flush();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	public void writeLog(Object logs) {
		try {
			fileWriter.append(simpleDateFormat.format(new Date()))
					.append(gson.toJson(logs))
					.append("\r\n");
			fileWriter.flush();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}

	public static String getStackTrace(Throwable t) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		t.printStackTrace(new PrintStream(baos));
		
		String stackTrace = "";
		try {
			stackTrace = new String(baos.toByteArray(), "UTF-8");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return stackTrace;
	}


	public static void main(String[] args) throws ParseException {
		String aa = "07:30";
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		Date value = sdf.parse(aa);
		System.out.println(value);
	}
	
}
