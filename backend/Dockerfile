FROM adoptopenjdk/openjdk11:latest
ENV	SPRING_PROFILES_ACTIVE=dev
#CMD ["./gradlew", "clean", "build"]
COPY build/libs/*.jar wear.jar
ENTRYPOINT ["java","-jar","/wear.jar"]
EXPOSE 8080
