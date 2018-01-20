package com.matete.agentmanage.model;

public class ResponseResult {

    private boolean isSuccess;
    private String errorMsg;

    public ResponseResult(boolean isSuccess, String errorMsg) {
        super();
        this.isSuccess = isSuccess;
        this.errorMsg = errorMsg;
    }
    
    public ResponseResult(boolean isSuccess) {
        super();
        this.isSuccess = isSuccess;
    }

	public boolean isSuccess() {
		return isSuccess;
	}

    public void setSuccess(boolean isSuccess) {
        this.isSuccess = isSuccess;
    }

    public String getErrorMsg() {
        return errorMsg;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

}
