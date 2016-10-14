package com.wangfj.pay.web.exception;


/**
 * 支付业务异常
 * @author yangyinbo
 *
 */
public class payBizException extends Throwable {

	
	private static final long serialVersionUID = 1L;

	public payBizException() {
		super();
	}

	public payBizException(String message, Throwable cause) {
		super(message, cause);
	}

	public payBizException(String message) {
		super(message);
	}

	public payBizException(Throwable cause) {
		super(cause);
	}

	/**
	 * 减少异常栈深度,提高性能.
	 * @return
	 * @author admin
	 * @date 2013-1-31 下午3:30:30
	 */
	@Override
	public Throwable fillInStackTrace() {
		return this;
	}

}
