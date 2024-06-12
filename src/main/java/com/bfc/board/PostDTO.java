package com.bfc.board;
import java.util.*;

public class PostDTO {
	private int userId;
	private int postId;
	private String title;
	private Date createdAt;
	private List<ContentDTO> contents;
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	public List<ContentDTO> getContents() {
		return contents;
	}
	public void setContents(List<ContentDTO> contents) {
		this.contents = contents;
	}
}