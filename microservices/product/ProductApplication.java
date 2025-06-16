import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;

@SpringBootApplication
@RestController
public class ProductApplication {

    public static void main(String[] args) {
        SpringApplication.run(ProductApplication.class, args);
    }

    @GetMapping("/products")
    public String getProducts() {
        return "List of products";
    }

    @GetMapping("/")
    public String healthCheck() {
        return "Product service running";
    }
}

