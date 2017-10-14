package com.example.woojinroom.hangto;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

import static android.view.View.GONE;

/**
 * Created by woojinroom on 2017-09-25.
 */

public class profileActivity extends AppCompatActivity {
    ImageButton imageButton;
    TextView textView;
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);

        imageButton = (ImageButton)findViewById(R.id.button11);
        imageButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent message_intent = new Intent(getApplicationContext(), messageActivity.class);
                startActivity(message_intent);
                finish();
            }
        });
        ImageButton button_left =(ImageButton)findViewById(R.id.imagebutton_left);
        button_left.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view) {
                finish();
            }
        });
        ImageButton button_right =(ImageButton)findViewById(R.id.imagebutton_right);
        button_right.setVisibility(GONE);
        textView = (TextView)findViewById(R.id.title);
        textView.setText("subin614");
    }
}
