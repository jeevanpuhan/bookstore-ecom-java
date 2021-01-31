package com.jeevanpuhan.ecom.helper;

public class Helper {

	public static String getShortDesc(String desc) {

		String[] words = desc.split(" ");

		if (words.length > 10) {

			StringBuilder sb = new StringBuilder();
			
			for (int i = 0; i < 10; i++) {
				sb.append(words[i]).append(" ");
			}

			return (sb.toString() + "...");

		} else {

			return desc + "...";
		}

	}

}
