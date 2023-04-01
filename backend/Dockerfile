# openjdk-11-jdk 가져오기
FROM openjdk:11-jdk

WORKDIR /opt/app

COPY ./ /opt/app

COPY --from=build /opt/app/target/*.jar app.jar

# 5000번 포트 노출
ENV PORT 5001
EXPOSE $PORT


# jar 파일 실행(= BE 서버 실행)
ENTRYPOINT ["java", "-jar", "app.jar"]
