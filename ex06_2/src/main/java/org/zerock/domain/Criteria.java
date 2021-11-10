package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	//페이지 번호, 한 페이지에 보여질 개시물에 갯수.
	
	private int pageNumber;
	private int amount;
	private String type;
	private String keyword;
	
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNumber, int amount) {
		this.pageNumber = pageNumber;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		return type == null? new String[] {}: type.split("");
		
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNumber", this.pageNumber)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
	
	
}
