package com.example.woojinroom.hangto;

import com.example.woojinroom.hangto.Model.joinUser;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Query;

/**
 * Created by woojinroom on 2017-10-15.
 */

public interface IDCheck {
    public static final String API_URL = "http://ec2-13-124-183-2.ap-northeast-2.compute.amazonaws.com:3000/";
    @GET("/user/check")
    Call<ResponseBody> getEmail(@Query("email") String email);

    @GET("/user/check")
    Call<ResponseBody> getNickname(@Query("nickname") String nickname);

    @FormUrlEncoded
    @POST("/user")
    Call<joinUser> getUserData(@Field("email") String email, @Field("password") String password, @Field("nickname") String nickname, @Field("sex") String sex, @Field("birth") String birth,
                               @Field("profileUrl") String prfileUrl, @Field("type") String type, @Field("languages") String languages, @Field("introduce") String intoriduce);
}
