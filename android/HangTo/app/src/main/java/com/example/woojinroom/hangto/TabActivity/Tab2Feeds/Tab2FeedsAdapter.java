package com.example.woojinroom.hangto.TabActivity.Tab2Feeds;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.example.woojinroom.hangto.Model.Food;
import com.example.woojinroom.hangto.R;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderFood;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderMessage;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderParent;

import java.util.ArrayList;

/**
 * Created by kksd0900 on 16. 10. 11..
 */
public class Tab2FeedsAdapter extends RecyclerView.Adapter<ViewHolderParent> {
    private static final int TYPE_ITEM = 0;

    public Context context;
    public Tab2FeedsFragment fragment;
    private OnItemClickListener mOnItemClickListener;
    public ArrayList<Food> mDataset = new ArrayList<>();

    public interface OnItemClickListener {
        void onItemClick(View view, int position);
    }

    public Tab2FeedsAdapter(OnItemClickListener onItemClickListener, Context mContext, Tab2FeedsFragment mFragment) {
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
    public ViewHolderParent onCreateViewHolder(ViewGroup parent, int viewType) {
        if (viewType == TYPE_ITEM) {
            View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.listview_message, parent, false);
            return new ViewHolderMessage(v);
        }
        return null;
    }

    @Override
    public void onBindViewHolder(ViewHolderParent holder, final int position) {
        if (holder instanceof ViewHolderMessage) {
            holder.container.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mOnItemClickListener.onItemClick(v, position);
                }
            });
            ViewHolderMessage itemViewHolder = (ViewHolderMessage) holder;
            Food food = mDataset.get(position);

            itemViewHolder.imageView.setImageResource(R.drawable.test);
            itemViewHolder.textId.setText(food.id);

            itemViewHolder.textId.setOnClickListener(new View.OnClickListener(){
                public void onClick(View view){
                    Toast.makeText(view.getContext(),"ID 눌림",Toast.LENGTH_SHORT).show();
                }
            });
            itemViewHolder.textContent.setText(food.content);
            itemViewHolder.textContent.setOnClickListener(new View.OnClickListener(){
                public void onClick(View view){
                    Toast.makeText(view.getContext(),"Content 눌림",Toast.LENGTH_SHORT).show();
                }
            });
            itemViewHolder.textTime.setText(food.time);
            itemViewHolder.imageView2.setImageResource(R.drawable.test);
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
