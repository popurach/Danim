package com.danim.service;

//import com.amazonaws.services.s3.AmazonS3;

import com.danim.conponent.AwsS3;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.repository.PhotoRepository;
import com.danim.repository.PostRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Log4j2
@Service
@RequiredArgsConstructor
public class PhotoServiceImpl implements PhotoService {
    private final AwsS3 awsS3;
    private final PhotoRepository photoRepository;
    private final PostRepository postRepository;


    @Override
    public Photo createPhoto(MultipartFile imageFile, Post savedPost) throws Exception {
        // imageFile S3에 올리고 imageURL 가져오기
        String photoUrl = awsS3.upload(imageFile, "Post");

        // image metadata에서 lat,lng 지역 정보 가져오기
//        HashMap<String, Double> location = ImageUtils.extractLocationFromImage(imageFile);
//        double lat = location.get("latitude");
//        double lng = location.get("longitude");

        // photo 객체 생성
        log.info("Starting savePhoto transaction");
        Photo photo = Photo.builder()
                .postId(savedPost)
                .photoUrl(photoUrl)
                .lat(23.23)
                .lng(23.23)
                .build();
        photoRepository.save(photo);
        log.info("Transaction complete");
        return photo;
    }

    ;

    // 파일 s3 서버에 올리는 메서드
//    private String uploadFileToS3(MultipartFile file, String key) throws IOException {
//        String bucketName = "my-bucket-name"; // 버킷 생성 후 수정 필요
//        s3Client.putObject(bucketName, key, file.getInputStream(), null);
//        return s3Client.getUrl(bucketName, key).toString();
//    }

//    @Override
//    public List<Photo> findByPostId(Long postId) throws Exception{
//        List<Photo> photoList = photoRepository.findByPostId(postId);
//        return photoList;
//    }


}
