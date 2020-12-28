package com.spring.board.vo;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BoardVo {
	
	private String 	boardType;
	private int 	boardNum;
	private String 	boardTitle;
	private String 	boardComment;
	private String 	creator;
	private String	modifier;
	private int totalCnt;
	
	private String fileName;
	private byte[] boardFile;
	private MultipartFile multipartFile;

	
	private List<BoardVo> boardVoList;
	

	
	public List<BoardVo> getBoardVoList() {
		return boardVoList;
	}
	public void setBoardVoList(List<BoardVo> boardVoList) {
		this.boardVoList = boardVoList;
	}
	
	
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardComment() {
		return boardComment;
	}
	public void setBoardComment(String boardComment) {
		this.boardComment = boardComment;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public byte[] getBoardFile() {
		return boardFile;
	}
	public void setBoardFile(byte[] boardFile) {
		this.boardFile = boardFile;
	}
	public MultipartFile getMultipartFile() {
		return multipartFile;
	}
	//MultipartFile -> byte[]로 변환
	public void setMultipartFile(MultipartFile multipartFile) throws IOException {
		this.multipartFile = multipartFile;
		//byte[]로 변환
		setBoardFile(multipartFile.getBytes());
		//파일명 구하기
		setFileName(multipartFile.getOriginalFilename());
	}
	
	
	
	
	
	
}
