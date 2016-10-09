package com.brightengold.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class FreemarkerUtil {
	private final static Logger logger = LoggerFactory.getLogger(FreemarkerUtil.class);
	public static Template getTemplate(String name){
		try{
			Configuration cfg = new Configuration();
			cfg.setClassForTemplateLoading(FreemarkerUtil.class, "/ftl");
			cfg.setDefaultEncoding("UTF-8");
			Template temp = cfg.getTemplate(name);
			return temp;
		}catch(IOException e){
			logger.error("FreemarkerUtil getTemplate error",e);
		}
		return null;
	}
	
	public static void print(String name,Map<String,Object> root){
		try{
			Template temp = getTemplate(name);
			temp.process(root, new PrintWriter(System.out));
		}catch(Exception e){
			logger.error("freemarker process error",e);
		}
	}
	
	public static boolean fprint(String name,Map<String,Object> root,String outFile,String fileName) {
		Writer out = null;
		boolean flag = false;
		try {
			File file = new File(outFile);
			if(!file.exists()){
				file.mkdirs();
			}
			out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file+File.separator+fileName),"UTF-8"));
			Template temp = getTemplate(name);
			temp.setEncoding("UTF-8");
			temp.process(root,out);
			flag = true;
		} catch (IOException e) {
			logger.error("freemarker process IOException",e);
		} catch (TemplateException e) {
			logger.error("freemarker process TemplateException",e);
		} finally{
			if(out!=null)
				try {
					out.close();
				} catch (IOException e) {
					logger.error("freemarker fprint Writer close error",e);
				}
		}
		return flag;
	}
}
