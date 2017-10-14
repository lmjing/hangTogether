package com.example.woojinroom.hangto;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

import com.example.woojinroom.hangto.TabActivity.TabActivity_;

/**
 * Created by woojinroom on 2017-09-25.
 */

public class writeActivity extends AppCompatActivity {

    Button button_start,button_end;
    Toolbar toolbar;
    TextView textView,spot1;
    ImageButton imageButtonLeft;
    ImageButton imageButtonRight;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_write);
        toolbar = (Toolbar)findViewById(R.id.toolbar);
        textView = (TextView)toolbar.findViewById(R.id.title);

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
            public void onClick(View v) { //글 작성 완료되면 글을 디비에 넣고 메인페이지 리로드
                Toast.makeText(getApplicationContext(),"글 작성 완료",Toast.LENGTH_SHORT).show();
            }
        });

        TextView title=(TextView)findViewById(R.id.title);
        title.setText("글 작성");
        button_start =(Button) findViewById(R.id.time_start);
        button_start.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                showDialog(1);
            }
        });
        button_end = (Button)findViewById(R.id.time_end);
        button_end.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                showDialog(2);
            }
        });
        spot1 =(TextView)findViewById(R.id.spot1);
        spot1.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                Intent spot_intent = new Intent(getApplicationContext(), spotActivity.class);
                startActivity(spot_intent);
            }
        });
    }

    protected Dialog onCreateDialog(int id) {
        switch(id){
            case 1 :
                DatePickerDialog dpd_start = new DatePickerDialog
                        (this, // 현재화면의 제어권자
                                new DatePickerDialog.OnDateSetListener() {
                                    public void onDateSet(DatePicker view,
                                                          int year, int monthOfYear,int dayOfMonth) {
                                        button_start.setText(year+"-"+(monthOfYear+1)+"-"+dayOfMonth);
                                    }
                                }
                                , // 사용자가 날짜설정 후 다이얼로그 빠져나올때
                                //    호출할 리스너 등록
                                2017, 9, 12); // 기본값 연월일

                return dpd_start;
            case 2 :
                DatePickerDialog dpd_end = new DatePickerDialog
                        (this, // 현재화면의 제어권자
                                new DatePickerDialog.OnDateSetListener() {
                                    public void onDateSet(DatePicker view,
                                                          int year, int monthOfYear,int dayOfMonth) {
                                        button_end.setText(year+"-"+(monthOfYear+1)+"-"+dayOfMonth);
                                    }
                                }
                                , // 사용자가 날짜설정 후 다이얼로그 빠져나올때
                                //    호출할 리스너 등록
                                2017, 9, 12); // 기본값 연월일
                return dpd_end;
        }

        return super.onCreateDialog(id);
    }


}
