package com.example.woojinroom.hangto;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class loginActivity extends AppCompatActivity {
    EditText editText_id;
    EditText editText_pass;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        editText_id = (EditText)findViewById(R.id.editText);
        editText_pass = (EditText)findViewById(R.id.editText2);

        String id = "id";

        Button button = (Button)findViewById(R.id.button);

        //id 와 pw 를 db에 있는거랑 비교해서 존재하면 통과
        button.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                if(editText_id.getText().toString().equals("id")) {
                    if(editText_pass.getText().toString().equals("pw")) {
                        Intent login_intent = new Intent(getApplicationContext(), mainPageActivity_.class);
                        startActivity(login_intent);
                        finish();
                    } else{
                        Toast.makeText(getApplicationContext(),"비밀번호를 확인해주세요",Toast.LENGTH_SHORT).show();
                    }
                } else{
                    Toast.makeText(getApplicationContext(),"아이디를 확인해주세요",Toast.LENGTH_SHORT).show();
                }
            }
        });
    }
}
