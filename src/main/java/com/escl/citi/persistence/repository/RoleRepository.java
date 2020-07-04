package com.escl.citi.persistence.repository;


import com.escl.citi.entity.Role;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface RoleRepository extends PagingAndSortingRepository<Role, Integer> {

    @Override
    Iterable<Role> findAll();

    Role findTopByName(String name);
}