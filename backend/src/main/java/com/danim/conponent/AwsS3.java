package com.danim.conponent;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.util.UUID;

@Slf4j
@RequiredArgsConstructor
@Component
public class AwsS3 {
    private final AmazonS3Client amazonS3Client;
    @Value("${cloud.aws.s3.bucket}")
    private String bucket;
    public String upload(MultipartFile file,String directoryName)throws Exception{

        String originalName = file.getOriginalFilename();
        String uploadPath = directoryName;
        String uploadFileName = UUID.randomUUID().toString()+"."+originalName.substring(originalName.indexOf(".")+1);
        String uploadUrl = "";
        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentLength(file.getSize());
        objectMetadata.setContentType(file.getContentType());
        String keyname =uploadPath+"/"+uploadFileName;
        amazonS3Client.putObject(new PutObjectRequest(bucket,keyname,file.getInputStream(),objectMetadata).withCannedAcl(CannedAccessControlList.PublicRead));
        uploadUrl = amazonS3Client.getUrl(bucket,keyname).toString();
        return uploadUrl;
    }
}
