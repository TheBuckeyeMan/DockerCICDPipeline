package com.example.demo.api;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.regions.Region;

@Configuration
public class S3Config {

    /*
	 * This section of code is responsable for:
	 * 
	 * 
	 */
    @Bean
    public S3Client s3Client() {
        return S3Client.builder()
                       .region(Region.US_EAST_2) // Replace with your region
                       .build();
    }
}
