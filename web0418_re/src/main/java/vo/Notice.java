package vo;
// notice 테이브르이 한 행(레코드 / cf. 여러행 레코드셋)을 저장하는 용도
// Value Object or Date Transfer Object or Domain Type
public class Notice {
	public int noticeNo;
	public String noticeTitle;
	public String noticeContent;
	public String noticeWriter;
	public String createdate; //원래는 데이터타입을 써야함
	public String updatedate;
	public String noticePw; //한 행을 저장
}
