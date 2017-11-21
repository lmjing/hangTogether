package com.example.woojinroom.hangto.Write;

import android.content.Intent;
import android.graphics.Color;
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
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import com.example.woojinroom.hangto.R;
import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.location.places.Place;
import com.google.android.gms.location.places.ui.PlaceAutocomplete;
import com.example.woojinroom.hangto.Write.listViewSpotAdapter;

/**
 * Created by woojinroom on 2017-10-09.
 */

public class spotActivity extends AppCompatActivity {

    int PLACE_AUTOCOMPLETE_REQUEST_CODE = 1;
    Toolbar toolbar;
    TextView textView,textView2;
    Button button_spot;
    ToggleButton button_toggle;
    EditText editText;
    ViewPager pager;
    String[] day_list;
    Spinner day_select;
    Intent data;
    ArrayAdapter<String> adapter;
    Place place;
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_spot);

        pager = (ViewPager)findViewById(R.id.pager);
        pager.setAdapter(new pagerAdapter(getSupportFragmentManager()));
        pager.setCurrentItem(0);

        toolbar = (Toolbar)findViewById(R.id.toolbar);
        textView = (TextView) toolbar.findViewById(R.id.title);
        textView.setText("장소 추가");
        textView2 = (TextView)findViewById(R.id.textView_day);

        day_select = (Spinner)findViewById(R.id.day_select);
        data = getIntent();

        day_list= new String[data.getIntExtra("counted_day",1)+1];

        int month= data.getIntExtra("first_month",1);
        int day = data.getIntExtra("first_day",1);
Toast.makeText(getApplicationContext(),String.valueOf(data.getIntExtra("counted_day",1)),Toast.LENGTH_SHORT).show();
        for(int i=0;i<= data.getIntExtra("counted_day",1);i++){

            if(month==1 || month==3 || month==5 || month==7 || month==8 ||month==10 ||month==12){
                if(day==32){
                    month++;
                    day-=31;
                }
            }
            else if(month==2) //윤달 계산 안했음
            {
                if(day==29){
                    month++;
                    day-=28;
                }
            }
            else{
                if(day==31){
                    month++;
                    day-=30;
                }
            }
            day_list[i]=(month+"."+(day++));
        }
       /* if(day_list[0].equals("0.0")){
            day_list[0]="무관";
        }*/

         adapter = new ArrayAdapter<String>(
                this,
                R.layout.custom_simple_dropdown_item_1line,
                day_list);
        day_select.setAdapter(adapter);
        day_select.setSelection(0);

        editText =(EditText)findViewById(R.id.editText_spot);
        editText.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                spot();
            }
        });
        ImageButton button_left =(ImageButton)findViewById(R.id.imagebutton_left);
        button_left.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view) {
                finish();
            }
        });
        ImageButton button_right =(ImageButton)findViewById(R.id.imagebutton_right);
        button_right.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view) {
                Intent data = new Intent();
                data.putExtra("date",day_select.getSelectedItem().toString());
                data.putExtra("name",editText.getText().toString());
                data.putExtra("address",place.getAddress().toString());
                data.getDoubleExtra("lat",place.getLatLng().latitude);
                data.getDoubleExtra("lng",place.getLatLng().longitude);
                setResult(RESULT_OK,data);
                finish();
            }
        });
        button_toggle=(ToggleButton) findViewById(R.id.button_toggle);
        button_toggle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(button_toggle.isChecked()) {
                    button_toggle.setBackgroundResource(R.drawable.toggle_left);
                    day_list[0]="무관";
                    day_select.setAdapter(adapter);
                    day_select.setEnabled(false);
                    textView2.setTextColor(Color.rgb(170,170,170));

                }else{
                    button_toggle.setBackgroundResource(R.drawable.toggle_right);
                    for(int i=0;i<= data.getIntExtra("counted_day",1);i++){
                        day_list[i]=data.getIntExtra("first_month",1)+"."+(data.getIntExtra("first_day",1)+i);
                    }
                    if(day_list[0].equals("0.0")){
                        day_list[0]="무관";
                    }
                    day_select.setAdapter(adapter);
                    day_select.setEnabled(true);
                    textView2.setTextColor(Color.rgb(0,0,0));

                }
            }
        });
        button_spot=(Button)findViewById(R.id.button_spot);

        button_spot.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                spot();
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
    public void spot(){
        try {
            Intent intent =
                    new PlaceAutocomplete.IntentBuilder(PlaceAutocomplete.MODE_FULLSCREEN)
                            .build(this);
            startActivityForResult(intent, PLACE_AUTOCOMPLETE_REQUEST_CODE);
        } catch (GooglePlayServicesRepairableException e) {
            // TODO: Handle the error.
        } catch (GooglePlayServicesNotAvailableException e) {
            // TODO: Handle the error.
        }
    }
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == PLACE_AUTOCOMPLETE_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {
                 place = PlaceAutocomplete.getPlace(this, data);
                googleMapFragment.reMark(place.getLatLng(),place.getName().toString(),place.getAddress().toString());

                editText.setText(place.getName().toString());

            } else if (resultCode == PlaceAutocomplete.RESULT_ERROR) {
                Status status = PlaceAutocomplete.getStatus(this, data);
                // TODO: Handle the error.


            } else if (resultCode == RESULT_CANCELED) {
            }
        }
    }


}
