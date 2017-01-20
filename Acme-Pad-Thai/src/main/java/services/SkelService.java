package services;

import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import repositories.SkelRepository;
import domain.Nutritionist;
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
	
	@Autowired
	private NutritionistService nutritionistService;
	
	// Simple CRUD methods ---------------------------------------
	
	public Skel create() {
		Skel res;
		
		res = new Skel();
		
		// TODO Set attributes
		
		return res;
	}
	
	public Skel save(Skel s) {
		Assert.notNull(s);
		Skel res;
		
		if (s.getId() == 0) {
			res = skelRepository.save(s);
			// TODO Check the relationships
		} else {
			res = skelRepository.save(s);
		}
		
		return res;
	}
	
	public void delete(Skel s) {
		Assert.notNull(s);
		Assert.isTrue(s.getId() != 0);
		
		// TODO Control relationships
		
		skelRepository.delete(s.getId());
		
	}
	
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
	
	public Skel findOneToEdit(Skel s) {
		Assert.notNull(s);
		Assert.isTrue(s.getId() != 0);
		
		Skel res;
		Collection<Skel> skels;
		
		Nutritionist n;
		n = nutritionistService.findByPrincipal();
		
		// TODO CORREGIR CON LA ENTIDAD ADECUADA
//		skels = n.getSkels();
		
//		Assert.isTrue(skels.contains(s));
		
		return res;
	}
	
	public void flush() {
		skelRepository.flush();
	}
}
