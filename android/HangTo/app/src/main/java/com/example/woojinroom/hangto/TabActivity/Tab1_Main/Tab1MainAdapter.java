package com.example.woojinroom.hangto.TabActivity.Tab1_Main;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.example.woojinroom.hangto.Model.Food;
import com.example.woojinroom.hangto.R;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderFood;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderParent;
import com.example.woojinroom.hangto.writingActivity;
import com.example.woojinroom.hangto.profileActivity;

import java.util.ArrayList;

/**
 * Created by kksd0900 on 16. 10. 11..
 */
public class Tab1MainAdapter extends RecyclerView.Adapter<ViewHolderParent> {

    private static final int TYPE_ITEM = 0;

    public Context context;
    public Tab1MainFragment fragment;
    private OnItemClickListener mOnItemClickListener;
    public ArrayList<Food> mDataset = new ArrayList<>();

    public interface OnItemClickListener {
        void onItemClick(View view, int position);
    }

    public Tab1MainAdapter(OnItemClickListener onItemClickListener, Context mContext, Tab1MainFragment mFragment) {
        mOnItemClickListener = onItemClickListener;
        context = mContext;
        fragment = mFragment;
        mDataset.clear();
    }

    public void addData(Food item) {
        mDataset.add(item);
    }

    public Food getItem(int position) {
        return mDataset.get(position);
    }

    public void clear() {
        mDataset.clear();
    }

    @Override
    public ViewHolderParent onCreateViewHolder(final ViewGroup parent, int viewType) {
        if (viewType == TYPE_ITEM) {
            View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.listview_mainpage, parent, false);
            return new ViewHolderFood(v);
        }
        return null;
    }

    @Override
    public void onBindViewHolder(ViewHolderParent holder, final int position) {
        if (holder instanceof ViewHolderFood) {
            holder.container.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mOnItemClickListener.onItemClick(v, position);
                }
            });
            ViewHolderFood itemViewHolder = (ViewHolderFood) holder;
            Food food = mDataset.get(position);

           // itemViewHolder.list_mainpage.setVisibility(View.GONE);
            itemViewHolder.imageView.setImageResource(R.drawable.test);
            itemViewHolder.imageView.setOnClickListener(new View.OnClickListener(){
                public void onClick(View view){
                    Intent profile_intent = new Intent(view.getContext(), profileActivity.class);
                    fragment.profile(profile_intent);
                }
            });
            itemViewHolder.textId.setText(food.id);

            itemViewHolder.textId.setOnClickListener(new View.OnClickListener(){
                public void onClick(View view){
                    Toast.makeText(view.getContext(),"ID 눌림",Toast.LENGTH_SHORT).show();
                }
            });
            itemViewHolder.textContent.setText(food.content);
            itemViewHolder.textContent.setOnClickListener(new View.OnClickListener(){
                public void onClick(View view){
                    Intent posting_intent = new Intent(view.getContext(), writingActivity.class);
                    fragment.profile(posting_intent);
                }
            });
            itemViewHolder.textTime.setText(food.time);
            itemViewHolder.textday.setText(food.day);
            itemViewHolder.ranguage1.setText(food.ranguage1);
            itemViewHolder.ranguage2.setText(food.ranguage2);
            itemViewHolder.ranguage3.setText(food.ranguage3);




            // LOAD MORE
//            if (position == mDataset.size()-1 && !fragment.endOfPage)
//                fragment.connectRecommand();

        }
    }

    @Override
    public int getItemViewType(int position) {

        return TYPE_ITEM;
    }

    @Override
    public int getItemCount() {
        return mDataset.size();
    }
}

