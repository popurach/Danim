//package com.danim.utils;
//
//import org.springframework.web.multipart.MultipartFile;
//
//import javax.sound.sampled.AudioInputStream;
//import javax.sound.sampled.AudioSystem;
//import javax.sound.sampled.UnsupportedAudioFileException;
//
//import java.io.IOException;
//import java.io.InputStream;
//
//
//public class VoiceUtils {
//    public static long extractVoiceLength(MultipartFile voiceFile) throws IOException, UnsupportedAudioFileException {
//        InputStream voiceInputStream = voiceFile.getInputStream();
//        AudioInputStream audioInputStream = AudioSystem.getAudioInputStream(voiceInputStream);
//        long durationMillis = (long) (audioInputStream.getFrameLength() * 1000.0 / audioInputStream.getFormat().getFrameRate());
//
//        return durationMillis;
//    }
//}
