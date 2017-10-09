package com.example.woojinroom.hangto;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;

import com.example.woojinroom.hangto.TabActivity.TabActivity_;

/**
 * Created by woojinroom on 2017-09-25.
 */

public class searchActivity extends AppCompatActivity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_search);

        Intent main_intent = new Intent(getApplicationContext(), TabActivity_.class);
        startActivity(main_intent);
        finish();
        // 글쓰고 메인으로 돌아오는 로직인데 startActivity가 맞나?? 이미 Tab 액티비티가 생성되어 있는데 추가생성인지, 다시불러온건지 확인필요.
        // 확인결과 새창 띄우는거 같음. 기존 창을 제거하고 띄우거나 기존창으로 가는 알고리즘 필요
        // 검색결과로 재 출력
    }
}
