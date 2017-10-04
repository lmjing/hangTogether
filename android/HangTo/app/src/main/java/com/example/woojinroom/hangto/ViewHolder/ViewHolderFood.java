package com.example.woojinroom.hangto.ViewHolder;

import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.example.woojinroom.hangto.R;

/**
 * Created by kksd0900 on 16. 10. 11..
 */
public class ViewHolderFood extends ViewHolderParent {
    public ImageView imageView;
    public TextView textId;
    public TextView textContent;
    public TextView textTime;

    public ViewHolderFood(View v) {
        super(v);
        imageView =(ImageView)v.findViewById(R.id.imageView);
        textId = (TextView)v.findViewById(R.id.textView);
        textContent = (TextView)v.findViewById(R.id.textView2);
        textTime = (TextView)v.findViewById(R.id.textView3);

    }
}