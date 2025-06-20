package com.kubeshop;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@SpringBootApplication
@RestController
@RequestMapping("/products")
public class ProductApplication {

    public static void main(String[] args) {
        SpringApplication.run(ProductApplication.class, args);
    }

    @GetMapping
    public List<String> getProducts() {
        return List.of("Telescope", "Binoculars", "Camera Lens");
    }

    @GetMapping("/health")
    public String healthCheck() {
        return "✅ Product service is up and running!";
    }
}

