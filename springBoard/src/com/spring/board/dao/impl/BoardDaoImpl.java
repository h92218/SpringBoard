package com.spring.board.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.BoardDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

@Repository
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		
		String a = sqlSession.selectOne("board.boardList");
		
		return a;
	}
	/**
	 * 
	 * */
	@Override
	public List<BoardVo> selectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("board.boardList",pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardTotal");
	}
	
	@Override
	public BoardVo selectBoard(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardView", boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("board.boardInsert", boardVo);
	}
	@Override
	public BoardVo boardModifyView(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("board.boardModifyView", boardVo);
	}
	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {
		return sqlSession.update("board.boardUpdate", boardVo);
		
	}
	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("board.boardDelete", boardVo);
	}
	@Override
	public List<BoardVo> selectBoardType(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("boardTypeList", map);
	}
	@Override
	public List<CodeVo> selectCode(String codeType) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectCode",codeType);
	}
	@Override
	public int boardTypeListCount(String[] boardType) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardTypeListCount",boardType);
	}
	@Override
	public String selectId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectId", userId);
	}
	@Override
	public int insertUser(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("insertUser", userVo);
	}
	@Override
	public String selectPw(String userPw) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectPw", userPw);
	}
	@Override
	public String selectName(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectName", userId);
	}
	@Override
	public List<BoardVo> selectAll() throws Exception {
		return sqlSession.selectList("selectAll");
		
	}
	@Override
	public int countByDate(String create_time) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("countByDate",create_time);
	}
	
	
}
