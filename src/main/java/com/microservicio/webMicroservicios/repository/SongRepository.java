package com.microservicio.webMicroservicios.repository;

import com.microservicio.webMicroservicios.model.Song;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SongRepository extends JpaRepository<Song, Long> {
}

