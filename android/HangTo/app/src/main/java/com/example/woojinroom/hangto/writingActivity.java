package com.example.woojinroom.hangto;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

/**
 * Created by woojinroom on 2017-09-25.
 */

public class writingActivity extends AppCompatActivity {
    private static final boolean WIRTER =true;
LinearLayout sidemenu;
    Button button_message,button_request,button_close;
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_writing);
        //if문으로 작성자일 경우 사이드메뉴 보이게 , 하단 버튼 다르게 보여주기
        TextView textView = (TextView)findViewById(R.id.title);
        textView.setText("글 보기");
        sidemenu = (LinearLayout)findViewById(R.id.sidemenu);

        ImageButton button_left =(ImageButton)findViewById(R.id.imagebutton_left);
        button_left.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view) {
                finish();
            }
        });
        if(WIRTER){ //DB값으로 작성자인지 아닌지 판단
            ImageButton button_right =(ImageButton)findViewById(R.id.imagebutton_right);
            button_right.setImageResource(R.drawable.more);
            button_right.setOnClickListener(new View.OnClickListener(){
                public void onClick(View view) {
                    sidemenu.bringToFront();
                    sidemenu.setVisibility(View.VISIBLE);

                    Button button_edit =(Button)findViewById(R.id.button_edit);
                    button_edit.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            //DB값 챙겨서 수정할 글에 뿌려주기
                            Intent edit_intent = new Intent(getApplicationContext(), writeActivity.class);
                            startActivity(edit_intent);
                        }
                    });
                    Button button_delete = (Button)findViewById(R.id.button_delete);
                    button_delete.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View v) {
                            finish();
                        }
                    });
                }
            });
            button_message =(Button) findViewById(R.id.button_message);
            button_message.setVisibility(View.GONE);
            button_request =(Button) findViewById(R.id.button_request);
            button_request.setVisibility(View.GONE);
            button_close=(Button)findViewById(R.id.button_close);
            button_close.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    finish();
                }
            });
        }else{
        ImageButton button_right =(ImageButton)findViewById(R.id.imagebutton_right);
        button_right.setVisibility(View.GONE);
            button_message =(Button) findViewById(R.id.button_message);
            button_message.setOnClickListener(new View.OnClickListener(){
                public void onClick(View view){
                    Intent message_intent = new Intent(getApplicationContext(), messageActivity.class);
                    startActivity(message_intent);
                }
            });
            button_request =(Button) findViewById(R.id.button_request);
            button_request.setOnClickListener(new View.OnClickListener(){
                public void onClick(View view){
                    Intent request_intent = new Intent(getApplicationContext(), requestActivity.class);
                    startActivity(request_intent);
                }
            });
            button_close=(Button)findViewById(R.id.button_close);
            button_close.setVisibility(View.GONE);
        }
    }
}
