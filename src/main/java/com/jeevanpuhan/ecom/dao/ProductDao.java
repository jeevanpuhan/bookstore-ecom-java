package com.jeevanpuhan.ecom.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.jeevanpuhan.ecom.entities.Product;

public class ProductDao {
	
	private SessionFactory factory;

	public ProductDao(SessionFactory factory) {
		this.factory = factory;
	}
	
	public int saveProduct(Product product) {
		
		int productId = 0;
		
		try {
			
			Session session = this.factory.openSession();
			Transaction tx = session.beginTransaction();
			
			productId = (int) session.save(product);
			
			tx.commit();
			session.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			productId = 0;
		}
		
		return productId;
	}
	
	// get all products
	public List<Product> getAllProducts() {
		
		Session session = this.factory.openSession();
		Query<Product> query = session.createQuery("from Product");
		List<Product> list = query.list();
		
		return list; 
	}
	
	// get products by category Id
	public List<Product> getProductsByCategoryId(int cid) {
		
		Session session = this.factory.openSession();
		Query<Product> query = session.createQuery("from Product as p where p.category.categoryId =: id");
		query.setParameter("id", cid);
		List<Product> list = query.list();
		
		return list; 
	}
	
	

}
