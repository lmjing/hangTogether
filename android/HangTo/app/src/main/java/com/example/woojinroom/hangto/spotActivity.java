package com.example.woojinroom.hangto;

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

import com.google.android.gms.common.GooglePlayServicesNotAvailableException;
import com.google.android.gms.common.GooglePlayServicesRepairableException;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.location.places.Place;
import com.google.android.gms.location.places.ui.PlaceAutocomplete;

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

        final String[] day_list = {"10.10", "10.11", "10.12", "10.13", "10.14"};

        final Spinner day_select = (Spinner)findViewById(R.id.day_select);
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(
                this,
                R.layout.custom_simple_dropdown_item_1line,
                day_list);
        day_select.setAdapter(adapter);
        day_select.setSelection(0);

        editText =(EditText)findViewById(R.id.editText_spot);

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
                data.putExtra("day",day_list[0]);
                data.putExtra("spot",editText.getText().toString());
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
                    day_select.setEnabled(false);
                    textView2.setTextColor(Color.rgb(170,170,170));
                }else{
                    button_toggle.setBackgroundResource(R.drawable.toggle_right);
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
                Place place = PlaceAutocomplete.getPlace(this, data);
                googleMapFragment.reMark( place.getLatLng(),place.getName().toString());
                editText.setText(place.getName().toString());


            } else if (resultCode == PlaceAutocomplete.RESULT_ERROR) {
                Status status = PlaceAutocomplete.getStatus(this, data);
                // TODO: Handle the error.

                Toast.makeText(getApplicationContext(),status.getStatusMessage(),Toast.LENGTH_SHORT).show();

            } else if (resultCode == RESULT_CANCELED) {
                Toast.makeText(getApplicationContext(),"개망",Toast.LENGTH_SHORT).show();
                // The user canceled operation.
            }
        }
    }


}
