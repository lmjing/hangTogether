package com.example.woojinroom.hangto.Write;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageButton;
import android.widget.TextView;

import com.example.woojinroom.hangto.R;

import java.util.ArrayList;

public class listViewSpotAdapter extends BaseAdapter {

    Post_places places;
    Post_trip posttrip;

    TextView textSpot;
    TextView textPlus;

    public TextView textDot;
    public ImageButton cancle;
    View top_line,bottom_line;


    // Adapter에 추가된 데이터를 저장하기 위한 ArrayList
    public ArrayList<Post_trip> posttriplist = new ArrayList<Post_trip>();

    // ListViewAdapter의 생성자
    public listViewSpotAdapter() {

    }

    // Adapter에 사용되는 데이터의 개수를 리턴. : 필수 구현
    @Override
    public int getCount() {
        return posttriplist.size() ;
    }

    // position에 위치한 데이터를 화면에 출력하는데 사용될 View를 리턴. : 필수 구현
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        final int pos = position;
        final Context context = parent.getContext();
        // "listview_item" Layout을 inflate하여 convertView 참조 획득.
        if (convertView == null) {
            LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            convertView = inflater.inflate(R.layout.listview_spot, parent, false);
        }

        // 화면에 표시될 View(Layout이 inflate된)으로부터 위젯에 대한 참조 획득
        //날짜
        textPlus = (TextView)convertView.findViewById(R.id.textView_plus);

        //장소
        textSpot = (TextView)convertView.findViewById(R.id.textView_spot);
        textSpot.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int count, checked ;
                count = getCount() ;

                if (count > 0) {
                    // 현재 선택된 아이템의 position 획득.
                    checked =pos;

                    if (checked > -1 && checked < count) {
                        // 아이템 삭제
                        posttriplist.remove(checked) ;

                        // listview 갱신.
                        notifyDataSetChanged();
                    }
                }
            }
        });
        //취소버튼
        cancle = (ImageButton)convertView.findViewById(R.id.imageButton_cancle);
        cancle.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int count, checked ;
                count = getCount() ;

                if (count > 0) {
                    // 현재 선택된 아이템의 position 획득.
                    checked =pos;

                    if (checked > -1 && checked < count) {
                        // 아이템 삭제
                        posttriplist.remove(checked) ;
                        // listview 갱신.
                        notifyDataSetChanged();
                    }
                }
            }
        });

        // Data Set(listViewItemList)에서 position에 위치한 데이터 참조 획득
        Post_trip listViewItem = posttriplist.get(position);

        // 아이템 내 각 위젯에 데이터 반영
        textPlus.setText(listViewItem.getDate());
        textSpot.setText(listViewItem.places.getName());

        Post_trip cmpItem;
        String cmpData="";
        if(getCount()>1 && position!=0) {
            cmpItem = posttriplist.get(position-1);
            cmpData=cmpItem.getDate();
        }
        //점과 선 선언
        textDot = (TextView)convertView.findViewById(R.id.textView_dot);
        top_line = convertView.findViewById(R.id.view_line);
        bottom_line = convertView.findViewById(R.id.view_line2);


        // 선 긋기
        //날짜가 다르면
        if(!listViewItem.getDate().equals(cmpData)){
            textDot.setVisibility(View.VISIBLE);
            if (getCount() == 1) {
                top_line.setVisibility(View.INVISIBLE);
                bottom_line.setVisibility(View.INVISIBLE);
            }
            // 여러개중에 첫번째
            else if (pos == 0) {
                top_line.setVisibility(View.INVISIBLE);
                bottom_line.setVisibility(View.VISIBLE);
            }
            //여러개중에 마지막
            else if (pos == getCount() - 1) {
                top_line.setVisibility(View.VISIBLE);
                bottom_line.setVisibility(View.INVISIBLE);
            }
            //여러개중에 중간
            else {
                top_line.setVisibility(View.VISIBLE);
                bottom_line.setVisibility(View.VISIBLE);
            }
        }
        //날짜가 같으면
        else {
            textPlus.setText("");
            if (getCount() == 1) {
                top_line.setVisibility(View.INVISIBLE);
                textDot.setVisibility(View.VISIBLE);
                bottom_line.setVisibility(View.INVISIBLE);
            }
            // 여러개중에 첫번째
            else if (pos == 0) {
                top_line.setVisibility(View.INVISIBLE);
                textDot.setVisibility(View.VISIBLE);
                bottom_line.setVisibility(View.VISIBLE);
            }
            //여러개중에 마지막
            else if (pos == getCount() - 1) {
                top_line.setVisibility(View.VISIBLE);
                textDot.setVisibility(View.VISIBLE);
                bottom_line.setVisibility(View.INVISIBLE);
            }
            //여러개중에 중간
            else {
                top_line.setVisibility(View.VISIBLE);
                textDot.setVisibility(View.INVISIBLE);
                bottom_line.setVisibility(View.VISIBLE);
            }
        }

        return convertView;
    }

    // 지정한 위치(position)에 있는 데이터와 관계된 아이템(row)의 ID를 리턴. : 필수 구현
    @Override
    public long getItemId(int position) {
        return position ;
    }

    // 지정한 위치(position)에 있는 데이터 리턴 : 필수 구현
    @Override
    public Object getItem(int position) {
        return posttriplist.get(position) ;
    }

    // 아이템 데이터 추가를 위한 함수. 개발자가 원하는대로 작성 가능.

    public void addItem2(String date,String name,String address,double lat,double lng)
    {

        places = new Post_places();

        places.setName(name);
        places.setAddress(address);
        places.setLat(lat);
        places.setLng(lng);

        posttrip = new Post_trip();
        posttrip.setDate(date);
        posttrip.setPlaces(places);

        posttriplist.add(posttrip);

    }

    public void clear() {
        posttriplist.clear();
    }
}
