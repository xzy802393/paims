package com.cz.yingpu.frame.util;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;

public class FileUtils {
	
	
	
	public static List<File> getPathAllFileExt(String path,String ext){
		List<File> list =new ArrayList<File>();
		
		getPathAllFileExt(list,path,ext);
		
		return list;
		
	}
	
	public  static  List<File> getPathAllFileExt(List<File> list,String path,String ext){
		
		File dir=new File(path);
		if(dir.isDirectory()==false)
			return list;
		
		File[] files=dir.listFiles();
		
	if(files==null||files.length<1)
		return list;
	for(File f:files){
		if(f.isDirectory()){
			String dirPath=f.getAbsolutePath();
			getPathAllFileExt(list,dirPath,ext);
		}else{
			if(f.getName().endsWith(ext)){
				
				list.add(f);
			}
		}
	}
		
		return list;
	}
	
	 /**
     * 获取文件后缀
     * 
     * @param originalFilename
     * @return
     */
    public static String getSuffix(String originalFilename) {
        return originalFilename.substring(originalFilename.lastIndexOf("."), originalFilename.length());
    }

    
    /**
     * 获取文件名
     * 
     * @param suffix
     * @return
     */
    public static String reSetFileName(String suffix) {
        return System.currentTimeMillis()+suffix;
    }
    
    
    /**
     * 把文件读到写入流
     * @param writer
     * @param file
     * @throws Exception
     */
    
    public static void readIOFromFile(Writer writer,File file) throws IOException{
    	readIOFromFile(writer, file, true);
    }
    
    /**
     * 把文件读到写入流
     * @param writer
     * @param file
     * @throws Exception
     */
    
    public static void readIOFromFile(Writer writer,File file,boolean closeWriter) throws IOException{
    	 // 读出文件到response  
        // 这里是先需要把要把文件内容先读到缓冲区  
        // 再把缓冲区的内容写到response的输出流供用户下载  
        FileInputStream fileInputStream = new FileInputStream(file);  
        BufferedInputStream bufferedInputStream = new BufferedInputStream(fileInputStream);  
        BufferedReader reader = new BufferedReader (new InputStreamReader(bufferedInputStream,GlobalStatic.defaultCharset));
        
        char[] data = new char[1024];
        while( reader.read(data)!=-1){
     	   writer.write(data); 
         } 
        
        reader.close();
        bufferedInputStream.close();
        fileInputStream.close();
        if(closeWriter){
        	 writer.close();
        }
       
        
        
    }


}
