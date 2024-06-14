package com.bfc.board;

import java.util.*;
public class SimplePostDTO {
	private int userId;
	private int postId;
	private String title;
	private String image;
	private List<HashtagDTO> tags;
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
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public List<HashtagDTO> getTags() {
		return tags;
	}
	public void setTags(List<HashtagDTO> tags) {
		this.tags = tags;
	}
}