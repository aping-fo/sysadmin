package com.matete.agentmanage.shiro;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.apache.shiro.authz.annotation.Logical;

@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface RequiresGroup {
    /**
     * 获取注解中的值，可以为一个也可以为多个
     */
    String[] value();
    
    /**
     * 获取值与值的关系 ‘并且’ and ‘或者’ or
     */
    Logical logical() default Logical.AND; 
}
