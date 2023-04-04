package com.danim.conponent;

import com.danim.dto.WordInfo;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
//import com.squareup.okhttp.*;
import okhttp3.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.client.methods.RequestBuilder;
import org.springframework.http.MediaType;
import org.springframework.http.client.MultipartBodyBuilder;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@Slf4j
public class Http {
    public static final MediaType MEDIA_TYPE_MARKDOWN
            = MediaType.parseMediaType("multipart/form-data");

    private final OkHttpClient client = new OkHttpClient();
    public ResponseBody Post(String toUrl, String method, List<WordInfo> words, MultipartFile voice) throws Exception {
        OkHttpClient client = new OkHttpClient();
        log.info("data info : {}",voice.getContentType());
        Gson gson = new Gson();
        JsonObject jsonObject = new JsonObject();
        jsonObject.addProperty("words",gson.toJson(words));
        jsonObject.addProperty("voice",gson.toJson(voice));
        RequestBody formBody = new FormBody.Builder()
                .add("words", gson.toJson(words))
                .add("voice",gson.toJson(voice))
                .build();
        Request request = new Request.Builder()
                .url(toUrl)
                .post(formBody)
                .build();


        Response response = client.newCall(request).execute();
        if(!response.isSuccessful())throw new ConnectException();
        ResponseBody body = response.body();
        log.info("flask api info : {}",body);
        return body;
    }
}
