package com.brightengold.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.brightengold.dao.CompanyDao;
import com.brightengold.model.Company;

@Component("companyService")
public class CompanyService {
	@Autowired
	private CompanyDao companyDao;

	public Company loadCompany() {
		return companyDao.findOne(1);
	}

	public Company save(Company company) {
		return companyDao.save(company);
	}
	
}
