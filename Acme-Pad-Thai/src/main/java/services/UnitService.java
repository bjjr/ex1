package services;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.UnitRepository;
import domain.Unit;

@Service
@Transactional
public class UnitService {
	
	//Managed repository
	@Autowired
	private UnitRepository unitRepository;
	
	// Supporting services
	@Autowired
	private ActorService actorService;
	
	//Constructors
	public UnitService(){
		super();
	}
	
	// Simple CRUD methods
	public Unit create(){
		Assert.isTrue(actorService.checkAuthority("ADMINISTRATOR"));
		
		Unit result;
		
		result = new Unit();
		
		return result;
	}
	
	public Unit save(Unit unit){
		Assert.isTrue(actorService.checkAuthority("ADMINISTRATOR"));
		Assert.notNull(unit);
		
		Unit result;
		
		result = unitRepository.save(unit);
		
		return result;
	}
	
	public void flush() {
		unitRepository.flush();
	}
	
	public Unit findOne(int id){
		Assert.notNull(id);
		Assert.isTrue(id!=0);
		
		Unit result;
		
		result = unitRepository.findOne(id);
		Assert.notNull(result);
		
		return result;
		
	}
	
	public Collection<Unit> findAll() {
		Assert.isTrue(actorService.checkAuthority("USER"));
		
		Collection<Unit> res;
		
		res = unitRepository.findAll();
		Assert.notNull(res);
		
		return res;
	}
	

}
