package com.brightengold.service;

public class TestJava {
	public static void main(String[] args) {
		String str = "D:ddfg/dfgdf/resources/upload/products";
		int i = str.lastIndexOf("upload");
		System.out.println(i);
		String re = str.substring(i);
		System.out.println(re);
	}
}
