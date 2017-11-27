package com.example.woojinroom.hangto.TabActivity.Tab3_Message;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;

import com.example.woojinroom.hangto.Model.Food;
import com.example.woojinroom.hangto.R;
import com.example.woojinroom.hangto.TabActivity.ParentFragment.TabParentFragment;
import com.example.woojinroom.hangto.TabActivity.TabActivity;

/**
 * Created by kksd0900 on 16. 10. 11..
 */
public class Tab3MessageFragment extends TabParentFragment {
    TabActivity activity;
    Button button_messagebox;
    Button button_alarmbox;

    public Tab3MessageAdapter adapter;
    private RecyclerView recyclerView;
    private RecyclerView.LayoutManager layoutManager;
    public LinearLayout indicator;
    public int page = 1;
    public static int status =0;
    public boolean endOfPage = false;
    SwipeRefreshLayout pullToRefresh;

    /**
     * Create a new instance of the fragment
     */
    public static Tab3MessageFragment newInstance(int index) {
        Tab3MessageFragment fragment = new Tab3MessageFragment();
        Bundle b = new Bundle();
        b.putInt("index", index);
        fragment.setArguments(b);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment3_message, container, false);
        initViewSetting(view);
        return view;
    }

    private void initViewSetting(View view) {
        final TabActivity tabActivity = (TabActivity) getActivity();
        this.activity = tabActivity;

        if (recyclerView == null) {
            recyclerView = (RecyclerView) view.findViewById(R.id.recycler_view);
            recyclerView.setHasFixedSize(true);
            layoutManager = new LinearLayoutManager(activity);
            recyclerView.setLayoutManager(layoutManager);
        }

        if (adapter == null) {
            adapter = new Tab3MessageAdapter(new Tab3MessageAdapter.OnItemClickListener() {
                @Override
                public void onItemClick(View view, int position) {

                }
            }, activity, this);
        }
        recyclerView.setAdapter(adapter);

        //indicator = (LinearLayout)view.findViewById(R.id.indicator);
        pullToRefresh = (SwipeRefreshLayout) view.findViewById(R.id.pull_to_refresh);
      pullToRefresh.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                pullToRefresh.setRefreshing(false);
                refresh();
            }
        });

     button_messagebox = (Button)view.findViewById(R.id.button_message);    //메세지함 0
        button_messagebox.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                status =0;
                refresh();
            }
        });
        button_alarmbox = (Button)view.findViewById(R.id.button_alarm); // 메세지가 갖는 status에 따라 작성자가 받는 것인지 신청자가 받는 것인지 구별해서 프린트 해줘야함
        button_alarmbox.setOnClickListener(new View.OnClickListener(){
            public void onClick(View view){
                status =1;
                refresh();
            }
        });
        connectFeed();
    }

    @Override
    public void refresh() {
        page = 1;
        endOfPage = false;
        adapter.clear();
        adapter.notifyDataSetChanged();
        connectFeed();
    }

    @Override
    public void reload() {

    }

    void connectFeed() {
        if(status==0) {
            for (int i = 0; i < 10; i++)
                adapter.addData(Food.mockFood(i));
            adapter.notifyDataSetChanged();
        } else if(status==1){
            for (int i = 0; i < 10; i++)
                adapter.addData(Food.alarm(i));
            adapter.notifyDataSetChanged();
        }  else {
            for (int i = 0; i < 10; i++)
                adapter.addData(Food.alarm_req(i));
            adapter.notifyDataSetChanged();
        }

    }
    public void startIntent(Intent intent){
        startActivity(intent);
    }

}
