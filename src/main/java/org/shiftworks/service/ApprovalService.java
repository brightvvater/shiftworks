package org.shiftworks.service;

import java.util.List;

import org.shiftworks.domain.ApprovalDTO;
import org.shiftworks.domain.ApprovalVO;
import org.shiftworks.domain.Criteria;
import org.shiftworks.domain.TempApprovalVO;


public interface ApprovalService {
	
	// 결재 문서 생성, 조회
//	public List<ApprovalDTO> getList();
	public int insertForm(ApprovalVO approval);
	public ApprovalVO get(int apr_id);
	public List<ApprovalDTO> getList(Criteria cri);
	public int getTotal();
	public List<ApprovalDTO> getReceivedList(Criteria cri);
	
	// 결재 상태 변경
	public boolean update(ApprovalVO approval);
	public void updateStatus(int apr_id, String status);
	
	// 임시저장 구현
	public void temporalApr(TempApprovalVO vo);
	public List<TempApprovalVO> tempList(String emp_id);
	public TempApprovalVO tempSelect(int temp_id);
//	public TempApprovalVO temporalSelect(String emp_id);
	
	// 파일 업로드
	
	
}
