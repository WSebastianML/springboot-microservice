package com.microservicio.webMicroservicios.service;

import com.microservicio.webMicroservicios.repository.SongRepository;
import com.microservicio.webMicroservicios.model.Song;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SongService {

    @Autowired
    private SongRepository songRepository;

    public List<Song> getAllSongs() {
        return songRepository.findAll();
    }

    public Optional<Song> getSongById(Long id) {
        return songRepository.findById(id);
    }

    public Song createSong(Song song) {
        return songRepository.save(song);
    }

    public Song updateSong(Long id, Song songDetails) {
        Song song = songRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Canción no encontrada"));

        song.setName(songDetails.getName());
        song.setPath(songDetails.getPath());
        song.setPlays(songDetails.getPlays());

        return songRepository.save(song);
    }

    public void deleteSong(Long id) {
        songRepository.deleteById(id);
    }
}
