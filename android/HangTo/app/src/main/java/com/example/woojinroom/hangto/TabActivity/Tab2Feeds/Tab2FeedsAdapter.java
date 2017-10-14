package com.example.woojinroom.hangto.TabActivity.Tab2Feeds;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Toast;

import com.example.woojinroom.hangto.Model.Food;
import com.example.woojinroom.hangto.R;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderMessage;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderParent;
import com.example.woojinroom.hangto.requestDocumentActivity;

import java.util.ArrayList;

/**
 * Created by kksd0900 on 16. 10. 11..
 */
public class Tab2FeedsAdapter extends RecyclerView.Adapter<ViewHolderParent> {
    private static final int TYPE_Message = 0;

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
        if (viewType == TYPE_Message) {
            View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.listview_message, parent, false);
            return new ViewHolderMessage(v);
        }
        return null;
    }

    @Override
    public void onBindViewHolder(ViewHolderParent holder, final int position) { // 1.신청자의 알림함 2.작성자의 알림함 3.통합 메세지함
        if (holder instanceof ViewHolderMessage) {
            holder.container.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    mOnItemClickListener.onItemClick(v, position);
                }
            });

            ViewHolderMessage itemViewHolder = (ViewHolderMessage) holder;
            Food food = mDataset.get(position);
            if(Tab2FeedsFragment.status==0) { //메세지함이면 status ==0
                itemViewHolder.textDocument.setVisibility(View.GONE);
                itemViewHolder.textMessageID.setVisibility(View.GONE);
                itemViewHolder.textMessageTime.setVisibility(View.GONE);
                itemViewHolder.textId.setVisibility(View.VISIBLE);
                itemViewHolder.textContent.setVisibility(View.VISIBLE);
                itemViewHolder.textTime.setVisibility(View.VISIBLE);
                itemViewHolder.textNew.setVisibility(View.VISIBLE);

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

                itemViewHolder.textNew.setBackgroundResource(R.drawable.rectangle_new);
                itemViewHolder.textNew.setOnClickListener(new View.OnClickListener(){
                    public void onClick(View view){
                        Toast.makeText(view.getContext(),"메세지함에서 눌림",Toast.LENGTH_SHORT).show();
                    }
                });
            } else if(Tab2FeedsFragment.status==1) { //작성자의 알림함이면 status==1
                itemViewHolder.textDocument.setVisibility(View.VISIBLE);
                itemViewHolder.textMessageID.setVisibility(View.VISIBLE);
                itemViewHolder.textMessageTime.setVisibility(View.VISIBLE);
                itemViewHolder.textId.setVisibility(View.INVISIBLE);
                itemViewHolder.textContent.setVisibility(View.INVISIBLE);
                itemViewHolder.textTime.setVisibility(View.INVISIBLE);
                itemViewHolder.textNew.setVisibility(View.INVISIBLE);

                itemViewHolder.imageView.setImageResource(R.drawable.test);
                itemViewHolder.textMessageID.setText(food.id);
                itemViewHolder.textMessageTime.setText(food.messageTime);

                itemViewHolder.textDocument.setOnClickListener(new View.OnClickListener(){
                    public void onClick(View view){
                        Intent document_intent = new Intent(view.getContext(), requestDocumentActivity.class);
                        fragment.startIntent(document_intent);
                    }
                });
            } else // 신청자의 알림 status==2
            {
                itemViewHolder.textDocument.setVisibility(View.INVISIBLE);
                itemViewHolder.textMessageID.setVisibility(View.VISIBLE);
                itemViewHolder.textMessageTime.setVisibility(View.INVISIBLE);
                itemViewHolder.textId.setVisibility(View.INVISIBLE);
                itemViewHolder.textContent.setVisibility(View.INVISIBLE);
                itemViewHolder.textTime.setVisibility(View.VISIBLE);
                itemViewHolder.textNew.setVisibility(View.INVISIBLE);

                itemViewHolder.imageView.setImageResource(R.drawable.test);
                itemViewHolder.textMessageID.setText(food.id);
                itemViewHolder.textTime.setText(food.time);

            }
        }
    }

    @Override
    public int getItemViewType(int position) {

        return TYPE_Message;
    }

    @Override
    public int getItemCount() {
        return mDataset.size();
    }


}
