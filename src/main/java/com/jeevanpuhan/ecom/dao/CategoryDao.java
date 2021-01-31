package com.jeevanpuhan.ecom.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.jeevanpuhan.ecom.entities.Category;

public class CategoryDao {
	
	private SessionFactory factory;

	public CategoryDao(SessionFactory factory) {
		this.factory = factory;
	}
	
	// save category to database
	public int saveCategory(Category category) {
		
		Session session = this.factory.openSession();
		Transaction tx = session.beginTransaction();
		
		int categoryId = (int) session.save(category);
		tx.commit();
		
		session.close();
		return categoryId;
	}
	
	public List<Category> getCategories() {
		
		Session session = this.factory.openSession();
		Query<Category> query = session.createQuery("from Category");
		List<Category> list = query.list();
		
		return list;
	}
	
	public Category getCategoryById(int categoryId) {
		
		Category category = null;
		
		try {
			
			Session session = this.factory.openSession();
			category = session.get(Category.class, categoryId);
			session.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return category;
	}

}
