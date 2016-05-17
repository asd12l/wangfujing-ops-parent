package com.wangfj.cms.dto;

public class MessageDto {
	private MsgHeaderDto header;
    private Object data;

    public MsgHeaderDto getHeader() {
        return header;
    }

    public void setHeader(MsgHeaderDto header) {
        this.header = header;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

}
