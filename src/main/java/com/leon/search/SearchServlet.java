package com.leon.search;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

public class SearchServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8551378670503736112L;

	static List<String> datas = new ArrayList<String>();
	static {
		datas.add("ajax");
		datas.add("ajax post");
		datas.add("beckham");
		datas.add("back");
		datas.add("car");
		datas.add("carlun");
		datas.add("james");
		datas.add("jackson");
		datas.add("great");
		datas.add("ajax get");
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String keyword = req.getParameter("keyword");
		List<String> result = getContent(keyword);
		resp.getWriter().write(JSONArray.fromObject(result).toString());
	}

	private List<String> getContent(String keyword) {
		List<String> result = new ArrayList<String>();
		for (String string : datas) {
			if (string.contains(keyword)) {
				result.add(string);
			}
		}
		return result;
	}
}
