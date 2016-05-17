package com.baidu.ueditor.upload;
import com.baidu.ueditor.define.State;
import com.baidu.ueditor.upload.Base64Uploader;
import com.baidu.ueditor.upload.BinaryUploader;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
public class Uploader { 
	private HttpServletRequest request = null; 
	private Map<String, Object> conf = null; 
	
	public Uploader(HttpServletRequest request, Map<String, Object> conf) { 
		this.request = request; this.conf = conf; 
	} 
	
	public final State doExec() { 
		String filedName = (String)this.conf.get("fieldName"); 
		State state = null; //����ԭ���߼�,��json.config�м����Ƿ�ʹ��FTP�ϴ������� 
		if ("true".equals(this.conf.get("isBase64"))) 
			state = Base64Uploader.save(this.request.getParameter(filedName), this.conf); 
		else { 
			if("true".equals(this.conf.get("useFtpUpload"))) 
//				state = FtpUploader.save(request, conf);
				state = FtpUploader.save(request);
			else 
				state = BinaryUploader.save(this.request, this.conf); 
		} 
		return state; 
	}
}