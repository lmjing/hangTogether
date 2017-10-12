package com.example.woojinroom.hangto;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageButton;

/**
 * Created by woojinroom on 2017-09-25.
 */

public class profileActivity extends AppCompatActivity {
    ImageButton imageButton;
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
    }
}
