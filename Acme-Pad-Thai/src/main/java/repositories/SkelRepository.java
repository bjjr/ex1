package repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import domain.Skel;

// TODO Replace Skel in this repository

@Repository
public interface SkelRepository extends JpaRepository<Skel, Integer> {

}
