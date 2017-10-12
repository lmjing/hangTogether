package com.example.woojinroom.hangto.History;

import android.os.Bundle;
import android.support.v4.content.ContextCompat;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.TextView;

import com.example.woojinroom.hangto.R;

/**
 * Created by woojinroom on 2017-10-09.
 */

public class historyActivity extends AppCompatActivity {
    Toolbar toolbar;
    TextView textView;
    ImageButton imageButtonLeft;
    ImageButton imageButtonRight;
    ListView listview;
    listViewHistoryAdapter adapter;
    SwipeRefreshLayout pullToRefresh;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_history);

        toolbar = (Toolbar) findViewById(R.id.toolbar);
        textView = (TextView) toolbar.findViewById(R.id.title);
        textView.setText("히스토리");
        imageButtonLeft = (ImageButton) toolbar.findViewById(R.id.imagebutton_left);
        imageButtonLeft.setImageResource(R.drawable.left_arrow);
        imageButtonLeft.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        imageButtonRight = (ImageButton) toolbar.findViewById(R.id.imagebutton_right);
        imageButtonRight.setVisibility(View.GONE);

        // Adapter 생성
        adapter = new listViewHistoryAdapter();

        // 리스트뷰 참조 및 Adapter달기
        listview = (ListView) findViewById(R.id.listview_history);
        listview.setAdapter(adapter);

        // 첫 번째 아이템 추가.
        connectRecommand();
    }

    public void refresh() {

        adapter.clear();
        adapter.notifyDataSetChanged();
        connectRecommand();
    }

    void connectRecommand() {
        for (int i = 0; i < 10; i++) {
            adapter.addItem(ContextCompat.getDrawable(this, R.drawable.test),
                    "jwjpop" + i, "Context" + i, "오후 2:1" + i, "2017-10-12~2017-10-1" + (3 + i), "한국어", "영어", "일본어");
            pullToRefresh = (SwipeRefreshLayout) findViewById(R.id.pull_to_refresh);
            pullToRefresh.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
                @Override
                public void onRefresh() {
                    pullToRefresh.setRefreshing(false);
                    refresh();
                }
            });
        }


    }
}

