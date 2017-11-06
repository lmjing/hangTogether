package com.example.woojinroom.hangto;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.Spinner;
import android.widget.TextView;

import com.example.woojinroom.hangto.TabActivity.TabActivity_;

import org.w3c.dom.Text;


/**
 * Created by woojinroom on 2017-10-09.
 */

public class nationActivity extends AppCompatActivity {
    Spinner spinner,spinner2,spinner3;
    String rang1,rang2,rang3;
    boolean user;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_nation);
        ImageButton button_left = (ImageButton) findViewById(R.id.imagebutton_left);
        button_left.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view) {
                finish();
            }
        });
        ImageButton button_right = (ImageButton) findViewById(R.id.imagebutton_right);
        button_right.setOnClickListener(new View.OnClickListener() {
            public void onClick(View view) {
                if(user){
                    rang1=spinner.getSelectedItem().toString();
                    rang2=spinner2.getSelectedItem().toString();
                    rang3=spinner3.getSelectedItem().toString();
                }
                //if 문으로 회원가입 완료되는지 확인 후 메인페이지로 넘어감
                Intent join_intent = new Intent(getApplicationContext(), joinActivity.class);
                startActivity(join_intent);
            }
        });
        final TextView textView = (TextView)findViewById(R.id.textView18);
        spinner = (Spinner) findViewById(R.id.nation_select);

        spinner.setOnItemSelectedListener(mOnItemSelectedListener);
        ImageView imageView_foreigner =(ImageView)findViewById(R.id.imageView5);
        imageView_foreigner.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                user = true;
                textView.setTextColor(Color.rgb(0,0,0));
                spinner.setEnabled(true);
                spinner2.setEnabled(true);
                spinner3.setEnabled(true);

            }
        });
        ImageView imageView_korean =(ImageView)findViewById(R.id.imageView6);
        imageView_korean.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                user =false;
                textView.setTextColor(Color.rgb(170,170,170));
                spinner.setEnabled(false);
                spinner2.setEnabled(false);
                spinner3.setEnabled(false);

            }
        });

    }

    private AdapterView.OnItemSelectedListener mOnItemSelectedListener = new AdapterView.OnItemSelectedListener() {
        @Override
        public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

        }

        @Override
        public void onNothingSelected(AdapterView<?> parent) {

        }
    };

}