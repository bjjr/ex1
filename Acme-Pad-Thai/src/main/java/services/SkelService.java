package services;

import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import repositories.SkelRepository;
import domain.Skel;

// TODO Replace skel in this service

@Service
@Transactional
public class SkelService {

	// Managed repository ----------------------------------------
	
	@Autowired
	private SkelRepository skelRepository;
	
	// Constructor -----------------------------------------------
	
	public SkelService() {
		super();
	}
	
	// Supporting services ---------------------------------------
	
	// Simple CRUD methods ---------------------------------------
	
	// Other business methods ------------------------------------
	
	public Skel findOne(int skelId) {
		Skel res;
		
		res = skelRepository.findOne(skelId);
		Assert.notNull(res);
		
		return res;
	}
	
	public Collection<Skel> findAll() {
		Collection<Skel> res;
		
		res = skelRepository.findAll();
		Assert.notNull(res);
		
		return res;
	}
	
	public void flush() {
		skelRepository.flush();
	}
}
