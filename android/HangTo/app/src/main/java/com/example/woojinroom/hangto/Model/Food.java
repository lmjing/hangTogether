package com.example.woojinroom.hangto.Model;

import android.widget.ImageView;

import com.example.woojinroom.hangto.R;

import java.util.List;

/**
 * Created by kksd0900 on 16. 9. 29..
 */
public class Food {
    public String id;
    public String content;
    public String time;
    public String day;
    public String ranguage1;
    public String ranguage2;
    public String ranguage3;

    // DO NOT USE GET / SET METHOD

    public static Food mockFood(int index) {
        Food food = new Food();
        food.id = "jwjpop" + index;
        food.content = "HangTogether!!!! :) " + index;
        food.time = "오후 2:1"+index;
        food.day = "2017-10-10 ~ 2017-10-1"+ index;
        food.ranguage1 ="한국어";
        food.ranguage2 ="영어";
        food.ranguage3 ="일본어";
        return food;
    }
    public static Food alarm(int index) {
        Food food = new Food();
        food.id = "jwjpop" + index;
        food.content = "님이 회원님께 \n 동행을 신청했습니다. " + index;
        return food;
    }
}
