package com.example.woojinroom.hangto;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import com.example.woojinroom.hangto.TabActivity.TabActivity_;

/**
 * Created by woojinroom on 2017-10-09.
 */

public class spotActivity extends AppCompatActivity {
    Toolbar toolbar;
    TextView textView;
    Button button_spot;
    ToggleButton button_toggle;
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_spot);
        toolbar = (Toolbar)findViewById(R.id.toolbar);
        textView = (TextView) toolbar.findViewById(R.id.title);
        textView.setText("장소 추가");
        ImageButton button_left =(ImageButton)findViewById(R.id.imagebutton_left);
        button_left.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view) {
                finish();
            }
        });
        ImageButton button_right =(ImageButton)findViewById(R.id.imagebutton_right);
        button_right.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view) {
                //전의 뷰에 선택된 곳을 적용해주고 새로고침해서 재출력
                Toast.makeText(getApplicationContext(),"장소 선택 완료",Toast.LENGTH_SHORT).show();
                finish();
            }
        });
        button_toggle=(ToggleButton) findViewById(R.id.button_toggle);
        button_toggle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(button_toggle.isChecked()) {
                    button_toggle.setBackgroundResource(R.drawable.toggle_left);
                }else{
                    button_toggle.setBackgroundResource(R.drawable.toggle_right);
                }
            }
        });
        button_spot=(Button)findViewById(R.id.button_spot);
        button_spot.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
    }
}
