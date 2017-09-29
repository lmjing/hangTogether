package com.example.woojinroom.hangto;

import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.widget.ListView;

import com.example.woojinroom.hangto.listView.listViewAdapter;

/**
 * Created by woojinroom on 2017-09-25.
 */

public class mainPageActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mainpage);

        ListView listview;
        listViewAdapter adapter;

        // Adapter 생성
        adapter = new listViewAdapter();

        // 리스트뷰 참조 및 Adapter달기
        listview = (ListView) findViewById(R.id.listView);
        listview.setAdapter(adapter);

        // 첫 번째 아이템 추가.
        adapter.addItem(ContextCompat.getDrawable(this, R.drawable.test),
                "jwjpop", "content","2017.09.26 22:47");
        adapter.addItem(ContextCompat.getDrawable(this, R.drawable.test),
                "yoon", "content2","2017.09.26 22:46");
        adapter.addItem(ContextCompat.getDrawable(this, R.drawable.test),
                "lmjing", "content3","2017.09.26 22:45");
        adapter.addItem(ContextCompat.getDrawable(this, R.drawable.test),
                "subin614", "content4","2017.09.26 22:43");
    }
}
