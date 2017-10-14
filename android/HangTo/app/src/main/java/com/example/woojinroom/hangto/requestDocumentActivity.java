package com.example.woojinroom.hangto;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TextView;

/**
 * Created by woojinroom on 2017-10-14.
 */

public class requestDocumentActivity extends AppCompatActivity {

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_requestdocument);

        Button button_admit = (Button) findViewById(R.id.button_admit);
        button_admit.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {

                finish();
            }
        });
        ImageButton button_left = (ImageButton) findViewById(R.id.imagebutton_left);
        button_left.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                //if 문으로 회원가입 완료되는지 확인 후 메인페이지로 넘어감
                finish();
            }
        });
        ImageButton button_right = (ImageButton) findViewById(R.id.imagebutton_right);
        button_right.setVisibility(View.GONE);
        TextView title = (TextView) findViewById(R.id.title);
        title.setText("신청서");
    }
}
