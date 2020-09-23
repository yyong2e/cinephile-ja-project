package com.ch.cinephile.service;

import java.util.List;

import com.ch.cinephile.model.Customer;

public interface CustomerService {

	Customer select(String c_id);

	int insert(Customer customer);

	List<Customer> getCustomerList(Customer customer);

	int getTotalCustomer();

	String getNickname(String fid);

	String passwordChk(String c_id);

	int update(Customer customer);

	String searchProimg(String c_id);

	Customer selectCid2(String c_id);

	int updateCustomer(Customer customer);

	int customerdelete(String c_id);



}
