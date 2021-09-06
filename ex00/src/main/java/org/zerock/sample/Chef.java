package org.zerock.sample;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class Chef {
	public void getName() {
		System.out.println("이연복");
		
	}
}
