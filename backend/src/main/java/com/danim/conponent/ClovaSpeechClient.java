//package com.danim.conponent;
//
//import org.apache.http.Header;
//import org.apache.http.HttpEntity;
//import org.apache.http.client.methods.CloseableHttpResponse;
//import org.apache.http.client.methods.HttpPost;
//import org.apache.http.entity.ContentType;
//import org.apache.http.entity.StringEntity;
//import org.apache.http.entity.mime.MultipartEntityBuilder;
//import org.apache.http.impl.client.CloseableHttpClient;
//import org.apache.http.impl.client.HttpClients;
//import org.apache.http.message.BasicHeader;
//import org.apache.http.util.EntityUtils;
//
//import java.nio.charset.StandardCharsets;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import com.google.gson.Gson;
//
//public class ClovaSpeechClient {
//    private static final String SECRET = "2b55b2aafc1042d397b61ecf8d8b02f8";
//    private static final String INVOKE_URL = "https://clovaspeech-gw.ncloud.com/external/v1/4727/a1cb39a867bbfba97b3aae4d6c961a9d8adbff7402de9b56b7371e3becfabcd9";
//
//    private CloseableHttpClient httpClient = HttpClients.createDefault();
//    private Gson gson = new Gson();
//
//    private static final Header[] HEADERS = new Header[] {
//            new BasicHeader("Accept", "application/json"),
//            new BasicHeader("X-CLOVASPEECH-API-KEY", SECRET),
//    };
//
//    public static class Diarization {
//        private Boolean enable = Boolean.FALSE;
//        private Integer speakerCountMin;
//        private Integer speakerCountMax;
//
//        public Boolean getEnable() {
//            return enable;
//        }
//
//        public void setEnable(Boolean enable) {
//            this.enable = enable;
//        }
//
//        public Integer getSpeakerCountMin() {
//            return speakerCountMin;
//        }
//
//        public void setSpeakerCountMin(Integer speakerCountMin) {
//            this.speakerCountMin = speakerCountMin;
//        }
//
//        public Integer getSpeakerCountMax() {
//            return speakerCountMax;
//        }
//
//        public void setSpeakerCountMax(Integer speakerCountMax) {
//            this.speakerCountMax = speakerCountMax;
//        }
//    }
//
//    public static class NestRequestEntity {
//        private String language = "ko-KR";
//        //completion optional, sync/async
//        private String completion = "sync";
//        //optional, used to receive the analyzed results
//        private String callback;
//        //optional, any data
//        private Map<String, Object> userdata;
//        private Boolean wordAlignment = Boolean.TRUE;
//        private Boolean fullText = Boolean.TRUE;
//        //comma separated words
//        private String forbiddens;
//        private Diarization diarization;
//
//        public String getLanguage() {
//            return language;
//        }
//
//        public void setLanguage(String language) {
//            this.language = language;
//        }
//
//        public String getCompletion() {
//            return completion;
//        }
//
//        public void setCompletion(String completion) {
//            this.completion = completion;
//        }
//
//        public String getCallback() {
//            return callback;
//        }
//
//        public Boolean getWordAlignment() {
//            return wordAlignment;
//        }
//
//        public void setWordAlignment(Boolean wordAlignment) {
//            this.wordAlignment = wordAlignment;
//        }
//
//        public Boolean getFullText() {
//            return fullText;
//        }
//
//        public void setFullText(Boolean fullText) {
//            this.fullText = fullText;
//        }
//
//        public void setCallback(String callback) {
//            this.callback = callback;
//        }
//
//        public Map<String, Object> getUserdata() {
//            return userdata;
//        }
//
//        public void setUserdata(Map<String, Object> userdata) {
//            this.userdata = userdata;
//        }
//
//        public String getForbiddens() {
//            return forbiddens;
//        }
//
//        public void setForbiddens(String forbiddens) {
//            this.forbiddens = forbiddens;
//        }
//
//        public Diarization getDiarization() {
//            return diarization;
//        }
//
//        public void setDiarization(Diarization diarization) {
//            this.diarization = diarization;
//        }
//    }
//
//    /**
//     *
//     * recognize media using a file
//     * @param file required, the media file
//     * @param nestRequestEntity optional
//     * @return string
//     */
//    public String upload(File file, NestRequestEntity nestRequestEntity) {
//        HttpPost httpPost = new HttpPost(INVOKE_URL + "/recognizer/upload");
//        httpPost.setHeaders(HEADERS);
//        HttpEntity httpEntity = MultipartEntityBuilder.create()
//                .addTextBody("params", gson.toJson(nestRequestEntity), ContentType.APPLICATION_JSON)
//                .addBinaryBody("media", file, ContentType.MULTIPART_FORM_DATA, file.getName())
//                .build();
//        httpPost.setEntity(httpEntity);
//        return execute(httpPost);
//    }
//
//    private String execute(HttpPost httpPost) {
//        try (final CloseableHttpResponse httpResponse = httpClient.execute(httpPost)) {
//            final HttpEntity entity = httpResponse.getEntity();
//            return EntityUtils.toString(entity, StandardCharsets.UTF_8);
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//    }
//
//    public static void main(String[] args) {
//        final ClovaSpeechClient clovaSpeechClient = new ClovaSpeechClient();
//        NestRequestEntity requestEntity = new NestRequestEntity();
//        final String result =
//                clovaSpeechClient.upload(new File("/data/sample.mp4"), requestEntity);
//        //final String result = clovaSpeechClient.url("file URL", requestEntity);
//        //final String result = clovaSpeechClient.objectStorage("Object Storage key", requestEntity);
//        System.out.println(result);
//    }
//}
