package com.example.woojinroom.hangto.TabActivity.Tab1Recommand;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.woojinroom.hangto.Model.Food;
import com.example.woojinroom.hangto.R;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderFood;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderFoodCategory;
import com.example.woojinroom.hangto.ViewHolder.ViewHolderParent;

import java.util.ArrayList;

/**
 * Created by kksd0900 on 16. 10. 11..
 */
public class Tab1RecommandAdapter extends RecyclerView.Adapter<ViewHolderParent> {

    ImageView imageView;
    TextView textId;
    TextView textContent;
    TextView textTime;
    int database = 1;

    private static final int TYPE_ITEM = 0;
    private static final int TYPE_HEADER = 1;

    public Context context;
    public Tab1RecommandFragment fragment;
    private OnItemClickListener mOnItemClickListener;
    public ArrayList<Food> mDataset = new ArrayList<>();

    public interface OnItemClickListener {
        void onItemClick(View view, int position);
    }

    public Tab1RecommandAdapter(OnItemClickListener onItemClickListener, Context mContext, Tab1RecommandFragment mFragment) {
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
            for(int i=0;i<database;i++){
                //포문은 여러개를 메인페이지에 나열해야해서 돌림
                //이부분을 배열화해서 디비 대조하고 글이 있는거만 메인페이지에 뿌려주면 될듯
            imageView =(ImageView)parent.findViewById(R.id.imageView);
            textId = (TextView)parent.findViewById(R.id.textView);
            textContent = (TextView)parent.findViewById(R.id.textView2);
            textTime = (TextView)parent.findViewById(R.id.textView3);

            imageView.setImageResource(R.drawable.test);
            textId.setText("testID");
            textContent.setText("testContent");
            textTime.setText("testTime");
            }

            View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.listview_mainpage, parent, false);

            return new ViewHolderFood(v);
        } else if (viewType == TYPE_HEADER) {
            View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.listview_mainpage, parent, false);
            return new ViewHolderFoodCategory(v);
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
            Food food = mDataset.get(position-1);

//            itemViewHolder.cellFoodHeader.setVisibility(View.GONE);
 //           itemViewHolder.foodName.setText(food.name);

            // LOAD MORE
//            if (position == mDataset.size()-1 && !fragment.endOfPage)
//                fragment.connectRecommand();

        } else if (holder instanceof ViewHolderFoodCategory) {

        }
    }

    @Override
    public int getItemViewType(int position) {
        if (position == 0)
            return TYPE_HEADER;
        return TYPE_ITEM;
    }

    @Override
    public int getItemCount() {
        return mDataset.size()+1;
    }
}
