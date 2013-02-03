package com.my.verve;

import java.util.Locale;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

/**
 * Handles requests for the Movies.
 */
@Controller
@RequestMapping("/mvc")
public class MovieController {
	
	private static final Logger logger = LoggerFactory.getLogger(MovieController.class);
	private String[] movies = {"MISSION IMPOSSIBLE","SKYFALL","LIFE OF PIE","MR. BEAN","TITANIC","LION KING","SPIDERMAN","NARNIA","CARS","FINDING NEMO"};
	
	Random random = new Random();
	
	@Autowired
	RestTemplate restTemplate;
	
	
	/**
	 * Home page.
	 */
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		return "home";
	}
	
	/**
	 * Return movie name as Response body.
	 * @param locale Locale instance
	 * @param model Model instance
	 * @return movie name in json format.
	 */
	@RequestMapping(value = "/json", method = RequestMethod.GET)
	public @ResponseBody String json(Locale locale, Model model) {
		logger.info("Getting movie in json format", locale);
		String movie = "";
		int nextInt = random.nextInt(15);
		if(nextInt > 9 ) {
			logger.info("Getting movie in json format from Remote", locale);
			movie = restTemplate.getForObject("http://ec2-54-247-59-172.eu-west-1.compute.amazonaws.com/mvc/json", String.class, new Object[]{});
			return movie;
		} else {			
			movie = movies[nextInt];
			if(movie.contains("O")) {				
				throw new RuntimeException();
			}
			return "{\"name\":\""+movie+"\"}";
		}
	}	
	
	/**
	 * Exception handler for RuntimeException
	 * @param e RuntimeException instance.
	 * @return
	 */
	@ExceptionHandler
	public @ResponseBody String handle(RuntimeException e) {
		String error = "Internal Server Error";
		logger.error(error);
		return error;
	}

	/**
	 * Setter for RestTemplate
	 * @param restTemplate instance.
	 */
	public void setRestTemplate(RestTemplate restTemplate) {
		this.restTemplate = restTemplate;
	}
	
}
