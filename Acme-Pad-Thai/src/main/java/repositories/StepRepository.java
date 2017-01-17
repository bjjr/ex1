package repositories;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Recipe;
import domain.Step;

@Repository
public interface StepRepository extends JpaRepository<Step, Integer>{
	
	@Query("select avg(r.steps.size) from Recipe r")
	Double findAvgStepsRecipe();
	
	@Query("select stddev(r.steps.size) from Recipe r")
	Double findStandardDeviationStepsRecipe();

	@Query("select r from Recipe r join r.steps s where s.id=?1")
	Recipe findRecipeByStep(int id);
}
