package com.cai.math;

import java.util.ArrayList;
import java.util.Stack;

import static java.lang.System.out;

/**
 * 目标：java实现直接算出中缀表达式：例：3+2*5-6的值
 * 思路：1.分别把数字，和符号放入两个栈中
 *      2.如果是数字：直接入数字栈
 *      3.如果是符号，当前符号的优先级别小于等于上一个符号，数字栈pop两个值，符号栈pop出一个符号运算，值放入数字栈，当前符号入符号栈
 *                  当前符号的优先级大于上一个符号，符号直接入符号栈
 *      4.一次取出数字栈的值，符号栈的符号，依次运算，值入数字栈
 *      5.知道数字栈中只有一个值（或者符号栈为空）结束，取出数字栈的当前值为最终结果
 */
public class Test {
    public void fun(){
        int count=1;
        out.println("EXP-----------");
        int a=1;
        if(a==1){
            count=count+1;
        }
        else if(a==2){
            count=count-1;
        }
        System.out.println(count);
    }
    public static void main(String[] args) {
    }
}