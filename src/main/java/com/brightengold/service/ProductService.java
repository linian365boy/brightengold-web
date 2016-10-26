package com.brightengold.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.brightengold.common.vo.RequestParam;
import com.brightengold.dao.ProductDao;
import com.brightengold.model.Product;

import cn.rainier.nian.utils.PageRainier;

@Component("productService")
public class ProductService {
	@Autowired
	private ProductDao productDao;
	private static final Logger logger = LoggerFactory.getLogger(ProductService.class);

	public PageRainier<Product> findAll(RequestParam param) {
		long count = productDao.findAllCount(param);
		PageRainier<Product> page = new PageRainier<Product>(count);
		page.setResult(productDao.findList(param));
		return page;
	}

	public Product loadProductById(Integer productId) {
		return productDao.findOne(productId);
	}

	public void saveProduct(Product product) {
		productDao.save(product);
	}

	public void delProduct(Integer productId) {
		productDao.delete(productId);
	}
	
	/**
	 * findIndexPic:首页展示热门产品
	 * @author tanfan 
	 * @param pageSize
	 * @return 
	 * @since JDK 1.7
	 */
	public List<Product> findIndexPic(int pageSize){
		return productDao.findIndexPic(pageSize);
	}
	
	/**
	 * 查询栏目下的已发布的，状态正常的产品
	 * @param id
	 * @return
	 */
	public long countByColId(Integer id) {
		return productDao.countByColId(id);
	}

	/**
	 * 供前台查询，分页查询产品
	 * @param pageNo
	 * @param pageSize
	 * @param id
	 * @return
	 */
	public PageRainier<Product> findPageByColId(int pageNo, Integer pageSize,
			Integer colId) {
		long count = productDao.countByColId(colId);
		PageRainier<Product> page = new PageRainier<Product>(count,pageNo,pageSize);
		page.setResult(productDao.findListByColId(colId,(pageNo-1)*pageSize,pageSize));
		return page;
	}
	
	public long countIndexByColId(Integer id) {
		return productDao.countByColId(id);
	}

	public void insertOfBatch(List<Product> productList) {
		productDao.save(productList);
	}

	public long countByCateId(int cateId) {
		return productDao.countByCateId(cateId);
	}

	/**
	 * 查询该分类下所有已发布且状态正常的产品
	 * @param pageNo
	 * @param pageSize
	 * @param cateId
	 * @return
	 */
	public PageRainier<Product> findAllByCateId(int pageNo, Integer pageSize,
			Integer cateId) {
		long count = productDao.countByCateId(cateId);
		PageRainier<Product> page = new PageRainier<Product>(count,pageNo,pageSize);
		page.setResult(productDao.findAllListByCateId(cateId,(pageNo-1)*pageSize,pageSize));
		return page;
	}

	public boolean updateStatus(Integer id, boolean status) {
		if(status){
			status = false;
		}else{
			status = true;
		}
		boolean flag = true;
		try{
			productDao.updateStatus(id,status);
		}catch(Exception e){
			logger.error("修改产品的状态失败！",e);
			flag = false;
		}
		return flag;
	}

	public List<Product> findRelatedProducts(Integer id, String keyWords, int maxSize) {
		/*if(!StringUtils.isBlank(keyWords)){
			String[] kws = keyWords.split(";");
			List<Product> ps = new ArrayList<Product>();
			List<Product> tps = new ArrayList<Product>();
			List<Product> temp = null;
			for(String kw : kws){
				temp = productDao.findAll(findRelatedProductsSpec(id,kw),new Sort(Direction.DESC,"priority","hot","id"));
				if(CollectionUtils.isNotEmpty(temp)){
					if(temp.size()>=maxSize){
						ps.addAll(temp.subList(0, maxSize-1));
						break;
					}else{
						ps.addAll(temp);
					}
				}
			}
			Set<Integer> tpId = new HashSet<Integer>();
			for(Product p : ps){
				if(tpId.contains(p.getId())){
					continue;
				}
				tpId.add(p.getId());
				tps.add(p);
			}
			ps.clear();
			tpId.clear();
			return tps;
		}*/
		return null;
	}
	
	/*private Specification<Product> findRelatedProductsSpec(final Integer id, final String kw) {
		return new Specification<Product>(){
			@Override
			public Predicate toPredicate(Root<Product> root,
					CriteriaQuery<?> query, CriteriaBuilder cb) {
				return cb.and(cb.like(root.<String>get("keyWords"), '%'+kw+'%'),
						cb.notEqual(root.<Integer>get("id"), id));
			}
		};
	}*/

	public PageRainier<Product> findAllReleaseProductByLikeKeyword(RequestParam param) {
		//Page<Product> tempPage = productDao.findAll(findAllReleaseProductByLikeKeywordSpec(keyword), 
		//		new PageRequest(pageNo-1, pageSize, new Sort(Direction.DESC,"priority","hot","id")));
		long count = productDao.countAllReleaseProductByLikeKeyword(param);
		PageRainier<Product> page = new PageRainier<Product>(count);
		page.setResult(productDao.findAllReleaseProductByLikeKeyWordList(param));
		return page;
	}

	/*private Specification<Product> findAllReleaseProductByLikeKeywordSpec(final String keyword) {
		return new Specification<Product>(){
			@Override
			public Predicate toPredicate(Root<Product> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				if(StringUtils.isNotBlank(keyword)){
					return cb.like(root.<String>get("enName"), '%'+keyword+'%');
				}else{
					return null;
				}
			}
		};
	}*/
}
