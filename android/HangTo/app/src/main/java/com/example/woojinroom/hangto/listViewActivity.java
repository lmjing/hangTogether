package com.example.woojinroom.hangto;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;
import android.widget.TextView;

/**
 * Created by woojinroom on 2017-10-03.
 */

public class listViewActivity extends AppCompatActivity {
    ImageView imageView;
    TextView textId;
    TextView textContent;
    TextView textTime;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.listview_mainpage);
        imageView =(ImageView)findViewById(R.id.imageView);
        textId = (TextView)findViewById(R.id.textView);
        textContent = (TextView)findViewById(R.id.textView2);
        textTime = (TextView)findViewById(R.id.textView3);

        imageView.setImageResource(R.drawable.test);
        textId.setText("testID");
        textContent.setText("testContent");
        textTime.setText("testTime");

    }

}
