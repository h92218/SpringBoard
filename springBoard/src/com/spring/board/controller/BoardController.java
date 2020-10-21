package com.spring.board.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.util.SystemOutLogger;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);	
	
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo,HttpServletRequest request,HttpSession session) 
			throws Exception{
		String userId = (String)session.getAttribute("userId");
		System.out.println("세션 저장된 ID : "  + userId);
		List<BoardVo> boardList = new ArrayList<BoardVo>(); //글 가져올 List 생성
		List<CodeVo> codeList = new ArrayList<CodeVo>(); //타입 가져올 List 생성
		HashMap<String, Object> map = new HashMap<String, Object>(); //page와 checkbox 선택지 용
		HashMap<String, String> codeMap = new HashMap<String, String>(); //타입 id - name 짝 map 생성
		
		int page = 1; //페이지 초기화
		int totalCnt = 0; //totalCnt 초기화
		
		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);;
		}
		
		map.put("pageVo",pageVo); //pageVo put
		

		codeList = boardService.selectCode("menu");//타입id, 타입 이름 가져오기	
		for(int i=0; i<4;i++) {
			codeMap.put(codeList.get(i).getCodeId(),codeList.get(i).getCodeName());
		}//타입id, 타입 이름List Map에 담기
		
		
		String[] boardType; //checkbox 선택지 가져올 배열 생성
		boardType=request.getParameterValues("boardType"); //checkbox 선택지 가져오기
		map.put("boardType", boardType);//checkbox 선택지 map에 담기 
		
		
		boardList = boardService.selectBoardType(map);//pageVo와 checkbox 선택지 넘김
		
		totalCnt = boardService.boardTypeListCount(boardType); //checkbox 선택지 넘김 
		 
		String userName=""; //로그인한 ID로 이름 가져오기
		if(userId !=null) {
			userName = boardService.selectName(userId);
			session.setAttribute("userName", userName);
		}else {
			session.setAttribute("userName", "SYSTEM");
		}
		
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		model.addAttribute("codeList",codeList);
		model.addAttribute("codeMap",codeMap);
		model.addAttribute("userId",userId);
		model.addAttribute("userName", userName);
		
		return "board/boardList";
	}
	//글 상세 페이지
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		List<CodeVo> codeList = new ArrayList<CodeVo>();

		codeList = boardService.selectCode("menu");
		HashMap<String, String> codeMap = new HashMap<String, String>();
		for(int i=0; i<4;i++) {
			codeMap.put(codeList.get(i).getCodeId(),codeList.get(i).getCodeName());
		}
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		String userId= boardVo.getCreator();
		String userName;
		if(userId!="SYSTEM") {
			userName = boardService.selectName(userId);
		}else {
			userName="SYSTEM";
		}
		
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		model.addAttribute("codeMap",codeMap);
		model.addAttribute("userName",userName);
		
		return "board/boardView";
	}
	
	//글쓰기 폼 호출
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model,HttpServletRequest request,HttpSession session) throws Exception{
		List<CodeVo> codeList= new ArrayList<CodeVo>();
		codeList = boardService.selectCode("menu");
		
		String userName = (String)session.getAttribute("userName");
		String userId = (String)session.getAttribute("userId");
		
		
		model.addAttribute("codeList",codeList);
		model.addAttribute("userName",userName);
		model.addAttribute("userId",userId);
		return "board/boardWrite";
	}
	
	
	
	//글등록 수행
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale, BoardVo boardVo) throws Exception{
	
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		int resultCnt = 0;
		
		System.out.println(boardVo.getBoardVoList().get(0).getBoardType());
		System.out.println(boardVo.getBoardVoList().get(0).getBoardTitle());
		System.out.println(boardVo.getBoardVoList().get(0).getCreator());
		
		
		resultCnt=boardService.boardInsert(boardVo);
		System.out.println("result Count : " + resultCnt);
		/*StringTokenizer Type = new StringTokenizer(boardVo.getBoardType(),",");
		StringTokenizer Title = new StringTokenizer(boardVo.getBoardTitle(),",");
		StringTokenizer Comment = new StringTokenizer(boardVo.getBoardComment(),",");
		
		while(Type.hasMoreTokens())
		{
		
			
			boardVo.setBoardType(Type.nextToken());
			boardVo.setBoardTitle(Title.nextToken());
			boardVo.setBoardComment(Comment.nextToken());
			
			resultCnt = boardService.boardInsert(boardVo);
		}*/
		
	
		/*result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);*/
		
		String resultmsg="";
		if (resultCnt>0) {
			resultmsg="<script>alert('SUCCESS');location.href='/board/boardList.do'</script>";
		}else {
			resultmsg="<script>alert('FAIL');location.href='/board/boardWrite.do'</script>";

		}
		return resultmsg;
		
	}
	
	//글 수정페이지 호출
	@RequestMapping(value="/board/boardModify.do", method=RequestMethod.GET)
	public String boardModifyView(BoardVo boardVo,Model model)throws Exception {
		
		boardVo=boardService.boardModifyView(boardVo);
		
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		codeList = boardService.selectCode("menu");
		HashMap<String, String> codeMap = new HashMap<String, String>();
		for(int i=0; i<4;i++) {
			codeMap.put(codeList.get(i).getCodeId(),codeList.get(i).getCodeName());
		}
		
		String userId= boardVo.getCreator();
		String userName;
		if(userId!="SYSTEM") {
			userName = boardService.selectName(userId);
		}else {
			userName="SYSTEM";
		}
		
		model.addAttribute("board", boardVo);
		model.addAttribute("codeMap",codeMap);
		model.addAttribute("userName",userName);
		
		return "board/boardModify";
	}
	
	
	//수정완료 누른 후
	@RequestMapping(value="/board/boardModifyAction.do", method=RequestMethod.POST)
	@ResponseBody
	public String boardModify(BoardVo boardVo,Model model)throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
	
		int resultCnt = boardService.boardUpdate(boardVo);

		
		result.put("success", (resultCnt > 0)?"Y":"N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	//글삭제
	@RequestMapping(value="/board/boardDelete.do", method=RequestMethod.POST)
	@ResponseBody
	public String boardDelete(BoardVo boardVo)throws Exception {
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		System.out.println("삭제시  넘기는 VO num : " + boardVo.getBoardNum()+ "\n");
		System.out.println("삭제시  넘기는 VO Type : " + boardVo.getBoardType()+ "\n");
		
		int resultCnt=boardService.boardDelete(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	//회원가입
	@RequestMapping(value="/board/boardJoin.do", method=RequestMethod.GET)
	public String boardJoin(Model model, UserVo userVo)throws Exception{
		List<CodeVo> codeList = new ArrayList<CodeVo>();
		codeList = boardService.selectCode("phone");
		
		model.addAttribute("codeList",codeList);
		
		
		return "board/boardJoin";
	}

	//Id 중복체크
	@RequestMapping(value="board/checkId.do", method=RequestMethod.POST)
	@ResponseBody
	public String checkId(String userId)throws Exception{
		System.out.println("넘어온 Id : " + userId);
		
		String checkId=boardService.selectId(userId);
		String result;
		if(checkId==null) { //아이디 없어서 사용가능한경우 
			result="{\"result\" : \"idAvailable\"}";
		}else { //아이디 있어서 사용 불가능한 경우 
			result="{\"result\" : \"idNotAvailable\"}";
		}
		
		System.out.println(result);
		return result;
	}
	
	//회원가입 처리
	@RequestMapping(value="/board/boardJoinAction.do", method=RequestMethod.POST, 
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String boardJoinAction(Model model, UserVo userVo)throws Exception{
		System.out.println("userId : " + userVo.getUserId());
		System.out.println("userName : " + userVo.getUserName());
		
		String result;		
		int insertUser = boardService.insertUser(userVo);
		
		System.out.println("insertUsert : " + insertUser);
		if(insertUser>0) {
			result = "{\"result\" : \"회원가입 성공\"}";
		}else {
			result = "{\"result\" : \"회원가입 실패\"}";
		}
		System.out.println("result : " + result);
		return result;
	}
	
	
	//로그인 폼 호출
	@RequestMapping(value="/board/LoginForm.do", method=RequestMethod.GET)
	public String LoginForm(Model model){
		
		return "board/boardLoginForm";
	}
	
	//로그인  액션
	@RequestMapping(value="/board/LoginAction.do", method=RequestMethod.POST, produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String LoginAction(Model model,String userId, String userPw,HttpServletRequest request,HttpSession session) 
			throws Exception{
		System.out.println("전달받은 id : " + userId);
		System.out.println("전달받은 pw : " + userPw);
		
		String result;
		
		if(boardService.selectId(userId)==null) {
			System.out.println("userId null 진입");
			result="{\"result\" : \"존재하지 않는 ID\"}";
		}else if(boardService.selectPw(userPw)==null){
			System.out.println("password null 진입");
			result="{\"result\" : \"비밀번호가 틀렸습니다\"}";
		}else {
			System.out.println("login success 진입");
			result="{\"result\" : \"로그인 성공\"}";
			session.setAttribute("userId", userId);
			}				

		return result;
	}
	
	
	//로그아웃 액션
	@RequestMapping(value="/board/Logout.do")
	public String Logout(Model model, HttpServletRequest request, HttpSession session)
	throws Exception{
		session.invalidate();
		
		return "redirect:/board/boardList.do";
	}
	
	


	//엑셀로 출력하기
	@RequestMapping(value="/board/excelDown.do")
	public void excelDown(HttpServletResponse response) throws Exception {
		
		//게시판 목록조회
		List<BoardVo> boardList = boardService.selectAll();
		
		//1. 워크북 생성(생성하고자 하는 엑셀 형태에 따른 선언)
		Workbook wb = new XSSFWorkbook(); //xlsx 엑셀 2007 이상

		
		//2. 시트 생성 및 시트명 설정(매개변수를 비우면 default)
		Sheet sheet1 = wb.createSheet("test");
		
		//3. 열 너비 설정
		sheet1.setColumnWidth(0, 5500);
		sheet1.setColumnWidth(1, 5500);
		sheet1.setColumnWidth(2, 5500);
		sheet1.setColumnWidth(3, 5500);
		sheet1.setColumnWidth(4, 5500);
		
		//4.테이블 헤더 스타일 지정
		CellStyle headStyle = wb.createCellStyle();
			//데이터 가운데 정렬
		headStyle.setAlignment(HorizontalAlignment.CENTER);
			//경계선
	    headStyle.setBorderTop(BorderStyle.THIN);
	    headStyle.setBorderBottom(BorderStyle.THIN);
	    headStyle.setBorderLeft(BorderStyle.THIN);
	    headStyle.setBorderRight(BorderStyle.THIN);
	    	// 배경색은 연두색
	    headStyle.setFillForegroundColor(HSSFColorPredefined.LIGHT_GREEN.getIndex());
	    headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	
		
		//5. 헤더 생성
		Row row = null;
		Cell cell = null;
		int rowNo = 0;
		
		row = sheet1.createRow(rowNo++);
		
		cell = row.createCell(0);
		cell.setCellStyle(headStyle);
		cell.setCellValue("boardType");
		
		cell = row.createCell(1);
		cell.setCellStyle(headStyle);
		cell.setCellValue("boardNum");
		
		cell = row.createCell(2);
		cell.setCellStyle(headStyle);
		cell.setCellValue("boardTitle");
		
		cell = row.createCell(3);
		cell.setCellStyle(headStyle);
		cell.setCellValue("boardComment");
		
		cell = row.createCell(4);
		cell.setCellStyle(headStyle);
		cell.setCellValue("Creator");
		
		//6. 테이블 바디 스타일 지정
		CellStyle bodyStyle = wb.createCellStyle();
			//데이터 가운데 정렬
		bodyStyle.setAlignment(HorizontalAlignment.CENTER);
			//경계선
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		//7. 데이터 부분 생성
		for(BoardVo vo : boardList) {
		row = sheet1.createRow(rowNo++);
			
		cell = row.createCell(0);
		cell.setCellStyle(bodyStyle);
		cell.setCellValue(vo.getBoardType());
		
		cell = row.createCell(1);
		cell.setCellStyle(bodyStyle);
		cell.setCellValue(vo.getBoardNum());
		
		cell = row.createCell(2);
		cell.setCellStyle(bodyStyle);
		cell.setCellValue(vo.getBoardTitle());
		
		cell = row.createCell(3);
		cell.setCellStyle(bodyStyle);
		cell.setCellValue(vo.getBoardComment());
		
		cell = row.createCell(4);
		cell.setCellStyle(bodyStyle);
		cell.setCellValue(vo.getCreator());
		
		}
		
		//8. 컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		 response.setHeader("Content-Disposition", "attachment;filename=test.xlsx");

		//9. 엑셀 출력
		  wb.write(response.getOutputStream());
		  wb.close();	
		
	}
	
	//엑셀에 달력출력 
	@RequestMapping(value="/board/Calendar.do")
	public void calendar (HttpServletResponse response, HttpServletRequest request) throws Exception{
		String req_month = request.getParameter("req_month");
		String req_year = request.getParameter("req_year");

		Calendar calendar = Calendar.getInstance();
		
		//월 구하기 (-1)
		System.out.println("선택 월 : " + req_month);

		int month=0;
		month= Integer.parseInt(req_month)-1;
		

		
		//년도 구하기
		String year = "";
		
		year=req_year;
		
		
		System.out.println("선택 년도 : " + year);

		//1일의 요일 구하기
		calendar.set(2020,month,1);
		int day1=calendar.get(Calendar.DAY_OF_WEEK);
		System.out.println("1일의 요일 : " + day1);
		
		//일 수 구하기
		int days = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		System.out.println("일 수 : " + days);
		
		//주 수 구하기
		int weeks = calendar.getActualMaximum(Calendar.WEEK_OF_MONTH);
		System.out.println("주 수 : " + weeks);
		
	
		//표시용 월
		month =  month+1;
		System.out.println("월 : " + month);
		

		
		//파일 읽기
		FileInputStream fis = new FileInputStream("C:\\Users\\TOPIA\\Desktop\\calendar.xlsx");
		//워크북 생성
		Workbook wb = new XSSFWorkbook(fis);
		//시트 읽기
		Sheet sheet = wb.getSheetAt(0);
		
		//행의 수 읽기
		int rows =sheet.getPhysicalNumberOfRows();
		//열의 수 읽기
		Row row = sheet.getRow(0);
		int cells = row.getPhysicalNumberOfCells();
		Cell cell=null;
		
		//시트 생성 
		Sheet sheet1 = wb.createSheet("calender");	

		//숫자 쓸 폰트 지정
		Font font = wb.createFont();
		font.setColor(HSSFColorPredefined.WHITE.getIndex());
		
		//요일 헤더 스타일 지정
		CellStyle dayStyle = wb.createCellStyle();
			//데이터 가운데 정렬
		dayStyle.setAlignment(HorizontalAlignment.CENTER);
			//경계선
		dayStyle.setBorderTop(BorderStyle.THIN);
		dayStyle.setBorderBottom(BorderStyle.THIN);
			// 배경색은 노란색
		dayStyle.setFillForegroundColor(HSSFColorPredefined.LIGHT_YELLOW.getIndex());
		dayStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		Row calendarRow=null;
		Cell calendarCell=null;
		
		int rowindex=0;
		int columnindex=0;
		
		
		//월 표시
		calendarRow = sheet1.createRow(rowindex);
		calendarCell  = calendarRow.createCell(0);
		System.out.println("표시 직전 월 : " + month);
		calendarCell.setCellValue(month);
		calendarCell  = calendarRow.createCell(1);
		calendarCell.setCellValue("월");
		rowindex++;//rowindex=1
		
		
		//요일 행 만들기
		calendarRow = sheet1.createRow(rowindex);
		String[] daystring= {"일","월","화","수","목","금","토"};
		int dayorder=0;
		
		for(int i=0;i<7*cells;i++) {
		calendarCell = calendarRow.createCell(i);
		calendarCell.setCellStyle(dayStyle);
		
		if(i%cells==1) {
			calendarCell.setCellValue(daystring[dayorder]);
			dayorder++;
		}
		
		} rowindex++; //rowindex==2;
					

		//셀 스타일 읽어와서 담기
		CellStyle[][] bodystyle = new CellStyle[rows][cells];
		for(int rownum=0;rownum<rows;rownum++) {
			row = sheet.getRow(rownum);
			for(int cellnum=0;cellnum<cells;cellnum++) {
				cell=row.getCell(cellnum);
				bodystyle[rownum][cellnum]=cell.getCellStyle(); 
				if(rownum==0) {
					bodystyle[rownum][cellnum].setFont(font);
				}
			}
		}
		
		//월앞에 0붙이기
		String Month=Integer.toString(month);
		if(month>=1 && month<=9) {
			Month = "0"+Integer.toString(month);
		}
		
		//년도 두자리 자르기
		String Year = year.substring(2,4);		
		
		String create_time="";		
		String Dayofmonth="";
		
		//달력 표 만들기
		int AbsoluteRowNum = 2;
		int dayofmonth=1;
		int createDay=1;
	
		for(int weekrow=0;weekrow<weeks;weekrow++) { //n개 주를 만들때까지 반복 , weeks = 그달의 주 수 

			for(int rownum=0;rownum<rows;rownum++) {
				calendarRow = sheet1.createRow(AbsoluteRowNum++);//행 만들기 
	
					
				for(int daynum=0;daynum<7;daynum++) {
					for(int cellindex=0;cellindex<cells;cellindex++) {
						//셀 만들기
						calendarCell = calendarRow.createCell(cells*daynum+cellindex);
						calendarCell.setCellStyle(bodystyle[rownum][cellindex]);
						
						//셀값설정 : 숫자 2~막날
						if(rownum==0 && cellindex==1 && dayofmonth<=days && dayofmonth>=2) {
							calendarCell.setCellValue(dayofmonth);
							dayofmonth++;
						}
						//셀값설정 : 숫자 1		
						if(weekrow==0 && rownum ==0 && day1 == daynum+1 && cellindex==1) {
							calendarCell.setCellValue(dayofmonth);
							dayofmonth++;
							
						}
						
						//셀값 설정 : 글 갯수 (2일~ 막날)
						if(rownum==2 && cellindex==1 && createDay>=2 & createDay <=days) {
							if(createDay>=1&&createDay<=9) {Dayofmonth="0"+Integer.toString(createDay);}
							else {Dayofmonth = Integer.toString(createDay);}
							create_time=Year+"/"+Month + "/"+Dayofmonth;
							calendarCell.setCellValue("글" + boardService.countByDate(create_time) + "개");	
							createDay++;
						}
		
						
						//셀값설정 : 글개수 입력 (1일)
						if(weekrow == 0 && rownum==2 && day1 == daynum+1 && cellindex==1 ) {
							if(createDay>=1&&createDay<=9) {Dayofmonth="0"+Integer.toString(createDay);}
							else {Dayofmonth = Integer.toString(createDay);}
							create_time= Year+"/"+Month + "/" +Dayofmonth;
							calendarCell.setCellValue("글" + boardService.countByDate(create_time) + "개");	
							createDay++;
						}				
										
					}
				}				
			}
		}
			
		//컨텐츠 타입과 파일명 지정
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename=calentdar_test.xlsx");

		//엑셀 출력
		wb.write(response.getOutputStream());
		wb.close();
		
			
		}//달력출력 끝 
	
	
	//글 타입 조회 AJAX처리
	@RequestMapping(value="/board/boardTypeList.do", method=RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public String BoardTypeList(HttpServletRequest request,Model model) throws Exception {
		System.out.println("ajax 시작 ");
		HashMap<String, Object> map = new HashMap<String, Object>(); //page와 checkbox 선택지 용
		String[] boardType; //checkbox 선택지 가져올 배열 생성
		boardType=request.getParameterValues("boardType"); //checkbox 선택지 가져오기
		for(int i=0; i<boardType.length;i++) {
			System.out.println("선택한 checkbox[" + i + "] : " + boardType[i] );
		}
		map.put("boardType", boardType);//checkbox 선택지 map에 담기 
		
		
		
		PageVo pageVo = new PageVo();
		pageVo.setPageNo(1);
		map.put("pageVo",pageVo); //pagevo map에 담기
		
		List<BoardVo> boardList = new ArrayList<BoardVo>(); //글 가져올 List 생성
		boardList = boardService.selectBoardType(map);//pageVo와 checkbox 선택지 넘김
		
		int totalCnt = 0; //totalCnt 초기화
		totalCnt = boardService.boardTypeListCount(boardType); //checkbox 선택지 넘김
		
		HashMap<String, String> codeMap = new HashMap<String, String>(); //타입 id - name 짝 map 생성
		List<CodeVo> codeList = new ArrayList<CodeVo>(); //타입 가져올 List 생성
		codeList = boardService.selectCode("menu");//타입id, 타입 이름 가져오기	
		for(int i=0; i<4;i++) {
			codeMap.put(codeList.get(i).getCodeId(),codeList.get(i).getCodeName());
		}//타입id, 타입 이름List Map에 담기
		
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		CommonUtil commonUtil = new CommonUtil();
		result.put("list", boardList);
		result.put("totalCnt", totalCnt);
		result.put("codeMap", codeMap);
		
		String result1 = commonUtil.getJsonCallBackString(" ", result);
		System.out.println("result1 : " + result1);
		
		model.addAttribute("codeMap",codeMap);
		model.addAttribute("totalCnt", totalCnt);
		return result1;
	}
	
	
}
