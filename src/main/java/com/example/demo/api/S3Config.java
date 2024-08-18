//This file is for providing an s3 client as well as the application
//So this portion will create a configuration to interact with the s3 bucket, without it, our application wouldnt beable to talk to our s3 bucket
//@Configuration defines this is a configuration class and it can define beans for spring context - aka, - the code here is for configuration,not nessasarily to do anything in particular
//@Bean indicates that this is a brean provider meaning it will return an instance of S3 Client that can be used elsewhere in the applicaiton. 
package com.example.demo.api;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
//From the import below, we can see that instead of manually creating the configuration for the s3 client, we can simply import it and build an instance of it which happens below
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.regions.Region;

@Configuration
public class S3Config {

    /*
	 * This section of code is responsable for:
	 * Creating the s3 client configuration -> Alows for us to interact with the s3 bucket -> @Bean alows for it to be picked up
	 * Region.<your reion> specifies the region of the EXISTING BUCKET
	 */
    @Bean
    public S3Client s3Client() {
        return S3Client.builder()
                       .region(Region.US_EAST_2) // Replace with your region
                       //the below is building the s3 client. our class S3Client inherits the method of s3Client from the package. the below runs the build so the configuration is valid
                       .build();
    }
}
