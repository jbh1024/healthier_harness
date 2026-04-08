package com.academy.healthier.domain.academy.repository

import com.academy.healthier.domain.academy.entity.Academy
import org.springframework.data.jpa.repository.JpaRepository

interface AcademyRepository : JpaRepository<Academy, Long>
