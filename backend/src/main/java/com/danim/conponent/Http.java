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
    public static final MediaType MEDIA_TYPE = MediaType.parseMediaType("audio/wav");

    private final OkHttpClient client = new OkHttpClient();

    public ResponseBody Post(String toUrl, String method, List<WordInfo> words, File voice) throws Exception {
        OkHttpClient client = new OkHttpClient();
        Gson gson = new Gson();
        RequestBody formBody = new MultipartBody.Builder()
                .setType(MultipartBody.FORM)
                .addFormDataPart("words", gson.toJson(words))

//                .addFormDataPart("voice",new File("test.wav")))
                .addFormDataPart("file", "voicefile", RequestBody.create(okhttp3.MediaType.parse("audio/wav"), voice))
                .build();


        Request request = new Request.Builder()
                .url(toUrl)
                .post(formBody)
                .build();


        Response response = client.newCall(request).execute();
        if (!response.isSuccessful()) throw new ConnectException();
        ResponseBody body = response.body();
        log.info("flask api info : {}", body);
        return body;
    }
}
