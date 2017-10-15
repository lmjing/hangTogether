package com.example.woojinroom.hangto;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.Spinner;
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
    ViewPager pager;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_spot);

        pager = (ViewPager)findViewById(R.id.pager);
        pager.setAdapter(new pagerAdapter(getSupportFragmentManager()));
        pager.setCurrentItem(0);

        toolbar = (Toolbar)findViewById(R.id.toolbar);
        textView = (TextView) toolbar.findViewById(R.id.title);
        textView.setText("장소 추가");

        String[] day_list = {"10.10 ", "10.11", "10.12", "10.13", "10.14"};

        Spinner day_select = (Spinner)findViewById(R.id.day_select);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(
                this,
                R.layout.custom_simple_dropdown_item_1line,
                day_list);
        day_select.setAdapter(adapter);
        day_select.setSelection(0);

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
    private class pagerAdapter extends FragmentStatePagerAdapter
    {
        public pagerAdapter(FragmentManager fm )
        {
            super(fm);
        }

        @Override
        public Fragment getItem(int position) {
            return new googleMapFragment();

        }

        @Override
        public int getCount() {
            // total page count
            return 1;
        }
    }

}
