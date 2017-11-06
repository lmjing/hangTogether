package com.example.woojinroom.hangto.Write;

import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.Intent;
import android.icu.text.Collator;
import android.icu.text.SimpleDateFormat;
import android.os.Build;
import android.os.Bundle;
import android.support.annotation.RequiresApi;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.ImageButton;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.example.woojinroom.hangto.R;

import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;

/**
 * Created by woojinroom on 2017-09-25.
 */

public class writeActivity extends AppCompatActivity {

    int SPOT_REQUEST_CODE = 1;
    Button button_start, button_end;
    Toolbar toolbar;
    TextView textView, textspot;
    ImageButton imageButtonLeft;
    ImageButton imageButtonRight;
    int first_year, first_month, first_day, counted_day;
    ListView listview;
    listViewSpotAdapter adapter;
    String day, spot;


    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_write);
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        textView = (TextView) toolbar.findViewById(R.id.title);


        imageButtonLeft = (ImageButton) toolbar.findViewById(R.id.imagebutton_left);
        imageButtonLeft.setImageResource(R.drawable.left_arrow);
        imageButtonLeft.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        imageButtonRight = (ImageButton) toolbar.findViewById(R.id.imagebutton_right);
        imageButtonRight.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) { //글 작성 완료되면 글을 디비에 넣고 메인페이지 리로드
                Toast.makeText(getApplicationContext(), "글 작성 완료", Toast.LENGTH_SHORT).show();
            }
        });

        TextView title = (TextView) findViewById(R.id.title);
        title.setText("글 작성");
        button_start = (Button) findViewById(R.id.time_start);
        button_start.setOnClickListener(new View.OnClickListener() {
            @RequiresApi(api = Build.VERSION_CODES.N)
            public void onClick(View view) {
                showDialog(1);

            }
        });
        button_end = (Button) findViewById(R.id.time_end);
        button_end.setOnClickListener(new View.OnClickListener() {
            @RequiresApi(api = Build.VERSION_CODES.N)
            public void onClick(View view) {
                showDialog(2);

            }
        });


        adapter = new listViewSpotAdapter();

        // 리스트뷰 참조 및 Adapter달기
        listview = (ListView) findViewById(R.id.listview_spot);
        listview.setDivider(null);
        listview.setDividerHeight(0);
        listview.setAdapter(adapter);

        textspot = (TextView) findViewById(R.id.spot1);

        textspot.setOnClickListener(new View.OnClickListener() {
            @RequiresApi(api = Build.VERSION_CODES.N)
            public void onClick(View view) {
                counttday();
                Intent spot_intent = new Intent(getApplicationContext(), spotActivity.class);
                spot_intent.putExtra("first_month", first_month);
                spot_intent.putExtra("first_day", first_day);
                spot_intent.putExtra("counted_day", counted_day);
                startActivityForResult(spot_intent, SPOT_REQUEST_CODE);
            }
        });

    }

    protected Dialog onCreateDialog(int id) {
        switch (id) {
            case 1:
                DatePickerDialog dpd_start = new DatePickerDialog
                        (this, // 현재화면의 제어권자
                                new DatePickerDialog.OnDateSetListener() {
                                    @RequiresApi(api = Build.VERSION_CODES.N)
                                    public void onDateSet(DatePicker view,
                                                          int year, int monthOfYear, int dayOfMonth) {
                                        button_start.setText(year + "-" + (monthOfYear + 1) + "-" + dayOfMonth);
                                        first_year = year;
                                        first_month = monthOfYear + 1;
                                        first_day = dayOfMonth;
                                    }
                                }
                                , // 사용자가 날짜설정 후 다이얼로그 빠져나올때
                                //    호출할 리스너 등록
                                2017, 9, 12); // 기본값 연월일

                return dpd_start;
            case 2:
                DatePickerDialog dpd_end = new DatePickerDialog
                        (this, // 현재화면의 제어권자
                                new DatePickerDialog.OnDateSetListener() {
                                    @RequiresApi(api = Build.VERSION_CODES.N)
                                    public void onDateSet(DatePicker view,
                                                          int year, int monthOfYear, int dayOfMonth) {
                                        button_end.setText(year + "-" + (monthOfYear + 1) + "-" + dayOfMonth);

                                    }
                                }
                                , // 사용자가 날짜설정 후 다이얼로그 빠져나올때
                                //    호출할 리스너 등록
                                2017, 9, 12); // 기본값 연월일
                return dpd_end;
        }

        return super.onCreateDialog(id);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == SPOT_REQUEST_CODE) {
            if (resultCode == RESULT_OK) {

                day = data.getExtras().getString("day");
                spot = data.getExtras().getString("spot");

                adapter.addItem(spot, day);
                if (adapter.getCount() >= 2) {
                    Collections.sort(adapter.listViewItemList,cmpAsc);
                }
                adapter.notifyDataSetChanged();
                setListViewHeightBasedOnChildren(listview);

            }
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public void countday() {
        try {
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-mm-dd");

            Date FirstDate = simpleDateFormat.parse(button_start.getText().toString());
            Date SecondDate = simpleDateFormat.parse(button_end.getText().toString());

            long calDate = SecondDate.getTime() - FirstDate.getTime();
            long calDateDays = calDate/ (24 * 60 * 60 * 1000);

            calDateDays = Math.abs(calDateDays);
            counted_day = (int) calDateDays;
        } catch (Exception e) {
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.N)
    public void counttday() {
        try {
            String FirstDate = button_start.getText().toString();
            String SecondDate = button_end.getText().toString();

            //2017-9-5 같은 경우
            if(FirstDate.length()==8){
                FirstDate=FirstDate.substring(0,5)+"0"+FirstDate.substring(5,7)+"0"+FirstDate.substring(7,8); //일과 월에 모두 0 삽입
            }
            if(SecondDate.length()==8){
                SecondDate=SecondDate.substring(0,5)+"0"+SecondDate.substring(5,7)+"0"+SecondDate.substring(7,8);
            }

            if(FirstDate.length()==9){
                if(FirstDate.substring(6,7).equals("-"))//2017-9-13 같은 경우
                {
                    FirstDate=FirstDate.substring(0,5)+"0"+FirstDate.substring(5,9);
                }else {
                    //2017-10-9 같은 경우
                    FirstDate = FirstDate.substring(0, 8) + "0" + FirstDate.substring(8, 9); //일 부분에 0삽입
                }
            }
            if(SecondDate.length()==9){
                if(SecondDate.substring(6,7).equals("-"))//2017-9-13 같은 경우
                {
                    SecondDate=SecondDate.substring(0,5)+"0"+SecondDate.substring(5,9);
                }else {
                    //2017-10-9 같은 경우
                    SecondDate = SecondDate.substring(0, 8) + "0" + SecondDate.substring(8, 9);
                }
            }

            Calendar FirstDayCal = Calendar.getInstance(); //오늘날자 가져오기
            FirstDayCal.set(Integer.parseInt(FirstDate.substring(0,4)),Integer.parseInt(FirstDate.substring(5,7)),Integer.parseInt(FirstDate.substring(8,10)));

            Calendar SecondDayCal = Calendar.getInstance();
            SecondDayCal.set(Integer.parseInt(SecondDate.substring(0,4)),Integer.parseInt(SecondDate.substring(5,7)),Integer.parseInt(SecondDate.substring(8,10)));


            long firstDay = FirstDayCal.getTimeInMillis()/86400000; //->(24 * 60 * 60 * 1000) 24시간 60분 60초 * (ms초->초 변환 1000)
            long secondDay = SecondDayCal.getTimeInMillis()/86400000;
            long count = secondDay - firstDay;
            count = Math.abs(count);
            if(!FirstDate.substring(5,7).equals(SecondDate.substring(5,7))) {
                if (FirstDate.substring(5, 7).equals("01") || FirstDate.substring(5, 7).equals("03") || FirstDate.substring(5, 7).equals("05") || FirstDate.substring(5, 7).equals("07") || FirstDate.substring(5, 7).equals("08")
                        || FirstDate.substring(5, 7).equals("10") || FirstDate.substring(5, 7).equals("12")) { //31일
                    count += 1;
                } else if (FirstDate.substring(5, 7).equals("02")) { //28일
                    count -= 3;
                } else { //30일
                    count -= 1;
                }

                if(Integer.parseInt(FirstDate.substring(5,7))%2==1){ //홀수 월이면
                    if(FirstDate.substring(5,7).equals("01") && SecondDate.substring(5,7).equals("02")){
                        count-=2;
                    }else if(Integer.parseInt(SecondDate.substring(5,7))%2==1){
                        count-=1;
                    }
                } else{
                    if(Integer.parseInt(SecondDate.substring(5,7))%2==0) {
                        count += 1;
                    }
                }
            }
            counted_day = (int) count;
        } catch (Exception e) {
        }
    }


    public static void setListViewHeightBasedOnChildren(ListView listView) {
        ListAdapter listAdapter = listView.getAdapter();
        if (listAdapter == null) {
            // pre-condition
            return;
        }

        int totalHeight = 0;
        int desiredWidth = View.MeasureSpec.makeMeasureSpec(listView.getWidth(), View.MeasureSpec.AT_MOST);

        for (int i = 0; i < listAdapter.getCount(); i++) {
            View listItem = listAdapter.getView(i, null, listView);
            listItem.measure(desiredWidth, View.MeasureSpec.UNSPECIFIED);
            totalHeight += listItem.getMeasuredHeight();
        }

        ViewGroup.LayoutParams params = listView.getLayoutParams();
        params.height = totalHeight + (listView.getDividerHeight() * (listAdapter.getCount() - 1));
        listView.setLayoutParams(params);
        listView.requestLayout();
    }

    private final static Comparator<listViewSpot> cmpAsc = new Comparator<listViewSpot>() {
        @RequiresApi(api = Build.VERSION_CODES.N)
        @Override
        public int compare(listViewSpot o1, listViewSpot o2) {
            return Collator.getInstance().compare(o1.plus,o2.plus);
        }
    };

}



