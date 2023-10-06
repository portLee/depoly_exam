package com.example.dao;

import java.util.ArrayList;

import com.example.dto.Member;

public class MemberRepository {
	private final ArrayList<Member> members = new ArrayList<Member>();
	private static final MemberRepository instance = new MemberRepository();
	
	public static MemberRepository getInstance() {
		return instance;
	}
	

	public Member getMemberById(String memberId) {
		Member member = null;
		
		for (Member m : members) {
			if (m.getMemberId().equals(memberId)) {
				member = m;
				break;
			}
		}
		
		return member;
	}
	
	public void addMember(Member member) {
		members.add(member);
	}
}
