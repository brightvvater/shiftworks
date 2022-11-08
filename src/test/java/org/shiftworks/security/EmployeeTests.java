package org.shiftworks.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@Log4j
public class EmployeeTests {

	@Autowired
	private PasswordEncoder pwEncoder;
	
	@Autowired
	private DataSource ds;
	
	// ����� �߰�
	@Test
	public void testInsertMember() {
		String sql = "INSERT INTO employee(emp_id,password, dept_id) values(?, ?, ?)";
		
		for(int i=0; i<70; i++) {
			Connection con = null;
			PreparedStatement pstmt = null;
			
			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);
				
				// pw1, pw2, pw3... �������� ��й�ȣ ����
				pstmt.setString(2, pwEncoder.encode("pw" + i));
				
				if(i<21) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(3, "dept1");
				}else if(i<41) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(3, "dept2");
				
				}else if(i<61) {
					pstmt.setString(1, "user" + i);
					pstmt.setString(3, "dept3");
				
				}else {
					pstmt.setString(1, "admin" + i);
					pstmt.setString(3, "infosecu");			
				}
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				// �ڿ� �ݳ�
				if(pstmt != null) { try {pstmt.close();} catch(Exception e) {} }
				if(con != null) { try {con.close();} catch(Exception e) {} }
			}
		}// end for1

	}// end test
	

}
