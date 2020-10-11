package com.spring.board.dao;

import java.util.HashMap;
import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

public interface BoardDao {

	public String selectTest() throws Exception;

	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception;

	public BoardVo selectBoard(BoardVo boardVo) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public BoardVo boardModifyView(BoardVo boardVo) throws Exception;
	
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;
	
	public List<BoardVo> selectBoardType (HashMap<String, Object> map) throws Exception;
	
	public List<CodeVo> selectCode (String codeType) throws Exception;
	
	public int boardTypeListCount(String[] boardType) throws Exception;
	
	public String selectId(String userId) throws Exception;
	
	public int insertUser(UserVo userVo) throws Exception;
	
	public String selectPw(String userPw) throws Exception;
	
	public String selectName(String userId) throws Exception;

}
