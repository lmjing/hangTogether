package com.example.woojinroom.hangto;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

/**
 * Created by woojinroom on 2017-10-09.
 */

public class historyActivity extends AppCompatActivity {
    Toolbar toolbar;
    TextView textView;
    ImageButton imageButtonLeft;
    ImageButton imageButtonRight;
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_history);

        toolbar = (Toolbar)findViewById(R.id.toolbar);
        textView = (TextView)toolbar.findViewById(R.id.title);
        textView.setText("히스토리");
        imageButtonLeft = (ImageButton)toolbar.findViewById(R.id.imagebutton_left);
        imageButtonLeft.setImageResource(R.drawable.left_arrow);
        imageButtonLeft.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        imageButtonRight = (ImageButton)toolbar.findViewById(R.id.imagebutton_right);
        imageButtonRight.setVisibility(View.GONE);



    }
}
