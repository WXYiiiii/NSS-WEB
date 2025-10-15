package com.entity.view;

import com.entity.ExamrecordEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
 

/**
 * 答题记录表
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2022-04-25 15:16:17
 */
@TableName("examrecord")
public class ExamrecordView  extends ExamrecordEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	// 用于排行榜显示参与答题次数
	private Integer paperCount;

	public Integer getPaperCount() {
		return paperCount;
	}

	public void setPaperCount(Integer paperCount) {
		this.paperCount = paperCount;
	}

	public ExamrecordView(){
	}
 
 	public ExamrecordView(ExamrecordEntity examrecordEntity){
 	try {
		BeanUtils.copyProperties(this, examrecordEntity);
	} catch (IllegalAccessException | InvocationTargetException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
 		
	}
}
