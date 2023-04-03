package com.danim.utils;

import com.danim.entity.Nation;
import com.danim.entity.Photo;
import com.danim.entity.Post;
import com.danim.entity.TimeLine;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

public class PostDataGenerator {
    private static final int NUM_POSTS = 100000;
    private static final String[] ADDRESSES = {"Seoul", "Busan", "Daegu", "Incheon", "Gwangju"};
    private static final String[] NATIONS = {"Korea", "Japan", "China", "USA", "Canada"};
    private static final Random RANDOM = new Random();

    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("your_persistence_unit_name");
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();

        for (int i = 0; i < NUM_POSTS; i++) {
            Post post = new Post();
            post.setVoiceUrl("https://example.com/voice/" + UUID.randomUUID().toString() + ".wav");
            post.setVoiceLength(RANDOM.nextDouble() * 60);
            post.setNationUrl("https://example.com/nation/" + NATIONS[RANDOM.nextInt(NATIONS.length)] + ".png");
            post.setAddress1(NATIONS[RANDOM.nextInt(NATIONS.length)]);
            post.setAddress2(ADDRESSES[RANDOM.nextInt(ADDRESSES.length)]);
            post.setAddress3(ADDRESSES[RANDOM.nextInt(ADDRESSES.length)]);
            post.setAddress4(ADDRESSES[RANDOM.nextInt(ADDRESSES.length)]);
            post.setText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");

//            TimeLine timeline = em.find(TimeLine.class, RANDOM.nextLong());
            TimeLine timeline = em.find(TimeLine.class, 1);
            System.out.println("timeline"+timeline);
            post.setTimelineId(timeline);

            Nation nation = em.find(Nation.class, 1);
            post.setNationId(nation);

            List<Photo> photoList = new ArrayList<>();
            for (int j = 0; j < RANDOM.nextInt(5); j++) {
                Photo photo = new Photo();
                photo.setPhotoUrl("https://example.com/photo/" + UUID.randomUUID().toString() + ".png");
                photoList.add(photo);
            }
            post.setPhotoList(photoList);

            em.persist(post);
        }

        em.getTransaction().commit();
        em.close();
        emf.close();
    }
}
