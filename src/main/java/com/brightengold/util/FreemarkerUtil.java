package com.brightengold.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Map;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreemarkerUtil {
	public static Template getTemplate(String name){
		try{
			Configuration cfg = new Configuration();
			cfg.setClassForTemplateLoading(FreemarkerUtil.class, "/ftl");
			cfg.setDefaultEncoding("UTF-8");
			Template temp = cfg.getTemplate(name);
			return temp;
		}catch(IOException e){
			e.printStackTrace();
		}
		return null;
	}
	
	public static void print(String name,Map<String,Object> root){
		try{
			Template temp = getTemplate(name);
			temp.process(root, new PrintWriter(System.out));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	//FreemarkerUtil.fprint("category.ftl", root, path+File.separator+"fireworksweb"+File.separator, "category.html");
	public static void fprint(String name,Map<String,Object> root,String outFile,String fileName){
		Writer out = null;
		try {
			File file = new File(outFile);
			if(!file.exists()){
				file.mkdirs();
			}
			//out = new BufferedWriter(file+File.separator+fileName);
			out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file+File.separator+fileName),"UTF-8"));
			Template temp = getTemplate(name);
			temp.setEncoding("UTF-8");
			temp.process(root,out);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		} finally{
			if(out!=null)
				try {
					out.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
	}
}
