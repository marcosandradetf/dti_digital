package com.example.dti_digital.backend.controller;

import com.example.dti_digital.backend.model.EventModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping("/events")
public class EventController {
    private final ObjectMapper objectMapper;
    String currentDirectory = System.getProperty("user.dir");
    String jsonFilePath = currentDirectory + File.separator + "events.json";
    File file = new File(jsonFilePath);


    public EventController(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    @GetMapping
    public ResponseEntity<List<EventModel>> getEvents() {
        try {
            // Ler o arquivo JSON
            File file = new File(jsonFilePath);

            if (!file.exists()) {
                return ResponseEntity.ok(new ArrayList<>());
            }

            // Obter a lista de eventos
            List<EventModel> events = objectMapper.readValue(file, objectMapper.getTypeFactory().constructCollectionType(List.class, EventModel.class));

            return ResponseEntity.ok(events);
        } catch (IOException e) {
            // Lidar com exceções, como FileNotFoundException ou IOException
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping
    public void addEvent(@RequestBody EventModel newEvent) {
        try {
            File file = new File(jsonFilePath);

            // Se o arquivo não existir, crie uma lista vazia e escreva no arquivo
            if (!file.exists()) {
                List<EventModel> initialEvents = new ArrayList<>();
                objectMapper.writeValue(file, initialEvents);
            }

            // Agora leia o arquivo e adicione o novo evento
            List<EventModel> events = objectMapper.readValue(file, objectMapper.getTypeFactory().constructCollectionType(List.class, EventModel.class));
            events.add(newEvent);

            // Salvar os dados atualizados no arquivo JSON
            objectMapper.writeValue(file, events);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @DeleteMapping("/{eventName}")
    public void deleteEvent(@PathVariable String eventName) {
        try {
            // Ler o arquivo JSON
            File file = new File(jsonFilePath);
            List<EventModel> events = objectMapper.readValue(file, objectMapper.getTypeFactory().constructCollectionType(List.class, EventModel.class));

            // Deletar a entrada
            events.removeIf(event -> event.getNome().equals(eventName));

            // Salvar os dados atualizados no arquivo JSON
            objectMapper.writeValue(file, events);
        } catch (IOException e) {
            // Lidar com exceções, como FileNotFoundException ou IOException
            e.printStackTrace();
        }
    }
}
