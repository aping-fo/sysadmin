<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<c:if test="${searchContent!=null }">
	&nbsp;&nbsp;
	<c:if test="${searchContent==' ' }"><span>查看所有</span></c:if>
	<c:if test="${searchContent!=' ' }"><span><span>搜索内容:${searchContent}</span></span></c:if>
</c:if>
