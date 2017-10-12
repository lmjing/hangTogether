package com.example.woojinroom.hangto.History;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.woojinroom.hangto.R;

import java.util.ArrayList;

public class listViewHistoryAdapter extends BaseAdapter {

    public ImageView imageView;
    public TextView textId;
    public TextView textContent;
    public TextView textTime;
    public TextView textday;
    public TextView ranguage1;
    public TextView ranguage2;
    public TextView ranguage3;

    // Adapter에 추가된 데이터를 저장하기 위한 ArrayList
    private ArrayList<listViewHistory> listViewItemList = new ArrayList<listViewHistory>() ;

    // ListViewAdapter의 생성자
    public listViewHistoryAdapter() {

    }

    // Adapter에 사용되는 데이터의 개수를 리턴. : 필수 구현
    @Override
    public int getCount() {
        return listViewItemList.size() ;
    }

    // position에 위치한 데이터를 화면에 출력하는데 사용될 View를 리턴. : 필수 구현
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        final int pos = position;
        final Context context = parent.getContext();

        // "listview_item" Layout을 inflate하여 convertView 참조 획득.
        if (convertView == null) {
            LayoutInflater inflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            convertView = inflater.inflate(R.layout.listview_mainpage, parent, false);
        }

        // 화면에 표시될 View(Layout이 inflate된)으로부터 위젯에 대한 참조 획득
        imageView =(ImageView)convertView.findViewById(R.id.imageView);
        textId = (TextView)convertView.findViewById(R.id.textView);
        textContent = (TextView)convertView.findViewById(R.id.textView2);
        textTime = (TextView)convertView.findViewById(R.id.textView3);
        textday = (TextView)convertView.findViewById(R.id.textView4);
        ranguage1 =(TextView)convertView.findViewById(R.id.ranguage1);
        ranguage2 =(TextView)convertView.findViewById(R.id.ranguage2);
        ranguage3 =(TextView)convertView.findViewById(R.id.ranguage3);

        // Data Set(listViewItemList)에서 position에 위치한 데이터 참조 획득
        listViewHistory listViewItem = listViewItemList.get(position);

        // 아이템 내 각 위젯에 데이터 반영
        imageView.setImageDrawable(listViewItem.getProfile());
        textId.setText(listViewItem.getId());
        textContent.setText(listViewItem.getContent());
        textTime.setText(listViewItem.getTime());
        textday.setText(listViewItem.getDay());
        ranguage1.setText(listViewItem.getRanguage1());
        ranguage2.setText(listViewItem.getRanguage2());
        ranguage3.setText(listViewItem.getRanguage3());

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
        return listViewItemList.get(position) ;
    }

    // 아이템 데이터 추가를 위한 함수. 개발자가 원하는대로 작성 가능.
    public void addItem(Drawable profile, String id, String content, String time, String day, String rang1, String rang2, String rang3) {
        listViewHistory item = new listViewHistory();

        item.setProfile(profile);
        item.setId(id);
        item.setContent(content);
        item.setTime(time);
        item.setDay(day);
        item.setRanguage1(rang1);
        item.setRanguage2(rang2);
        item.setRanguage3(rang3);

        listViewItemList.add(item);
    }

    public void clear() {
        listViewItemList.clear();
    }
}
