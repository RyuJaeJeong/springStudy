package org.zerock.domain;

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
	
	public Criteria() {
		this(1, 10);
	}
	
	public Criteria(int pageNumber, int amount) {
		this.pageNumber = pageNumber;
		this.amount = amount;
	}
	
	
}
