<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>
<%@ page import="java.awt.Image"%>
<%@ page import="java.awt.Graphics2D" %>
<%@ page import="java.awt.image.renderable.ParameterBlock" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="javax.media.jai.JAI" %>
<%@ page import="javax.media.jai.RenderedOp" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리

//파일 저장 폴더 생성 경로(프로젝트 안에 upload 폴더 생성 및 지정 추천) 
//String uploadPath=request.getRealPath("/upload");
String uploadPath="C:\\jsp\\jjh\\src\\main\\webapp\\upload"; //window 폴더 내 upload 경로
int size=10*1024*1024; //파일 최대 사이즈 (10메가)

MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String code = multi.getParameter("code");
String gongji = multi.getParameter("gongji");
String subject = multi.getParameter("subject");
String comment = multi.getParameter("comment");

//답변관련 변수 두개
int fid = Integer.parseInt(multi.getParameter("fid"));
String thread=multi.getParameter("thread");

Enumeration files=multi.getFileNames();

//첨부파일1
String file1=(String)files.nextElement(); //첨부파일1 존재한다면
String file1_name=multi.getOriginalFileName(file1); //사용자가 올린 파일명
String file1_rename=multi.getFilesystemName(file1); //중복된 파일명을 새로운 파일명으로 변경
String file1_thumb = "";

if(file1_name == null){ //첨부파일1 없다면
	file1_name = ""; //null 값이 아닌 비어있는 값으로 대체
	file1_rename = ""; //null 값이 아닌 비어있는 값으로 대체
	file1_thumb = "";
}

	//// 썸네일 ////
	String oPath = uploadPath+"/"+file1_rename; // 원본 경로
	File oFile = new File(oPath);

	int index = oPath.lastIndexOf(".");
	String ext = oPath.substring(index + 1); // 파일 확장자

	file1_thumb = "thumb_" + oFile.getName(); //썸네일 파일명
	String tPath = oFile.getParent() + File.separator + file1_thumb; // 썸네일 저장 경로 및 파일명
	File tFile = new File(tPath);

	double ratio = 2; // 이미지 축소 비율

	try {

		BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
		int tWidth = (int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
		int tHeight = (int) (oImage.getHeight() / ratio); // 생성할 썸네일이미지의 높이
		BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
		Graphics2D graphic = tImage.createGraphics();
		Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
		graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
		graphic.dispose(); // 리소스를 모두 해제
		ImageIO.write(tImage, ext, tFile); //썸네일 저장
	} catch (IOException e) {
		e.printStackTrace();
	}

	//thread 값 설정
	//locate('AB' , 'ABA') = 1 :: 첫항의 'AB'가 두번째 항의 내용 중에 1번째 자리부터 매칭이 있는지 여부
	String sql_fid = "select right(thread,1) as thread_right from board where fid = "+fid+" AND length(thread) = length('"+thread+"')+1 AND locate('"+thread+"',thread) = 1 ORDER BY thread DESC limit 1";

	Connection conn_count=DriverManager.getConnection(url, user, password);
	Statement stmt_count=conn_count.createStatement();
	ResultSet rs_count=stmt_count.executeQuery(sql_fid);

	String new_thread  = thread + "A";

	if(rs_count.next()){ //형제 thread 추출
		String r_thread = rs_count.getString("thread_right");
		new_thread  = thread + (char)(r_thread.charAt(0) + 1);

	}
	
//작성일
Date now = new Date();
String strNow1 = now.toString();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = sdf.format(now);

String sql = "insert into board (code,id,name,subject,comment,signdate,gongji,file1,file1_o,file1_s, fid, thread) values ('"+code+"','"+session_id+"','"+session_nickname+"','"+subject+"','"+comment+"','"+signdate+"','"+gongji+"','"+file1_rename+"','"+file1_name+"','" + file1_thumb + "','"+fid+"','"+new_thread+"')";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

response.sendRedirect("list.jsp?code="+code);
%>












