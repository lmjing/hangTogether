package com.example.woojinroom.hangto;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.support.v4.content.ContextCompat;
import android.support.v7.app.AppCompatActivity;
import android.widget.ListView;

import com.example.woojinroom.hangto.TabActivity.TabActivity_;
import com.example.woojinroom.hangto.listView.listViewAdapter;
import org.androidannotations.annotations.AfterViews;
import org.androidannotations.annotations.Background;
import org.androidannotations.annotations.EActivity;
import org.androidannotations.annotations.UiThread;
import org.androidannotations.annotations.ViewById;

/**
 * Created by woojinroom on 2017-09-25.
 */
@EActivity(R.layout.activity_mainpage)
public class mainPageActivity extends AppCompatActivity {
   mainPageActivity activity;
  /*  @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mainpage);

    }*/

    @AfterViews
    void afterBindingView() {
        this.activity = this;

        /*ListView listview;
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
                "subin614", "content4","2017.09.26 22:43");*/
//        setSupportActionBar(cs_toolbar);
//        getSupportActionBar().setTitle("스플래쉬");

        // 로그인 성공 후 시작
        final Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                Intent intent = new Intent(activity, TabActivity_.class);
                startActivity(intent);
                finish();
            }
        }, 0);
    }
    @UiThread
    void uiThread() {

    }
}
