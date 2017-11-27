package com.example.woojinroom.hangto.TabActivity;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;
import android.view.ViewGroup;

import com.example.woojinroom.hangto.TabActivity.ParentFragment.TabParentFragment;
import com.example.woojinroom.hangto.TabActivity.Tab1_Main.Tab1MainFragment;
import com.example.woojinroom.hangto.TabActivity.Tab3_Message.Tab3MessageFragment;
import com.example.woojinroom.hangto.TabActivity.Tab2_Recommend.Tab2RecommendFragment;
import com.example.woojinroom.hangto.TabActivity.Tab4_MyPage.Tab4MyPageFragment;


import java.util.ArrayList;

/**
 * Created by kksd0900 on 16. 10. 11..
 */
public class BottomTabPagerAdapter extends FragmentPagerAdapter {

    private ArrayList<Fragment> fragments = new ArrayList<>();
    private TabParentFragment currentFragment;

    public BottomTabPagerAdapter(FragmentManager fm) {
        super(fm);

        fragments.clear();
        fragments.add(Tab1MainFragment.newInstance(0));
        fragments.add(Tab2RecommendFragment.newInstance(1));
//        fragments.add(Tab3StatisFragment.newInstance(2));
        fragments.add(Tab3MessageFragment.newInstance(3));
        fragments.add(Tab4MyPageFragment.newInstance(4));
    }

    @Override
    public TabParentFragment getItem(int position) {
        return (TabParentFragment) fragments.get(position);
    }

    @Override
    public int getCount() {
        return fragments.size();
    }

    @Override
    public void setPrimaryItem(ViewGroup container, int position, Object object) {
        if (getCurrentFragment() != object) {
            currentFragment = ((TabParentFragment) object);
        }
        super.setPrimaryItem(container, position, object);
    }

    /**
     * Get the current fragment
     */
    public TabParentFragment getCurrentFragment() {
        return currentFragment;
    }
}
