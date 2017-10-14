package com.example.woojinroom.hangto;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.TextView;

import com.example.woojinroom.hangto.TabActivity.TabActivity_;


/**
 * Created by woojinroom on 2017-10-09.
 */

public class nationActivity extends AppCompatActivity {
    Spinner spinner;
    TextView rang1, rang2, rang3;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_nation);

        ImageButton button_right = (ImageButton) findViewById(R.id.imagebutton_right);
        button_right.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                //if 문으로 회원가입 완료되는지 확인 후 메인페이지로 넘어감
                Intent join_intent = new Intent(getApplicationContext(), joinActivity.class);
                startActivity(join_intent);
                finish();
            }
        });

        spinner = (Spinner) findViewById(R.id.nation_select);
        rang1 = (TextView) findViewById(R.id.rang1);
        rang2 = (TextView) findViewById(R.id.rang2);
        rang3 = (TextView) findViewById(R.id.rang3);
        spinner.setOnItemSelectedListener(mOnItemSelectedListener);


    }

    private AdapterView.OnItemSelectedListener mOnItemSelectedListener = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
            if(rang1.getText().equals("선택"))
            rang1.setText(spinner.getSelectedItem().toString());
            else if(rang2.getText().equals("선택"))
            rang2.setText(spinner.getSelectedItem().toString());
            else if(rang3.getText().equals("선택"))
                rang3.setText(spinner.getSelectedItem().toString());
        }

        @Override
        public void onNothingSelected(AdapterView<?> parent) {

        }
    };
}