package com.spring.board.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.BoardDao;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;

@Service
public class boardServiceImpl implements boardService{
	
	@Autowired
	BoardDao boardDao;
	
	@Override
	public String selectTest() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectTest();
	}
	
	@Override
	public List<BoardVo> SelectBoardList(PageVo pageVo) throws Exception {
		// TODO Auto-generated method stub
		
		return boardDao.selectBoardList(pageVo);
	}
	
	@Override
	public int selectBoardCnt() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardCnt();
	}
	
	@Override
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception {
		// TODO Auto-generated method stub
		BoardVo boardVo = new BoardVo();
		
		boardVo.setBoardType(boardType);
		boardVo.setBoardNum(boardNum);
		
		return boardDao.selectBoard(boardVo);
	}
	
	@Override
	public int boardInsert(BoardVo boardVo) throws Exception {
		
		int[] results= new int[boardVo.getBoardVoList().size()];
		int result=1;
		
		for(int i=0; i<boardVo.getBoardVoList().size();i++) {
			if(boardVo.getBoardVoList().get(i).getBoardType()!=null) {
			results[i]=boardDao.boardInsert(boardVo.getBoardVoList().get(i));

			result *= results[i];
			}
		}
		
		return result;
	}

	@Override
	public BoardVo boardModifyView(BoardVo boardVo) throws Exception {

		return boardDao.boardModifyView(boardVo);
	}

	@Override
	public int boardUpdate(BoardVo boardVo) throws Exception {

		return boardDao.boardUpdate(boardVo);
	}

	@Override
	public int boardDelete(BoardVo boardVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardDelete(boardVo);
	}

	@Override
	public List<BoardVo> selectBoardType(HashMap<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectBoardType(map);
	}

	@Override
	public List<CodeVo> selectCode(String codeType) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectCode(codeType);
	}

	@Override
	public int boardTypeListCount(String[] boardType) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.boardTypeListCount(boardType);
	}

	@Override
	public String selectId(String userId) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectId(userId);
	}

	@Override
	public int insertUser(UserVo userVo) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.insertUser(userVo);
	}

	@Override
	public String selectPw(String userPw) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectPw(userPw);
	}

	@Override
	public String selectName(String userId) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectName(userId);
	}

	@Override
	public List<BoardVo> selectAll() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.selectAll();
	}
	
	
}
