package com.bfc.board;

import java.sql.Timestamp;

public class ReplyDTO {
 private int replyId;
 private String content;
 private Timestamp createdAt;
 private int writerId;
 private String writerNickname;

 // Getters and Setters
 public int getReplyId() {
     return replyId;
 }

 public void setReplyId(int replyId) {
     this.replyId = replyId;
 }

 public String getContent() {
     return content;
 }

 public void setContent(String content) {
     this.content = content;
 }

 public Timestamp getCreatedAt() {
     return createdAt;
 }

 public void setCreatedAt(Timestamp createdAt) {
     this.createdAt = createdAt;
 }

 public int getWriterId() {
     return writerId;
 }

 public void setWriterId(int writerId) {
     this.writerId = writerId;
 }

 public String getWriterNickname() {
     return writerNickname;
 }

 public void setWriterNickname(String writerNickname) {
     this.writerNickname = writerNickname;
 }
}

