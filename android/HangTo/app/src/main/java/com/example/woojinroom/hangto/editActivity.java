package com.example.woojinroom.hangto;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

/**
 * Created by woojinroom on 2017-10-09.
 */

public class editActivity extends AppCompatActivity {
Toolbar toolbar;
    TextView textView;
    ImageButton imageButtonLeft,imageButtonRight;
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit);
        toolbar = (Toolbar)findViewById(R.id.toolbar);
        textView = (TextView)toolbar.findViewById(R.id.title);
        textView.setText("회원 정보 수정");

        imageButtonLeft = (ImageButton)toolbar.findViewById(R.id.imagebutton_left);
        imageButtonLeft.setImageResource(R.drawable.left_arrow);
        imageButtonLeft.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        imageButtonRight = (ImageButton)toolbar.findViewById(R.id.imagebutton_right);
        imageButtonRight.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(getApplicationContext(),"정보 수정 완료",Toast.LENGTH_SHORT).show();
            }
        });


    }
}
