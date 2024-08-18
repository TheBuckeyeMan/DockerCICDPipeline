//This application contains the main entrypoint and configuration for the spring boot application

package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.core.sync.RequestBody;
import com.example.demo.api.Todo;

@SpringBootApplication
public class DockerCicdPipelineApplication {

	//creates a log for us to log the response of the application class json response - response contains our json file contents
	private static final Logger log = LoggerFactory.getLogger(DockerCicdPipelineApplication.class);

	/*
	 * This section of code is responsable for:
	 * Running the application
	 */
	public static void main(String[] args) {
		SpringApplication.run(DockerCicdPipelineApplication.class, args);
	}

	/*
	 * This section of code is responsable for:
	 * This creates a rest template bean that is used to make http requests.
	 */
	@Bean
    public RestTemplate restTemplate(RestTemplateBuilder builder) {
        return builder.build();
    }
	/*
	 * This section of code is responsable for:
	 * The commandlinereunner bean is ran after the main method, this is what actually calls the api and fetches the data
	 */
	@Bean
    public CommandLineRunner run(RestTemplate restTemplate, S3Client s3Client) throws Exception {
        return args -> {
            Todo todo = restTemplate.getForObject(
                    "https://jsonplaceholder.typicode.com/todos/1", Todo.class);

            if (todo != null) {
                String bucketName = "api-data-colection-s3-bucket-for-testing";
                String fileName = "TemplateFile.json"; //Update the name of the file you want to store in s3
                String fileContent = todo.toString();

                log.info("Attempting to upload to S3 bucket: " + bucketName);
                uploadToS3(s3Client, bucketName, fileName, fileContent);
            } else {
                log.error("Received null Todo object from API");
            }
        };
    }
	/*
	 * This section of code is responsable for:
	 * this creates a request to upload to s3 and uses the s3configuration we made to alow it to interact with it. 
	 * Additionally, this class attemots to upload to s3
	 */
	private void uploadToS3(S3Client s3Client, String bucketName, String fileName, String fileContent) {
        try {
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                .bucket(bucketName)
                .key(fileName)
                .build();

            s3Client.putObject(putObjectRequest, RequestBody.fromString(fileContent));
            log.info("File uploaded to S3 bucket: " + bucketName + "/" + fileName);
        } catch (Exception e) {
            log.error("Error uploading file to S3", e);
        }
    }
}


